README Praktikum Pemrograman Mobile — Pertemuan 6
## Tema, Routing, Navigasi, dan Animasi pada Flutter

## 1. Pendahuluan

Pertemuan 6 membahas cara mengatur tampilan aplikasi menggunakan tema, berpindah halaman dengan routing dan navigasi, serta membuat antarmuka lebih menarik menggunakan animasi. Materi tersebut kemudian diterapkan dalam aplikasi 
README ini merangkum konsep materi, penggalan kode penting, fungsi setiap kode, dan penerapannya dalam aplikasi. Nama class atau variabel pada contoh bisa berbeda dari nama yang digunakan di file proyek, tetapi konsep penggunaannya sama.

## 2. Tujuan Pembelajaran

Setelah mempelajari materi ini, mahasiswa diharapkan mampu:

1. Mengatur tema terang dan gelap dengan `ThemeData`.
2. Menggunakan `Theme.of(context)` agar warna dan teks mengikuti tema aplikasi.
3. Mengganti tema dan warna aksen melalui state/controller.
4. Menyimpan pilihan tema agar tetap digunakan setelah aplikasi dibuka kembali.
5. Memahami navigasi antartampilan menggunakan `Navigator`.
6. Menggunakan named routes untuk membuka halaman tertentu.
7. Mengirim data ke halaman detail melalui `arguments`.
8. Membuat navigasi beberapa tab menggunakan `NavigationBar`.
9. Membuat transisi elemen ant halaman menggunakan `Hero`.
10. Menerapkan animasi implisit dan eksplisit di Flutter.

---

# BAGIAN A — THEME / TEMA APLIKASI

## 3. Apa Itu Theme?

Theme adalah kumpulan pengaturan visual yang dipakai bersama oleh widget dalam aplikasi, misalnya warna utama, warna latar, gaya teks, dan tampilan AppBar. Dengan tema, tampilan dapat dibuat konsisten tanpa mengatur warna dan gaya satu per satu pada setiap widget.

Flutter menyediakan `ThemeData` untuk menentukan tema dan `Theme.of(context)` untuk mengambil tema yang sedang aktif.

## 4. Membuat ThemeData

Contoh kode:

```dart
// Membuat tema berdasarkan warna aksen dan tingkat kecerahan.
ThemeData buatTema(Color seed, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seed,
    brightness: brightness,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
  );
}
```

Penjelasan:

- `ThemeData` berisi konfigurasi tampilan aplikasi.
- `useMaterial3: true` menggunakan gaya Material Design 3.
- `colorSchemeSeed: seed` membuat skema warna berdasarkan warna pilihan.
- `brightness` menentukan apakah tema terang (`Brightness.light`) atau gelap (`Brightness.dark`).
- `appBarTheme` mengatur tampilan AppBar, dalam contoh ini judul dibuat berada di tengah.

Fungsi `buatTema()` dapat dipakai untuk membangun tema terang dan gelap dengan warna aksen yang sama.

## 5. Menggunakan Theme.of(context)

Contoh:

```dart
@override
Widget build(BuildContext context) {
  // Mengambil tema yang sedang aktif.
  final tema = Theme.of(context);

  return Text(
    'Jelajahi Indonesia',
    style: tema.textTheme.headlineMedium,
  );
}
```

Penjelasan:

- `Theme.of(context)` mengambil tema yang aktif pada lokasi widget tersebut.
- `textTheme.headlineMedium` mengambil gaya teks dari tema.
- Jika tema berubah, widget dapat menampilkan gaya yang sesuai dengan tema baru.

Untuk warna, gunakan warna dari skema tema:

```dart
// Mengambil warna dari skema tema aktif.
final warna = Theme.of(context).colorScheme;

Icon(
  Icons.explore,
  color: warna.primary,
);
```

Contoh latar atau kartu yang mengikuti tema:

```dart
Card(
  color: Theme.of(context).colorScheme.surface,
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Kartu destinasi'),
  ),
);
```

**Manfaat:** penggunaan `Theme.of(context)` membuat aplikasi konsisten dan lebih mudah mendukung tema terang/gelap. Hindari menetapkan warna hard-coded untuk teks atau latar yang seharusnya mengikuti tema. Warna khusus untuk data atau ilustrasi tertentu tetap bisa digunakan bila memang diperlukan.

