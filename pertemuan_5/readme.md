# README - Praktikum Flutter Pertemuan 5
## Penyimpanan Lokal Menggunakan SharedPreferences dan SQLite

## 1. Deskripsi Praktikum

Praktikum Flutter Pertemuan 5 membahas cara menyimpan data secara lokal pada perangkat menggunakan **SharedPreferences** dan **SQLite**.

Data yang hanya disimpan dalam variabel atau `State` akan hilang ketika aplikasi ditutup jika tidak disimpan secara permanen. Oleh karena itu, diperlukan mekanisme penyimpanan lokal (*local persistence*) agar data tetap tersedia ketika aplikasi dibuka kembali.

Pada praktikum ini, dipelajari cara menyimpan pengaturan sederhana, membuat database SQLite, serta menerapkan operasi CRUD (*Create, Read, Update, Delete*) yang terhubung dengan antarmuka aplikasi.

## 2. Tujuan Pembelajaran

1. Memahami perbedaan penyimpanan key-value, database, dan berkas.
2. Menyimpan serta membaca pengaturan menggunakan SharedPreferences.
3. Membuat database SQLite dan tabel untuk menyimpan data terstruktur.
4. Mengimplementasikan operasi CRUD menggunakan SQLite.
5. Memastikan data tetap tersimpan setelah aplikasi ditutup dan dijalankan kembali.

## 3. Teknologi dan Paket yang Digunakan

| Teknologi | Fungsi |
|---|---|
| Flutter | Membuat aplikasi mobile |
| Dart | Bahasa pemrograman aplikasi |
| shared_preferences | Menyimpan pengaturan sederhana dalam bentuk key-value |
| sqflite | Mengakses database SQLite |
| path | Membantu menyusun lokasi berkas database |
| Material Design | Membuat komponen antarmuka aplikasi |

## 4. Perbedaan SharedPreferences dan SQLite

### A. SharedPreferences

SharedPreferences digunakan untuk menyimpan data sederhana, seperti nama pengguna, pilihan mode gelap, status login, atau jumlah aplikasi dibuka.

Contoh data yang disimpan:
- `nama`: String
- `gelap`: Boolean
- `bukaKe`: Integer

### B. SQLite

SQLite digunakan untuk menyimpan data yang lebih terstruktur, seperti catatan, transaksi, dan daftar pengeluaran. Data disimpan dalam tabel sehingga dapat ditambah, dibaca, diubah, dan dihapus menggunakan SQL.

### C. Perbandingan

| Aspek | SharedPreferences | SQLite |
|---|---|---|
| Bentuk penyimpanan | Key-value | Tabel dan baris |
| Penggunaan | Pengaturan sederhana | Data terstruktur |
| Contoh | Tema aplikasi | Catatan dan transaksi |
| Operasi utama | Membaca dan menyimpan nilai | CRUD menggunakan query database |

## 5. Implementasi SharedPreferences

### A. Memasang Paket

```bash
flutter pub add shared_preferences
```

Perintah tersebut digunakan untuk menambahkan paket SharedPreferences ke dalam proyek Flutter agar aplikasi dapat menyimpan pengaturan secara lokal.

