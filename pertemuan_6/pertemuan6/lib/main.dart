import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Menyimpan pengaturan aplikasi.

const pilihanWarna = [
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];

ThemeData buatTema(Color seed, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seed,
    brightness: brightness,
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}

//void main() => runApp(const MyApp());

Future<void> main() async {
  // Memastikan Flutter siap sebelum menggunakan plugin.
  WidgetsFlutterBinding.ensureInitialized();

  // Membuat pengelola tema.
  final themeController = AppThemeController();

  // Membaca tema yang tersimpan sebelum aplikasi dibuka.
  await themeController.load();

  // Menjalankan aplikasi dengan pengaturan yang sudah dimuat.
  runApp(MyApp(themeController: themeController));
}


//class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  //@override
  //Widget build(BuildContext context) {
    //return ListenableBuilder(
      //listenable: Listenable.merge([themeMode, seedColor]),
      //builder: (context, _) {
        //return MaterialApp(
          //title: 'Praktikum 6',
          //debugShowCheckedModeBanner: false,
          //theme: buatTema(seedColor.value, Brightness.light),
          //darkTheme: buatTema(seedColor.value, Brightness.dark),
          //themeMode: themeMode.value,
          //home: Scaffold(
            //appBar: AppBar(title: const Text('Tema')),
            //body: const PengaturanTab(),
          //initialRoute: '/',
          //routes: { '/': (_) =>
              //Scaffold(
                //appBar: AppBar(title: const Text('Shell')),
                //body: const ShellPage(),
              //),
          //},
          //onGenerateRoute: (settings) {
            //if (settings.name == '/detail') {
              //final item = settings.arguments as Item;
              //return MaterialPageRoute(
                //builder: (_) => DetailPage(item: item), settings: settings,);
            //}
            //return null;
          //},
        //);
        //);
      //},
    //);
  //}
//}

class MyApp extends StatelessWidget {
  // Menerima pengelola tema yang sudah dimuat oleh main().
  final AppThemeController themeController;