## 6. ThemeMode: Terang dan Gelap

`MaterialApp` memiliki properti `theme`, `darkTheme`, dan `themeMode`.

```dart
MaterialApp(
  // Tema saat mode terang.
  theme: buatTema(
    Color(themeController.seedColor),
    Brightness.light,
  ),

  // Tema saat mode gelap.
  darkTheme: buatTema(
    Color(themeController.seedColor),
    Brightness.dark,
  ),

  // Memilih tema berdasarkan pengaturan pengguna.
  themeMode: themeController.isDark
      ? ThemeMode.dark
      : ThemeMode.light,
);
```

Penjelasan:

- `theme` mendefinisikan tema terang.
- `darkTheme` mendefinisikan tema gelap.
- `themeMode` memilih tema yang sedang digunakan.
- Operator kondisi `? :` memilih `ThemeMode.dark` ketika `isDark` bernilai `true`, selain itu menggunakan `ThemeMode.light`.

## 7. Mengatur Tema dengan ChangeNotifier

Untuk menyimpan status tema dan memberi tahu widget saat nilainya berubah, kita dapat memakai `ChangeNotifier`.

```dart
class AppThemeController extends ChangeNotifier {
  // Nilai awal aplikasi.
  bool isDark = false;
  int seedColor = Colors.indigo.value;

  // Mengubah mode gelap dan memperbarui widget.
  void setDarkMode(bool value) {
    isDark = value;
    notifyListeners();
  }
}
```

Penjelasan:

- `isDark` menyimpan status tema.
- `seedColor` menyimpan warna aksen dalam bentuk integer.
- `notifyListeners()` memberi tahu widget yang mendengarkan controller bahwa data berubah sehingga tampilan dapat diperbarui.

Pada aplikasi akhir, fungsi controller juga menyimpan perubahan ke `SharedPreferences`, sebagaimana dijelaskan pada bagian berikut.

## 8. Menyimpan Tema dengan SharedPreferences

`SharedPreferences` digunakan untuk menyimpan nilai sederhana secara lokal, misalnya boolean dan integer. Data ini dapat dibaca lagi saat aplikasi dibuka berikutnya.

Pastikan dependensi tersedia:

```bash
flutter pub add shared_preferences
```

Import:

```dart
import 'package:shared_preferences/shared_preferences.dart';
```

Inisialisasi aplikasi:

```dart
Future<void> main() async {
  // Memastikan Flutter siap sebelum plugin digunakan.
  WidgetsFlutterBinding.ensureInitialized();

  // Membuat controller dan membaca pengaturan tersimpan.
  final themeController = AppThemeController();
  await themeController.load();

  runApp(MyApp(themeController: themeController));
}
```

Penjelasan:

- `WidgetsFlutterBinding.ensureInitialized()` menyiapkan binding Flutter sebelum pemanggilan plugin.
- `await` menunggu pengaturan selesai dibaca sebelum aplikasi ditampilkan.
- `runApp()` menjalankan widget root aplikasi.

Contoh membaca dan menyimpan pengaturan:

```dart
class AppThemeController extends ChangeNotifier {
  static const String _darkKey = 'isDarkMode';
  static const String _colorKey = 'themeColor';

  bool isDark = false;
  int seedColor = Colors.indigo.value;

  // Membaca tema yang disimpan.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    isDark = prefs.getBool(_darkKey) ?? false;
    seedColor = prefs.getInt(_colorKey) ?? Colors.indigo.value;

    notifyListeners();
  }

  // Menyimpan pilihan mode gelap.
  Future<void> toggleDarkMode(bool value) async {
    isDark = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkKey, value);

    notifyListeners();
  }

  // Menyimpan pilihan warna aksen.
  Future<void> changeColor(Color color) async {
    seedColor = color.value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorKey, seedColor);

    notifyListeners();
  }
}
```

Penjelasan:

- `getBool()` membaca status mode gelap.
- `getInt()` membaca warna yang disimpan.
- `??` menetapkan nilai default jika belum ada nilai tersimpan.
- `setBool()` dan `setInt()` menyimpan pilihan baru.
- `notifyListeners()` memperbarui widget yang mendengarkan controller.

**Catatan:** jika kode menggunakan `SharedPreferences`, perubahan pada controller perlu disimpan dan widget perlu mendengarkan perubahan controller agar tampilan langsung diperbarui.