### B. Import Library

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
```

Penjelasan:
- `material.dart` menyediakan widget untuk membangun antarmuka aplikasi.
- `shared_preferences.dart` menyediakan fungsi untuk menyimpan dan membaca data key-value.

### C. Membaca Data yang Tersimpan

```dart
Future<void> _muat() async {
  final prefs = await SharedPreferences.getInstance();

  if (!mounted) return;

  setState(() {
    _controller.text = prefs.getString('nama') ?? '';
    _gelap = prefs.getBool('gelap') ?? false;
    _bukaKe = (prefs.getInt('bukaKe') ?? 0) + 1;
  });

  await prefs.setInt('bukaKe', _bukaKe);
}
```

Penjelasan:
- `SharedPreferences.getInstance()` mengambil instance penyimpanan lokal.
- `getString('nama')` membaca nama yang tersimpan.
- `getBool('gelap')` membaca status mode gelap.
- `getInt('bukaKe')` membaca jumlah aplikasi dibuka.
- Operator `??` memberikan nilai bawaan jika data belum tersedia.
- `setState()` memperbarui tampilan berdasarkan data yang dibaca.
- `setInt()` menyimpan jumlah pembukaan aplikasi yang sudah diperbarui.
- `if (!mounted) return` mencegah penggunaan State yang sudah tidak aktif setelah operasi asynchronous.

Fungsi `_muat()` dipanggil melalui `initState()` agar data dibaca ketika halaman pertama kali dibuat.

### D. Menyimpan Nama

```dart
Future<void> _simpanNama() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(
    'nama',
    _controller.text.trim(),
  );

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Nama disimpan')),
  );
}
```

Penjelasan:
- `setString()` menyimpan nama menggunakan key `nama`.
- `trim()` menghapus spasi di awal dan akhir teks.
- `SnackBar` menampilkan informasi bahwa nama telah disimpan.

### E. Menyimpan Pilihan Mode Gelap

```dart
Future<void> _ubahTema(bool nilai) async {
  setState(() => _gelap = nilai);

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('gelap', nilai);
}
```

Penjelasan:
- Parameter `nilai` berisi status switch, yaitu `true` atau `false`.
- `setState()` memperbarui tampilan tema.
- `setBool()` menyimpan pilihan mode gelap agar dapat dibaca kembali saat aplikasi dibuka.

**Kesimpulan SharedPreferences:** penyimpanan ini cocok untuk pengaturan sederhana yang perlu bertahan setelah aplikasi ditutup.

## 6. Implementasi SQLite

### A. Memasang Paket

```bash
flutter pub add sqflite path
```

Penjelasan:
- `sqflite` digunakan untuk menjalankan operasi database SQLite.
- `path` digunakan untuk menyusun lokasi database secara lebih aman dan konsisten.

### B. Import Library

```dart
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
```

Library `path` diberi alias `p`, sedangkan `sqflite` menyediakan fungsi untuk membuka database dan menjalankan operasi CRUD.

### C. Membuat Model Catatan

```dart
class Catatan {
  final int? id;
  final String judul;
  final String isi;

  const Catatan({
    this.id,
    required this.judul,
    required this.isi,
  });

  Map<String, Object?> toMap() => {
    'id': id,
    'judul': judul,
    'isi': isi,
  };

  factory Catatan.fromMap(Map<String, Object?> m) => Catatan(
    id: m['id'] as int,
    judul: m['judul'] as String,
    isi: m['isi'] as String,
  );
}
```

Penjelasan:
- `Catatan` merupakan model yang merepresentasikan satu data catatan.
- `id` bertipe `int?` karena nilainya dapat kosong ketika catatan baru dibuat.
- `judul` dan `isi` menyimpan informasi catatan.
- `toMap()` mengubah objek Dart menjadi Map agar dapat disimpan ke SQLite.
- `fromMap()` mengubah hasil pembacaan database menjadi objek `Catatan`.

Model membantu memisahkan struktur data dari logika antarmuka aplikasi.

### D. Membuka Database dan Membuat Tabel

```dart
class DbHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final path = p.join(
      await getDatabasesPath(),
      'catatan.db',
    );

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE catatan('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'judul TEXT NOT NULL, '
          'isi TEXT NOT NULL)',
        );
      },
    );

    return _db!;
  }
}
```

Penjelasan:
- `_db` menyimpan instance database yang sudah dibuka.
- `getDatabasesPath()` mengambil direktori database perangkat.
- `p.join()` menggabungkan direktori dengan nama `catatan.db`.
- `openDatabase()` membuka database atau membuatnya jika belum tersedia.
- `version: 1` menentukan versi skema database.
- `onCreate` dijalankan saat database pertama kali dibuat.
- `PRIMARY KEY AUTOINCREMENT` membuat ID bertambah secara otomatis.
- `NOT NULL` memastikan kolom judul dan isi tidak boleh bernilai `NULL`.

Dengan cara ini, database tidak perlu dibuat ulang setiap kali halaman dibuka.

## 7. Implementasi CRUD SQLite

CRUD adalah empat operasi utama untuk mengelola data dalam database.

### A. Create — Menambahkan Data

```dart
static Future<int> tambah(Catatan c) async {
  final db = await database;
  return db.insert('catatan', c.toMap());
}
```

Fungsi `tambah()` menyimpan objek catatan ke tabel `catatan`. Data objek diubah menjadi Map menggunakan `toMap()`. SQLite akan memberikan ID otomatis untuk catatan baru.

### B. Read — Membaca Data

```dart
static Future<List<Catatan>> semua() async {
  final db = await database;

  final rows = await db.query(
    'catatan',
    orderBy: 'id DESC',
  );

  return rows.map(Catatan.fromMap).toList();
}
```

Penjelasan:
- `db.query()` membaca data dari tabel.
- `orderBy: 'id DESC'` mengurutkan catatan dari ID terbesar ke terkecil.
- `map(Catatan.fromMap)` mengubah setiap baris menjadi objek Catatan.
- `toList()` menghasilkan daftar objek yang dapat digunakan oleh antarmuka.

### C. Update — Mengubah Data

```dart
static Future<int> ubah(Catatan c) async {
  final db = await database;

  return db.update(
    'catatan',
    c.toMap(),
    where: 'id = ?',
    whereArgs: [c.id],
  );
}
```

Fungsi `ubah()` memperbarui catatan berdasarkan ID. Klausa `where` menentukan baris yang diubah, sedangkan `whereArgs` mengisi nilai placeholder `?`.

### D. Delete — Menghapus Data

```dart
static Future<int> hapus(int id) async {
  final db = await database;

  return db.delete(
    'catatan',
    where: 'id = ?',
    whereArgs: [id],
  );
}
```

Fungsi `hapus()` menghapus catatan berdasarkan ID. Dengan demikian, data yang dihapus tidak hanya hilang dari tampilan, tetapi juga dari database.

### E. Mengapa Menggunakan Placeholder `?`?

Contoh yang benar:

```dart
where: 'id = ?',
whereArgs: [id],
```

Placeholder memisahkan struktur query SQL dari nilai yang diberikan pengguna. Cara ini membantu mencegah SQL injection dibandingkan menyusun query dengan menggabungkan teks masukan pengguna secara langsung.

## 8. Menampilkan Data Menggunakan FutureBuilder

```dart
late Future<List<Catatan>> _future;