  const MyApp({
    super.key,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      // Memperbarui MaterialApp saat mode atau warna tema berubah.
      listenable: themeController,
      builder: (context, _) {
        return MaterialApp(
          title: 'Praktikum 6',
          debugShowCheckedModeBanner: false,

          // Tema terang mengikuti warna yang dipilih pengguna.
          theme: buatTema(
            Color(themeController.seedColor),
            Brightness.light,
          ),

          // Tema gelap mengikuti warna yang dipilih pengguna.
          darkTheme: buatTema(
            Color(themeController.seedColor),
            Brightness.dark,
          ),

          // Memilih tema terang atau gelap.
          themeMode: themeController.isDark
              ? ThemeMode.dark
              : ThemeMode.light,

          // Route utama membuka ShellPage.
          initialRoute: '/',
          routes: {
            '/': (_) => ShellPage(
              themeController: themeController,
            ),
          },

          // Route detail menggunakan animasi fade.
          onGenerateRoute: (settings) {
            if (settings.name == '/detail') {
              // Mengambil objek Item yang dikirim dari BerandaTab.
              final item = settings.arguments as Item;

              return PageRouteBuilder(
                settings: settings,
                pageBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    ) {
                  // Halaman yang akan ditampilkan.
                  return DetailPage(item: item);
                },
                transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                    ) {
                  // Halaman muncul secara perlahan.
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(
                  milliseconds: 400,
                ),
              );
            }

            // Route yang tidak ditangani diteruskan ke onUnknownRoute.
            return null;
          },

          // Menampilkan halaman 404 jika route tidak dikenal.
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              settings: settings,
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Halaman Tidak Ditemukan'),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 80,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '404 - Halaman tidak ditemukan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Kembali ke halaman sebelumnya.
                            Navigator.pop(context);
                          },
                          child: const Text('Kembali'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}


//class PengaturanTab extends StatelessWidget {
  //const PengaturanTab({super.key});

  //@override
  //Widget build(BuildContext context) {
    //return ListenableBuilder(
      //listenable: Listenable.merge([themeMode, seedColor]),
      //builder: (context, _) {
        //return ListView(
          //padding: const EdgeInsets.all(16),
          //children: [
            //SwitchListTile(
              //title: const Text('Mode gelap'),
              //value: themeMode.value == ThemeMode.dark,
              //onChanged: (v) {
                //themeMode.value = v ? ThemeMode.dark : ThemeMode.light;
              //},
            //),
            //const SizedBox(height: 8),
            //Text('Warna tema', style: Theme.of(context).textTheme.titleMedium),
            //const SizedBox(height: 8),
            //Wrap(
              //spacing: 12,
              //children: [
                //for (final c in pilihanWarna)
                  //GestureDetector(
                    //onTap: () => seedColor.value = c,
                    //child: CircleAvatar(
                      //backgroundColor: c,
                      //child: seedColor.value == c
                      //    ? const Icon(Icons.check, color: Colors.white)
                    //      : null,
                  //  ),
                //  ),
              //],
            //),
          //],
        //);
      //},
    //);
  //}
//}

class PengaturanTab extends StatelessWidget {
  // Controller yang sama dengan yang digunakan oleh MyApp.
  final AppThemeController themeController;

  const PengaturanTab({
    super.key,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      // Memantau perubahan pengaturan tema.
      listenable: themeController,
      builder: (context, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: const Text('Mode gelap'),
              // Membaca status mode gelap dari controller.
              value: themeController.isDark,
              onChanged: (value) {
                // Mengubah sekaligus menyimpan mode gelap.
                themeController.toggleDarkMode(value);
              },
            ),

            const SizedBox(height: 8),

            Text(
              'Warna tema',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              children: [
                for (final color in pilihanWarna)
                  GestureDetector(
                    onTap: () {
                      // Mengubah sekaligus menyimpan warna pilihan.
                      themeController.changeColor(color);
                    },
                    child: CircleAvatar(
                      backgroundColor: color,
                      child: themeController.seedColor == color.value
                          ? const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}


class Item {
  final String nama;
  final IconData ikon;
  final Color warna;

  const Item(this.nama, this.ikon, this.warna);
}

const daftarItem = [
  Item('Flutter', Icons.flutter_dash, Colors.blue),
  Item('Musik', Icons.music_note, Colors.pink),
  Item('Kamera', Icons.camera_alt, Colors.orange),
  Item('Peta', Icons.map, Colors.green),
];

class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: daftarItem.length,
      itemBuilder: (context, i) {
        final item = daftarItem[i];
        return ListTile(
          leading: Hero(
            tag: 'ikon-${item.nama}',
            child: CircleAvatar(
              backgroundColor: item.warna,
              child: Icon(item.ikon, color: Colors.white),
            ),
          ),
          title: Text(item.nama),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.pushNamed(context, '/detail', arguments: item);
          },
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  final Item item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(item.nama)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'ikon-${item.nama}',
              child: CircleAvatar(
                radius: 64,
                backgroundColor: item.warna,
                child: Icon(item.ikon, size: 64, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(item.nama, style: tema.textTheme.headlineMedium),
            Text('Detail untuk ${item.nama}', style: tema.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class AnimasiTab extends StatefulWidget {
  const AnimasiTab({super.key});

  @override
  State<AnimasiTab> createState() => _AnimasiTabState();
}

class _AnimasiTabState extends State<AnimasiTab>
    with SingleTickerProviderStateMixin {
  // bool _besar = false;
  // int _hitung = 0;
  // late final AnimationController _putar;
  bool _besar = false; // Mengatur ukuran dan bentuk kotak.
  int _hitung = 0; // Menyimpan angka yang ditampilkan.
  bool _showCard = true; // Mengatur tampil atau pudarnya kartu.
  late final AnimationController _putar; // Mengontrol putaran ikon.

  @override
  void initState() {
    super.initState();
    _putar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _putar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('1. AnimatedContainer', style: tema.textTheme.titleMedium),
        const SizedBox(height: 8),
        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: _besar ? 200 : 100,
            height: 100,
            decoration: BoxDecoration(
              color: _besar ? warna.primary : warna.tertiary,
              borderRadius: BorderRadius.circular(_besar ? 50 : 8),
            ),
          ),
        ),
        TextButton(
          onPressed: () => setState(() => _besar = !_besar),
          child: const Text('Ubah bentuk'),
        ),
        const Divider(),
        Text('2. AnimatedSwitcher', style: tema.textTheme.titleMedium),
        Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) {
              return ScaleTransition(scale: anim, child: child);
            },
            child: Text(
              '$_hitung',
              key: ValueKey(_hitung),
              style: tema.textTheme.displayMedium,
            ),
          ),
        ),
        TextButton(
          onPressed: () => setState(() => _hitung++),
          child: const Text('Tambah'),
        ),
        const Divider(),
        Text('3. AnimationController', style: tema.textTheme.titleMedium),
        const SizedBox(height: 8),
        Center(
          child: RotationTransition(
            turns: _putar,
            child: Icon(Icons.settings, size: 64, color: warna.primary),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_putar.isAnimating) {
              _putar.stop();
            } else {
              _putar.repeat();
            }
            setState(() {});
          },
          child: Text(_putar.isAnimating ? 'Berhenti' : 'Putar'),
        ),

        const Divider(),

// Demo keempat: AnimatedOpacity.
        Text(
          '4. AnimatedOpacity',
          style: tema.textTheme.titleMedium,
        ),

        const SizedBox(height: 8),

// Mengatur transparansi kartu secara bertahap.
        AnimatedOpacity(
          opacity: _showCard ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 40,
                    color: warna.primary,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kartu Animasi',
                          style: tema.textTheme.titleMedium,
                        ),
                        const Text(
                          'Kartu memudar dan muncul kembali.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

// Tombol untuk menghilangkan atau menampilkan kartu.
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showCard = !_showCard; // Membalik status kartu.
            });
          },
          child: Text(
            _showCard ? 'Sembunyikan Kartu' : 'Tampilkan Kartu',
          ),
        ),

      ],
    );
  }
}


class ShellPage extends StatefulWidget {
  // Controller diteruskan ke halaman Pengaturan.
  final AppThemeController themeController;

  const ShellPage({
    super.key,
    required this.themeController,
  });

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0; // Tab yang sedang dipilih.

  // Daftar halaman yang ditampilkan sesuai indeks.
  late final List<Widget> _halaman = [
    const BerandaTab(),
    const AnimasiTab(),
    PengaturanTab(
      themeController: widget.themeController,
    ),
  ];

  // Judul dan ikon disusun sesuai urutan halaman.
  static const _judul = [
    'Beranda',
    'Animasi',
    'Pengaturan',
  ];

  static const _ikon = [
    Icons.home_outlined,
    Icons.animation,
    Icons.settings_outlined,
  ];

  // Berpindah halaman sekaligus menutup Drawer.
  void _pilihTab(int index) {
    setState(() {
      _index = index;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_index]),
      ),

      // Drawer adalah menu navigasi di sisi kiri.
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Praktikum 6',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Membuat menu sesuai daftar halaman.
            for (int i = 0; i < _judul.length; i++)
              ListTile(
                leading: Icon(_ikon[i]),
                title: Text(_judul[i]),
                selected: _index == i,
                onTap: () => _pilihTab(i),
              ),
          ],
        ),
      ),

      // Menjaga state setiap tab ketika pengguna berpindah.
      body: IndexedStack(
        index: _index,
        children: _halaman,
      ),

      // Navigasi bawah yang sudah ada tetap dipertahankan.
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) {
          setState(() {
            _index = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.animation),
            label: 'Animasi',
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
}


class AppThemeController extends ChangeNotifier {
  // Key untuk menyimpan pengaturan di shared_preferences.
  static const String _darkKey = 'isDarkMode';
  static const String _colorKey = 'themeColor';

  // Nilai awal: mode terang dan warna biru.
  bool isDark = false;
  int seedColor = Colors.indigo.value;

  // Membaca pengaturan yang tersimpan saat aplikasi dimulai.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    isDark = prefs.getBool(_darkKey) ?? false;
    seedColor = prefs.getInt(_colorKey) ?? Colors.indigo.value;

    notifyListeners(); // Memberi tahu widget bahwa tema sudah dimuat.
  }

  // Mengubah mode gelap sekaligus menyimpannya.
  Future<void> toggleDarkMode(bool value) async {
    isDark = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkKey, value);

    notifyListeners(); // Memperbarui tampilan aplikasi.
  }

  // Mengubah warna tema sekaligus menyimpannya.
  Future<void> changeColor(Color color) async {
    seedColor = color.value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorKey, seedColor);

    notifyListeners(); // Menerapkan warna tema baru.
  }
}