## 9. Memilih Warna Tema

```dart
// Daftar warna aksen yang dapat dipilih pengguna.
const pilihanWarna = <Color>[
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];
```

Daftar ini menjadi sumber pilihan warna pada halaman Pengaturan.

```dart
Wrap(
  spacing: 12,
  children: [
    for (final color in pilihanWarna)
      GestureDetector(
        // Mengganti warna ketika lingkaran ditekan.
        onTap: () => themeController.changeColor(color),
        child: CircleAvatar(
          backgroundColor: color,
          child: themeController.seedColor == color.value
              ? const Icon(Icons.check, color: Colors.white)
              : null,
        ),
      ),
  ],
);
```

Penjelasan:

- `Wrap` menata pilihan warna dan dapat membungkusnya ke baris berikutnya.
- `for` membuat satu widget untuk setiap warna di daftar.
- `GestureDetector` mendeteksi ketukan.
- `CircleAvatar` menampilkan lingkaran warna.
- Ikon centang menunjukkan warna yang sedang dipilih.

---

# BAGIAN B — ROUTING DAN NAVIGASI

## 10. Apa Itu Navigator?

Navigasi adalah proses berpindah dari satu tampilan ke tampilan lainnya. Flutter menggunakan `Navigator` untuk mengelola tumpukan halaman (route).

Dua operasi dasar:

```dart
// Membuka halaman baru di atas halaman saat ini.
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const HalamanContoh(),
  ),
);

// Menutup halaman saat ini dan kembali ke halaman sebelumnya.
Navigator.pop(context);
```

`push()` menambahkan halaman ke tumpukan navigasi. `pop()` menghapus halaman paling atas dan kembali ke halaman sebelumnya.

## 11. Apa Itu Named Routes?

Named routes adalah navigasi menggunakan nama rute, misalnya `/` untuk halaman utama dan `/detail` untuk halaman detail. Cara ini memudahkan pemisahan definisi halaman dari kode yang membuka halaman.

```dart
MaterialApp(
  // Route awal saat aplikasi dibuka.
  initialRoute: '/',

  // Daftar route yang tidak memerlukan argumen.
  routes: {
    '/': (context) => const HalamanUtama(),
  },
);
```

Penjelasan:

- `initialRoute` menentukan route pertama.
- `routes` adalah peta nama route ke widget halaman.
- Pada contoh ini, route `/` membuka `HalamanUtama`.

## 12. Mengirim Argumen ke Halaman Detail

Ketika item dipilih, data item bisa dikirim sebagai `arguments`.

```dart
// Membuka route detail sambil mengirim objek wisata.
Navigator.pushNamed(
  context,
  '/detail',
  arguments: wisata,
);
```

Untuk menerima argumen tersebut, gunakan `onGenerateRoute`:

```dart
onGenerateRoute: (settings) {
  // Memeriksa apakah route yang diminta adalah halaman detail.
  if (settings.name == '/detail') {
    // Mengambil objek wisata yang dikirim dari halaman sebelumnya.
    final wisata = settings.arguments as Wisata;

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => DetailPage(wisata: wisata),
    );
  }

  // Membiarkan route lain ditangani oleh mekanisme berikutnya.
  return null;
},
```

Penjelasan:

- `settings.name` berisi nama route yang diminta.
- `settings.arguments` berisi data yang dikirim.
- `as Wisata` mengubah argumen menjadi objek `Wisata` sesuai tipe yang diharapkan.
- `DetailPage(wisata: wisata)` meneruskan data ke halaman detail.

Argumen harus sesuai dengan tipe data yang dikirim. Jika tipe tidak sesuai, aplikasi dapat menghasilkan error saat dijalankan.

## 13. Membuat Model Data untuk Katalog

Agar setiap destinasi memiliki struktur data yang jelas, buat class model.

```dart
class Wisata {
  final String id;
  final String nama;
  final String lokasi;
  final String deskripsi;
  final IconData ikon;

  // Constructor untuk membuat objek wisata.
  const Wisata({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.deskripsi,
    required this.ikon,
  });
}
```

Penjelasan:

- `Wisata` merepresentasikan satu objek destinasi.
- `final` berarti nilai field tidak dapat diubah setelah diinisialisasi.
- `required` mewajibkan nilai diberikan saat objek dibuat.
- Constructor membantu membuat objek dengan bentuk data yang konsisten.