@override
void initState() {
  super.initState();
  _future = DbHelper.semua();
}
```

Variabel `_future` menampung proses pembacaan data dari SQLite. `initState()` menjalankan pembacaan awal ketika halaman daftar dibuat.

Berikutnya, hasil query ditampilkan menggunakan `FutureBuilder`:

```dart
FutureBuilder<List<Catatan>>(
  future: _future,
  builder: (context, snapshot) {
    if (snapshot.connectionState ==
        ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (snapshot.hasError) {
      return Center(
        child: Text('Galat: ${snapshot.error}'),
      );
    }

    final data = snapshot.data!;

    if (data.isEmpty) {
      return const Center(
        child: Text('Belum ada catatan'),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, i) {
        final c = data[i];

        return ListTile(
          title: Text(c.judul),
          subtitle: Text(c.isi),
        );
      },
    );
  },
)
```

Penjelasan:
- `FutureBuilder` menampilkan hasil proses asynchronous.
- `ConnectionState.waiting` digunakan ketika data masih dimuat.
- `snapshot.hasError` menangani kesalahan pembacaan.
- `data.isEmpty` menampilkan pesan jika belum ada catatan.
- `ListView.builder` menampilkan daftar catatan berdasarkan data dari database.
- `ListTile` menampilkan judul dan isi catatan.

## 9. Form Tambah dan Ubah Data

Modul menggunakan satu halaman form untuk menambah maupun mengubah catatan.

### A. Menginisialisasi Form

```dart
final _formKey = GlobalKey<FormState>();
late final TextEditingController _judul;
late final TextEditingController _isi;

@override
void initState() {
  super.initState();

  _judul = TextEditingController(
    text: widget.catatan?.judul ?? '',
  );

  _isi = TextEditingController(
    text: widget.catatan?.isi ?? '',
  );
}
```

Penjelasan:
- `_formKey` digunakan untuk menjalankan validasi form.
- `TextEditingController` membaca dan mengontrol isi input.
- `widget.catatan?.judul` mengambil judul catatan jika halaman dibuka dalam mode edit.
- Operator `?? ''` memberikan teks kosong ketika halaman digunakan untuk menambah catatan baru.

### B. Validasi dan Menyimpan Form

```dart
Future<void> _simpan() async {
  if (!_formKey.currentState!.validate()) return;

  final c = Catatan(
    id: widget.catatan?.id,
    judul: _judul.text.trim(),
    isi: _isi.text.trim(),
  );

  if (widget.catatan == null) {
    await DbHelper.tambah(c);
  } else {
    await DbHelper.ubah(c);
  }

  if (!mounted) return;
  Navigator.pop(context);
}
```

Penjelasan:
- `validate()` memastikan input memenuhi aturan validasi.
- Objek `Catatan` dibuat dari nilai input.
- Jika `widget.catatan == null`, data baru ditambahkan.
- Jika catatan tersedia, data diperbarui.
- `Navigator.pop(context)` menutup halaman form setelah penyimpanan selesai.
- `if (!mounted) return` memastikan halaman masih aktif sebelum menggunakan `context`.

### C. Contoh Validasi Input

```dart
TextFormField(
  controller: _judul,
  decoration: const InputDecoration(
    labelText: 'Judul',
    border: OutlineInputBorder(),
  ),
  validator: (v) =>
      (v == null || v.trim().isEmpty)
          ? 'Judul wajib diisi'
          : null,
)
```

Validator memeriksa apakah judul kosong. Jika kosong, pesan kesalahan akan ditampilkan dan penyimpanan tidak dilanjutkan.

## 10. Memuat Ulang Data Setelah CRUD

```dart
void _muat() {
  setState(() {
    _future = DbHelper.semua();
  });
}
```

Fungsi `_muat()` digunakan untuk menjalankan kembali query dan memperbarui daftar setelah data ditambah, diubah, atau dihapus.

Contoh pemanggilan setelah kembali dari halaman form:

```dart
Future<void> _buka([Catatan? catatan]) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => FormCatatanPage(
        catatan: catatan,
      ),
    ),
  );

  if (!mounted) return;
  _muat();
}
```

Penjelasan:
1. `Navigator.push()` membuka halaman form.
2. `await` menunggu sampai pengguna kembali dari halaman tersebut.
3. Pemeriksaan `mounted` memastikan halaman daftar masih aktif.
4. `_muat()` membaca ulang database agar tampilan mencerminkan data terbaru.

Hal yang sama dilakukan setelah penghapusan data agar daftar langsung diperbarui.

## 11. Migrasi Database: onCreate dan onUpgrade

SQLite memiliki mekanisme versi database untuk mengelola perubahan struktur tabel.

- `onCreate`: dijalankan ketika database pertama kali dibuat.
- `onUpgrade`: dijalankan ketika versi database yang dibuka lebih tinggi daripada versi sebelumnya.

Contoh penambahan kolom tanggal dibuat:

```dart
await openDatabase(
  path,
  version: 2,
  onUpgrade: (db, oldVersion, newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE catatan ADD COLUMN dibuat TEXT',
      );
    }
  },
);
```

Penjelasan:
- Versi database dinaikkan menjadi `2`.
- `oldVersion < 2` memeriksa apakah database masih menggunakan skema versi sebelumnya.
- `ALTER TABLE` menambahkan kolom `dibuat` tanpa harus membuat ulang seluruh tabel.

Jika struktur tabel diubah tetapi versi database tidak dinaikkan, callback `onUpgrade` tidak berjalan untuk perubahan tersebut. Akibatnya, aplikasi dapat mengalami error seperti `no such column`.

## 12. Keamanan dan Penanganan Error

Beberapa hal yang perlu diperhatikan selama pengembangan:

1. Gunakan placeholder `?` dan `whereArgs` untuk nilai dalam query.
2. Gunakan nilai bawaan seperti `prefs.getString('nama') ?? ''` jika data SharedPreferences belum tersedia.
3. Panggil `_muat()` setelah tambah, ubah, atau hapus data.
4. Periksa `mounted` setelah operasi `await` sebelum menggunakan `context` atau `setState`.
5. Jika muncul `MissingPluginException` setelah memasang paket baru, hentikan aplikasi sepenuhnya lalu jalankan kembali.
6. Jika muncul error tabel atau kolom tidak ditemukan saat pengembangan, periksa versi skema dan migrasi database. Menghapus data aplikasi dapat membantu menguji ulang pembuatan database dari awal, tetapi akan menghilangkan data lokal yang tersimpan.

## 13. Tugas Praktikum: Aplikasi Pencatat Pengeluaran

Berdasarkan modul, tugas akhir adalah membuat aplikasi Pencatat Pengeluaran dengan ketentuan berikut.

### A. Struktur Tabel

Tabel `pengeluaran` memiliki kolom:
- `id`: identitas pengeluaran.
- `nama`: nama pengeluaran.
- `jumlah`: jumlah pengeluaran bertipe integer.
- `kategori`: kategori pengeluaran.
- `tanggal`: tanggal pengeluaran.

### B. Fitur yang Wajib Dibuat

1. Menampilkan daftar pengeluaran.
2. Menambahkan pengeluaran baru.
3. Mengubah pengeluaran yang sudah tersimpan.
4. Menghapus pengeluaran.
5. Memvalidasi nama agar wajib diisi.
6. Memvalidasi jumlah agar berupa angka lebih dari nol.
7. Memilih kategori menggunakan dropdown.
8. Menampilkan total pengeluaran di halaman utama.
9. Menyimpan satu pengaturan menggunakan SharedPreferences, misalnya mode gelap atau kategori filter terakhir.
10. Memastikan data tetap tersedia setelah aplikasi ditutup dan dibuka kembali.

### C. Contoh Struktur Database Pengeluaran

```sql
CREATE TABLE pengeluaran(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nama TEXT NOT NULL,
  jumlah INTEGER NOT NULL,
  kategori TEXT NOT NULL,
  tanggal TEXT NOT NULL
)
```

Query tersebut membuat tabel dengan ID otomatis serta kolom nama, jumlah, kategori, dan tanggal. Kolom wajib menggunakan `NOT NULL` agar nilainya tidak kosong.

### D. Contoh Menghitung Total Pengeluaran di Dart

```dart
final total = daftarPengeluaran.fold<int>(
  0,
  (sum, item) => sum + item.jumlah,
);
```

Penjelasan:
- `fold<int>()` menjumlahkan nilai dari seluruh data pengeluaran.
- `sum` merupakan total sementara.
- `item.jumlah` merupakan nilai pengeluaran pada setiap data.
- Hasil akhirnya dapat ditampilkan pada halaman utama.

Kode ini mengasumsikan `daftarPengeluaran` berisi objek yang memiliki properti integer `jumlah`.

### E. Hasil Akhir yang Diharapkan

Aplikasi dapat mengelola data pengeluaran melalui operasi CRUD, memvalidasi input, menampilkan total pengeluaran, dan menyimpan pengaturan sederhana. Data harus tetap tersedia setelah aplikasi dihentikan sepenuhnya dan dijalankan kembali.

Bukti pengerjaan yang dikumpulkan:
- Screenshot halaman daftar pengeluaran.
- Screenshot form tambah atau ubah pengeluaran.
- Screenshot yang membuktikan data tetap tersimpan setelah aplikasi dijalankan kembali.
- Berkas kode program atau tautan repositori.

## 14. Troubleshooting

| Masalah | Solusi |
|---|---|
| `MissingPluginException` | Hentikan aplikasi sepenuhnya, lalu jalankan kembali. |
| Data baru tidak muncul | Pastikan fungsi `_muat()` dipanggil setelah CRUD. |
| `no such table` | Periksa pembuatan tabel di `onCreate`. |
| `no such column` | Periksa migrasi dan versi database. |
| Data pengaturan belum tersedia | Gunakan nilai bawaan dengan operator `??`. |
| `use_build_context_synchronously` | Periksa `if (!mounted) return` setelah `await`. |
| `sqflite` tidak berjalan di web atau desktop | Gunakan emulator Android/iOS atau solusi SQLite yang sesuai platform. |

## 15. Kesimpulan

Praktikum Pertemuan 5 menjelaskan pentingnya penyimpanan lokal pada aplikasi Flutter. SharedPreferences cocok untuk menyimpan pengaturan sederhana dalam bentuk key-value, sedangkan SQLite cocok untuk menyimpan data terstruktur yang membutuhkan operasi CRUD.

Model digunakan untuk merepresentasikan data, kelas helper memisahkan akses database dari UI, `FutureBuilder` menampilkan hasil proses asynchronous, dan validasi form membantu memastikan data yang dimasukkan sesuai aturan. Dengan menerapkan konsep tersebut, aplikasi dapat menyimpan serta mengelola data secara lokal meskipun aplikasi telah ditutup.

## 16. Referensi

- Flutter: https://docs.flutter.dev/cookbook/persistence/key-value
- Flutter SQLite: https://docs.flutter.dev/cookbook/persistence/sqlite
- Paket SharedPreferences: https://pub.dev/packages/shared_preferences
- Paket sqflite: https://pub.dev/packages/sqflite
