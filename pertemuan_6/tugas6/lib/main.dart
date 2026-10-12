import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Pilihan warna aksen yang tersedia di halaman Pengaturan.
const pilihanWarna = <Color>[
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];

// Data destinasi wisata untuk katalog.
const daftarWisata = <Wisata>[
  Wisata(
    id: 'raja-ampat',
    nama: 'Raja Ampat',
    lokasi: 'Papua Barat Daya',
    deskripsi:
    'Raja Ampat terkenal dengan gugusan pulau karst, laut jernih, dan keanekaragaman biota laut. Tempat ini cocok untuk menikmati pemandangan alam dan snorkeling.',
    ikon: Icons.sailing,
  ),
  Wisata(
    id: 'borobudur',
    nama: 'Candi Borobudur',
    lokasi: 'Magelang, Jawa Tengah',
    deskripsi:
    'Candi Borobudur merupakan warisan budaya dengan relief dan stupa yang menjadi daya tarik wisata sejarah dan budaya.',
    ikon: Icons.account_balance,
  ),
  Wisata(
    id: 'bromo',
    nama: 'Gunung Bromo',
    lokasi: 'Jawa Timur',
    deskripsi:
    'Gunung Bromo menawarkan pemandangan pegunungan, lautan pasir, dan matahari terbit yang menjadi favorit wisatawan.',
    ikon: Icons.landscape,
  ),
  Wisata(
    id: 'danau-toba',
    nama: 'Danau Toba',
    lokasi: 'Sumatera Utara',
    deskripsi:
    'Danau Toba adalah danau vulkanik besar dengan pemandangan perbukitan dan budaya lokal yang menarik untuk dijelajahi.',
    ikon: Icons.water,
  ),
];

// Model data untuk satu destinasi wisata.
class Wisata {
  final String id;
  final String nama;
  final String lokasi;
  final String deskripsi;
  final IconData ikon;

  const Wisata({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.deskripsi,
    required this.ikon,
  });
}

// Controller untuk menyimpan dan mengatur tema aplikasi.
class AppThemeController extends ChangeNotifier {
  static const String _darkKey = 'isDarkMode';
  static const String _colorKey = 'themeColor';

  bool isDark = false;
  int seedColor = Colors.indigo.value;

  // Membaca tema yang pernah disimpan ketika aplikasi dibuka.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool(_darkKey) ?? false;
    seedColor = prefs.getInt(_colorKey) ?? Colors.indigo.value;
    notifyListeners();
  }

  // Mengubah mode terang/gelap lalu menyimpannya.
  Future<void> toggleDarkMode(bool value) async {
    isDark = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkKey, value);
    notifyListeners();
  }

  // Mengubah warna aksen lalu menyimpannya.
  Future<void> changeColor(Color color) async {
    seedColor = color.value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorKey, seedColor);
    notifyListeners();
  }
}

// Membuat tema terang atau gelap dari warna pilihan pengguna.
ThemeData buatTema(Color seed, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seed,
    brightness: brightness,
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}

Future<void> main() async {
  // Menyiapkan Flutter sebelum menggunakan SharedPreferences.
  WidgetsFlutterBinding.ensureInitialized();

  // Membuat controller dan memuat tema tersimpan.
  final themeController = AppThemeController();
  await themeController.load();

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final AppThemeController themeController;

  const MyApp({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    // Memperbarui MaterialApp saat tema berubah.
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, _) {
        return MaterialApp(
          title: 'Galeri Wisata Indonesia',
          debugShowCheckedModeBanner: false,
          theme: buatTema(
            Color(themeController.seedColor),
            Brightness.light,
          ),
          darkTheme: buatTema(
            Color(themeController.seedColor),
            Brightness.dark,
          ),
          themeMode:
          themeController.isDark ? ThemeMode.dark : ThemeMode.light,

          // Named route utama dan route detail.
          initialRoute: '/',
          routes: {
            '/': (_) => ShellPage(themeController: themeController),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/detail') {
              // Argumen route berisi objek Wisata yang dipilih.
              final wisata = settings.arguments as Wisata;
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => DetailPage(wisata: wisata),
              );
            }
            return null;
          },
        );
      },
    );
  }
}

// Kerangka aplikasi yang menyediakan tiga tab.
class ShellPage extends StatefulWidget {
  final AppThemeController themeController;

  const ShellPage({super.key, required this.themeController});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final halaman = <Widget>[
      BerandaTab(onOpenDetail: _bukaDetail),
      const KatalogTab(),
      PengaturanTab(themeController: widget.themeController),
    ];

    const judul = ['Beranda', 'Katalog', 'Pengaturan'];