Contoh data:

```dart
const daftarWisata = <Wisata>[
  Wisata(
    id: 'raja-ampat',
    nama: 'Raja Ampat',
    lokasi: 'Papua Barat Daya',
    deskripsi: 'Gugusan pulau dan laut yang jernih.',
    ikon: Icons.sailing,
  ),
];
```

List `daftarWisata` menjadi sumber data untuk halaman Beranda dan Katalog.

## 14. NavigationBar untuk Beberapa Tab

`NavigationBar` digunakan untuk berpindah antarbagian utama aplikasi, misalnya Beranda, Katalog, dan Pengaturan.

```dart
NavigationBar(
  // Menunjukkan tab yang sedang aktif.
  selectedIndex: _index,

  // Memperbarui indeks ketika tab dipilih.
  onDestinationSelected: (index) {
    setState(() => _index = index);
  },

  // Daftar pilihan tab.
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
);
```

Penjelasan:

- `_index` menyimpan indeks tab yang sedang aktif.
- `selectedIndex` menentukan tab yang dipilih.
- `onDestinationSelected` dipanggil ketika pengguna memilih tab lain.
- `setState()` memperbarui tampilan berdasarkan indeks baru.

Contoh penggunaan bersama `IndexedStack`:

```dart
// Menampilkan halaman sesuai indeks yang dipilih.
body: IndexedStack(
  index: _index,
  children: halaman,
),
```

`IndexedStack` menampilkan satu halaman berdasarkan indeks, tetapi mempertahankan widget lain di dalam stack. Ini berguna untuk menjaga state tab ketika pengguna berpindah-pindah.

## 15. Menambahkan Hero pada Halaman Detail

`Hero` membuat elemen yang sama terlihat bergerak dari satu halaman ke halaman lain ketika navigasi dilakukan. Contohnya, ikon destinasi di halaman Beranda akan bertransisi ke ikon yang lebih besar di halaman detail.

Pada halaman awal:

```dart
Hero(
  // Tag harus sama dengan Hero di halaman detail.
  tag: 'wisata-${wisata.id}',
  child: CircleAvatar(
    radius: 28,
    child: Icon(wisata.ikon),
  ),
);
```

Pada halaman detail:

```dart
Hero(
  // Tag yang sama memungkinkan Flutter menghubungkan kedua elemen.
  tag: 'wisata-${wisata.id}',
  child: CircleAvatar(
    radius: 64,
    child: Icon(wisata.ikon, size: 64),
  ),
);
```

Penjelasan:

- `tag` mengidentifikasi elemen yang akan dianimasikan.
- Tag pada kedua halaman harus cocok.
- Perubahan ukuran dan posisi elemen terlihat sebagai transisi saat membuka detail.

## 16. Route Tidak Dikenal

Pada materi routing, route yang tidak tersedia juga dapat ditangani melalui `onUnknownRoute`.

```dart
onUnknownRoute: (settings) {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Tidak Ditemukan'),
      ),
      body: const Center(
        child: Text('404 - Halaman tidak ditemukan'),
      ),
    ),
  );
},
```

Penjelasan:

- `onUnknownRoute` menyediakan halaman cadangan ketika nama route tidak dikenali.
- Ini membantu aplikasi menampilkan pesan yang jelas daripada tidak menampilkan halaman yang sesuai.

Jika `onGenerateRoute` sudah digunakan, route yang tidak dikenal harus dikembalikan sebagai `null` agar dapat diteruskan ke mekanisme penanganan route berikutnya.

---

# BAGIAN C — ANIMASI DI FLUTTER

## 17. Apa Itu Animasi?

Animasi membuat perubahan visual berlangsung secara bertahap, bukan langsung berubah dalam satu frame. Dalam materi ini, animasi dibagi menjadi dua jenis utama:

1. **Animasi implisit:** Flutter mengatur interpolasi perubahan properti secara otomatis.
2. **Animasi eksplisit:** developer mengatur pengendali animasi dan bagaimana animasi dijalankan.

## 18. AnimatedContainer — Animasi Implisit

`AnimatedContainer` menganimasikan perubahan properti seperti ukuran, warna, dekorasi, dan radius secara otomatis selama durasi tertentu.