    return Scaffold(
      appBar: AppBar(title: Text(judul[_index])),
      body: IndexedStack(
        index: _index,
        children: halaman,
      ),

      // NavigationBar memenuhi ketentuan minimal tiga tab.
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) {
          setState(() => _index = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_library_outlined),
            selectedIcon: Icon(Icons.photo_library),
            label: 'Katalog',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }

  // Membuka detail memakai named route dan mengirim argumen wisata.
  void _bukaDetail(Wisata wisata) {
    Navigator.pushNamed(context, '/detail', arguments: wisata);
  }
}

class BerandaTab extends StatelessWidget {
  final ValueChanged<Wisata> onOpenDetail;

  const BerandaTab({super.key, required this.onOpenDetail});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Jelajahi Indonesia',
          style: tema.textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Temukan destinasi alam dan budaya favoritmu.',
          style: tema.textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        for (final wisata in daftarWisata.take(3))
          Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Hero(
                tag: 'wisata-${wisata.id}',
                child: CircleAvatar(
                  radius: 28,
                  child: Icon(wisata.ikon, size: 30),
                ),
              ),
              title: Text(
                wisata.nama,
                style: tema.textTheme.titleMedium,
              ),
              subtitle: Text(wisata.lokasi),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => onOpenDetail(wisata),
            ),
          ),
        const SizedBox(height: 12),
        Text(
          'Pilih destinasi untuk melihat detailnya.',
          style: tema.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class KatalogTab extends StatefulWidget {
  const KatalogTab({super.key});

  @override
  State<KatalogTab> createState() => _KatalogTabState();
}

class _KatalogTabState extends State<KatalogTab>
    with SingleTickerProviderStateMixin {
  bool _besar = false;
  late final AnimationController _putar;

  @override
  void initState() {
    super.initState();

    // Animasi eksplisit: AnimationController memutar ikon berulang kali.
    _putar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    // Melepaskan controller agar tidak terjadi kebocoran sumber daya.
    _putar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Katalog Destinasi', style: tema.textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          'Tekan tombol untuk melihat perubahan animasi implisit.',
          style: tema.textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),

        // Animasi implisit: AnimatedContainer mengubah ukuran dengan halus.
        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: _besar ? 220 : 150,
            height: _besar ? 110 : 80,
            decoration: BoxDecoration(
              color: tema.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(_besar ? 32 : 12),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.explore,
              size: _besar ? 54 : 40,
              color: tema.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: FilledButton(
            onPressed: () => setState(() => _besar = !_besar),
            child: Text(_besar ? 'Kecilkan' : 'Besarkan'),
          ),
        ),
        const Divider(height: 32),

        // Animasi eksplisit: ikon berputar dengan AnimationController.
        Row(
          children: [
            RotationTransition(
              turns: _putar,
              child: Icon(
                Icons.public,
                size: 40,
                color: tema.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Menjelajahi destinasi Indonesia',
                style: tema.textTheme.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('Semua destinasi', style: tema.textTheme.titleLarge),
        const SizedBox(height: 8),

        // Daftar katalog dibuat dari objek wisata.
        for (final wisata in daftarWisata)
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(wisata.ikon)),
              title: Text(wisata.nama),
              subtitle: Text(wisata.lokasi),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Membuka halaman detail melalui named route.
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: wisata,
                );
              },
            ),
          ),
      ],
    );
  }
}

class DetailPage extends StatelessWidget {
  final Wisata wisata;

  const DetailPage({super.key, required this.wisata});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(wisata.nama)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Hero menggunakan tag yang sama dengan halaman sebelumnya.
          Center(
            child: Hero(
              tag: 'wisata-${wisata.id}',
              child: CircleAvatar(
                radius: 64,
                child: Icon(wisata.ikon, size: 64),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(wisata.nama, style: tema.textTheme.headlineMedium),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: tema.colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  wisata.lokasi,
                  style: tema.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Tentang destinasi', style: tema.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(wisata.deskripsi, style: tema.textTheme.bodyLarge),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Kembali ke galeri'),
          ),
        ],
      ),
    );
  }
}

class PengaturanTab extends StatelessWidget {
  final AppThemeController themeController;

  const PengaturanTab({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Tampilan Aplikasi', style: tema.textTheme.headlineSmall),
        const SizedBox(height: 12),

        // Switch mengubah tema terang atau gelap.
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Mode gelap'),
          subtitle: const Text('Simpan pilihan tema untuk penggunaan berikutnya'),
          value: themeController.isDark,
          onChanged: themeController.toggleDarkMode,
        ),
        const Divider(height: 28),
        Text('Warna aksen', style: tema.textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          'Pilih salah satu warna di bawah ini.',
          style: tema.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),

        // Tiga atau lebih pilihan warna disediakan dari pilihanWarna.
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final color in pilihanWarna)
              Semantics(
                label: 'Pilih warna ${color.toString()}',
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => themeController.changeColor(color),
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: color,
                    child: themeController.seedColor == color.value
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