```dart
AnimatedContainer(
  // Lama perubahan animasi.
  duration: const Duration(milliseconds: 500),

  // Kurva menentukan karakter perubahan.
  curve: Curves.easeInOut,

  // Ukuran berubah berdasarkan nilai _besar.
  width: _besar ? 220 : 150,
  height: _besar ? 110 : 80,

  // Radius ikut berubah ketika ukuran berubah.
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.primaryContainer,
    borderRadius: BorderRadius.circular(_besar ? 32 : 12),
  ),
);
```

Penjelasan:

- `duration` menentukan lamanya animasi.
- `curve` mengatur pola percepatan dan perlambatan.
- Operator kondisi menentukan nilai sebelum dan sesudah perubahan.
- Flutter menganimasikan perbedaan nilai tersebut tanpa perlu membuat `AnimationController`.

Tombol pemicunya:

```dart
// Membalik status ukuran ketika tombol ditekan.
onPressed: () {
  setState(() {
    _besar = !_besar;
  });
},
```

Ketika `_besar` berubah, Flutter membangun ulang widget. `AnimatedContainer` kemudian menghaluskan perubahan propertinya.

## 19. AnimatedSwitcher

`AnimatedSwitcher` menganimasikan pergantian satu child ke child lain.

```dart
AnimatedSwitcher(
  duration: const Duration(milliseconds: 300),

  // Menentukan efek transisi saat child berganti.
  transitionBuilder: (child, anim) {
    return ScaleTransition(
      scale: anim,
      child: child,
    );
  },

  // ValueKey membedakan widget untuk setiap nilai.
  child: Text(
    '$_hitung',
    key: ValueKey(_hitung),
  ),
);
```

Penjelasan:

- `duration` menentukan durasi pergantian.
- `transitionBuilder` menentukan jenis transisi.
- `ScaleTransition` memberikan efek membesar atau mengecil.
- `ValueKey(_hitung)` membantu Flutter mengenali bahwa child berubah ketika nilai `_hitung` berubah.

Contoh ini dapat dipicu oleh tombol yang menambahkan nilai `_hitung` menggunakan `setState()`.

## 20. AnimationController dan RotationTransition — Animasi Eksplisit

Berbeda dari animasi implisit, animasi eksplisit menggunakan controller untuk mengendalikan kemajuan animasi.

```dart
class _KatalogTabState extends State<KatalogTab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _putar;

  @override
  void initState() {
    super.initState();

    // Controller menggerakkan animasi selama tiga detik per putaran.
    _putar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    // Melepaskan controller saat widget dihapus.
    _putar.dispose();
    super.dispose();
  }
}
```

Penjelasan:

- `SingleTickerProviderStateMixin` menyediakan ticker untuk satu controller animasi.
- `AnimationController` mengatur kemajuan animasi.
- `vsync: this` menghubungkan controller dengan ticker provider.
- `repeat()` menjalankan animasi berulang.
- `dispose()` melepaskan controller ketika widget tidak lagi digunakan.

Menampilkan animasi rotasi:

```dart
// Ikon berputar mengikuti nilai dari controller.
RotationTransition(
  turns: _putar,
  child: Icon(
    Icons.public,
    size: 40,
    color: Theme.of(context).colorScheme.primary,
  ),
);
```

`RotationTransition` menggunakan nilai controller untuk menentukan sudut rotasi. Dalam aplikasi katalog, efek ini digunakan pada ikon globe.

## 21. AnimatedOpacity

`AnimatedOpacity` menghaluskan perubahan tingkat transparansi widget.

```dart
AnimatedOpacity(
  // 1.0 berarti terlihat penuh, 0.0 berarti transparan.
  opacity: _showCard ? 1.0 : 0.0,

  // Durasi perubahan transparansi.
  duration: const Duration(milliseconds: 500),

  child: const Card(
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Text('Kartu Animasi'),
    ),
  ),
);
```

Penjelasan:

- `opacity: 1.0` membuat widget terlihat sepenuhnya.
- `opacity: 0.0` membuat widget transparan.
- `duration` mengatur lama perubahan.
- `_showCard` dapat diubah melalui tombol dan `setState()`.

Perlu diingat bahwa transparan tidak selalu berarti widget dihapus dari layout atau tidak bisa menerima interaksi. Jika widget harus benar-benar tidak bisa diinteraksikan saat tersembunyi, pertimbangkan penggunaan `IgnorePointer` atau `Visibility`.

## 22. PageRouteBuilder dan FadeTransition

Transisi halaman juga dapat dianimasikan menggunakan `PageRouteBuilder`.

```dart
PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) {
    // Halaman yang akan dibuka.
    return DetailPage(wisata: wisata);
  },

  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    // Halaman baru muncul secara perlahan.
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  },

  transitionDuration: const Duration(milliseconds: 400),
);
```

Penjelasan:

- `pageBuilder` membangun halaman tujuan.
- `transitionsBuilder` menentukan animasi saat berpindah halaman.
- `FadeTransition` mengatur opacity berdasarkan nilai animasi.
- `transitionDuration` menentukan lama transisi.

Materi ini menunjukkan bahwa animasi tidak hanya bisa diterapkan pada widget, tetapi juga pada perpindahan halaman.

---

# BAGIAN D — PENERAPAN DALAM APLIKASI GALERI WISATA

## 23. Struktur Aplikasi

Aplikasi Galeri Wisata Indonesia menggabungkan seluruh materi menjadi tiga tab utama:

| Halaman | Fungsi |
|---|---|
| Beranda | Menampilkan destinasi unggulan dan membuka detail destinasi. |
| Katalog | Menampilkan seluruh daftar wisata serta demonstrasi animasi. |
| Pengaturan | Mengubah tema terang/gelap dan warna aksen. |
| Detail | Menampilkan informasi destinasi yang dipilih melalui named route. |

Model `Wisata` menyimpan ID, nama, lokasi, deskripsi, dan ikon. Data model dikirim ke halaman detail menggunakan named route.

## 24. Alur Membuka Halaman Detail

Alur navigasi pada aplikasi adalah:

1. Pengguna memilih destinasi pada Beranda atau Katalog.
2. Aplikasi memanggil `Navigator.pushNamed()`.
3. Objek `Wisata` dikirim sebagai `arguments`.
4. `onGenerateRoute` menerima objek tersebut.
5. `DetailPage` menampilkan data destinasi.
6. `Hero` menghubungkan ikon dari halaman sebelumnya ke halaman detail.
7. Pengguna menekan tombol kembali untuk kembali ke halaman sebelumnya.

## 25. Alur Pengaturan Tema

1. Pengguna membuka tab Pengaturan.
2. Pengguna mengaktifkan atau menonaktifkan mode gelap.
3. `AppThemeController` mengubah nilai `isDark`.
4. Pilihan disimpan melalui `SharedPreferences`.
5. `notifyListeners()` memberi tahu widget yang mendengarkan controller.
6. `MaterialApp` menerapkan `themeMode` baru.
7. Ketika aplikasi dibuka kembali, `load()` membaca pengaturan yang tersimpan.

---

# BAGIAN E — MENJALANKAN DAN MENGUJI APLIKASI

## 26. Menyiapkan Dependensi

Dari terminal di folder utama project, jalankan:

```bash
flutter pub add shared_preferences
flutter pub get
```

Dependensi `shared_preferences` digunakan untuk menyimpan pengaturan tema secara lokal.

## 27. Menjalankan Aplikasi

```bash
flutter run -t lib/main.dart
```

Perintah tersebut menjalankan `main.dart` sebagai entry point aplikasi. Pastikan emulator atau perangkat sudah terdeteksi.

Untuk memeriksa masalah kode:

```bash
flutter analyze
```

Jika ada error, perbaiki error yang dilaporkan sebelum melanjutkan pengujian.

# BAGIAN F — KESIMPULAN

Pada Praktikum Pertemuan 6, materi tema digunakan untuk mengatur tampilan konsisten dan mendukung mode terang/gelap. Routing dan navigasi digunakan untuk mengelola perpindahan halaman, mengirim data ke halaman detail, dan membangun navigasi tiga tab. Animasi implisit seperti `AnimatedContainer` serta animasi eksplisit menggunakan `AnimationController` membuat antarmuka lebih interaktif.

Seluruh konsep tersebut diterapkan dalam Galeri Wisata Indonesia. Aplikasi ini menjadi dasar untuk dikembangkan lebih lanjut pada mini proyek berikutnya, misalnya dengan menambahkan gambar destinasi, fitur favorit, pencarian, atau penyimpanan data wisata.

