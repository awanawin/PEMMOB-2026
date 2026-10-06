# 🛒 Aplikasi Daftar Belanja Flutter

Aplikasi **Daftar Belanja** merupakan aplikasi Flutter yang dibuat untuk menerapkan konsep **Form Input dan State Management** menggunakan `ChangeNotifier` dan `Provider`.

Aplikasi ini memungkinkan pengguna untuk menambahkan barang belanja, menentukan jumlah dan kategori, melihat daftar barang, menandai barang yang sudah dibeli, serta menghapus barang.

---

## 👨‍💻 Identitas

| Keterangan | Data |
|---|---|
| Nama | Gunawan Nastiar |
| NIM | 20240801114 |
| Program Studi | Teknik Informatika |
| Mata Kuliah | Pemrograman Mobile |
| Praktikum | Pertemuan 3 – Form Input dan State Management |

---

# 📌 Fitur Aplikasi

Aplikasi memiliki beberapa fitur utama:

- Menambahkan barang belanja.
- Mengisi nama barang.
- Mengisi jumlah barang.
- Memilih kategori barang melalui dropdown.
- Validasi setiap input form.
- Menampilkan seluruh daftar barang.
- Menandai barang sebagai **sudah dibeli**.
- Menghapus barang.
- Menampilkan jumlah barang yang **belum dibeli** pada AppBar.
- Menggunakan `ChangeNotifier` sebagai state management.
- Menggunakan `Provider` untuk membagikan state ke beberapa halaman.
- Menampilkan kondisi ketika daftar masih kosong.

---

# 🛠️ Teknologi yang Digunakan

- **Flutter**
- **Dart**
- **Provider**
- **ChangeNotifier**
- **Material Design**

Package yang digunakan:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.5+1
```

Provider dapat ditambahkan menggunakan:

```bash
flutter pub add provider
```

---

# 📂 Struktur Aplikasi

Aplikasi dibuat dalam satu file utama yaitu:

```text
lib/
└── main.dart
```

Di dalam `main.dart` terdapat beberapa bagian:

```text
Barang
   ↓
BelanjaModel
   ↓
ChangeNotifierProvider
   ↓
DaftarPage
   ↓
TambahBarangPage
```

`Barang` digunakan sebagai model data, `BelanjaModel` digunakan untuk mengelola state, sedangkan `DaftarPage` dan `TambahBarangPage` digunakan sebagai halaman aplikasi.

---

# 1. Model Barang

Model `Barang` digunakan untuk menyimpan data setiap barang belanja.

```dart
class Barang {
  String nama;
  int jumlah;
  String kategori;
  bool sudahDibeli;

  Barang({
    required this.nama,
    required this.jumlah,
    required this.kategori,
    this.sudahDibeli = false,
  });
}
```

### Penjelasan

Class `Barang` memiliki empat data:

- `nama` → menyimpan nama barang.
- `jumlah` → menyimpan jumlah barang.
- `kategori` → menyimpan kategori barang.
- `sudahDibeli` → menentukan apakah barang sudah dibeli atau belum.

Nilai awal `sudahDibeli` adalah:

```dart
false
```

Artinya, ketika barang baru ditambahkan, barang tersebut dianggap **belum dibeli**.

---

# 2. ChangeNotifier

State aplikasi disimpan menggunakan class `BelanjaModel`.

```dart
class BelanjaModel extends ChangeNotifier {
  final List<Barang> _items = [];

  List<Barang> get items => List.unmodifiable(_items);

  int get jumlahBelumDibeli =>
      _items.where((barang) => !barang.sudahDibeli).length;
}
```

### Penjelasan

`BelanjaModel` melakukan `extends ChangeNotifier`.

```dart
class BelanjaModel extends ChangeNotifier
```

Artinya class tersebut dapat memberitahu widget yang menggunakan state ketika terjadi perubahan data.

Data barang disimpan dalam:

```dart
final List<Barang> _items = [];
```

List tersebut awalnya kosong.

---

# 3. Menghitung Barang Belum Dibeli

Pada AppBar ditampilkan jumlah barang yang belum dibeli.

Kode yang digunakan:

```dart
int get jumlahBelumDibeli =>
    _items.where((barang) => !barang.sudahDibeli).length;
```

### Penjelasan

Kode tersebut mencari semua barang yang memiliki:

```dart
sudahDibeli == false
```

Kemudian menghitung jumlahnya menggunakan:

```dart
.length
```

Contohnya jika terdapat:

```text
Beras      ❌ belum dibeli
Minyak     ❌ belum dibeli
Telur      ✓ sudah dibeli
```

Maka AppBar akan menampilkan:

```text
2 belum dibeli
```

---

# 4. Menambahkan Barang

Method untuk menambahkan barang:

```dart
void tambahBarang(
  String nama,
  int jumlah,
  String kategori,
) {
  _items.add(
    Barang(
      nama: nama,
      jumlah: jumlah,
      kategori: kategori,
    ),
  );

  notifyListeners();
}
```

### Penjelasan

Data yang diterima:

- `nama`
- `jumlah`
- `kategori`

Kemudian dibuat object `Barang` dan dimasukkan ke `_items`.

Bagian penting:

```dart
notifyListeners();
```

Method tersebut memberi tahu widget yang menggunakan `BelanjaModel` bahwa data telah berubah sehingga tampilan dapat diperbarui.

---

# 5. Mengubah Status Barang

Untuk menandai barang sebagai sudah dibeli digunakan:

```dart
void toggleDibeli(int index) {
  _items[index].sudahDibeli =
      !_items[index].sudahDibeli;

  notifyListeners();
}
```

### Penjelasan

Operator `!` digunakan untuk membalik nilai boolean.

Misalnya:

```text
false → true
true → false
```

Jadi ketika checkbox ditekan:

```text
Belum dibeli
     ↓
Sudah dibeli
```

Jika ditekan lagi:

```text
Sudah dibeli
     ↓
Belum dibeli
```

---

# 6. Menghapus Barang

Method untuk menghapus barang:

```dart
void hapusBarang(int index) {
  _items.removeAt(index);

  notifyListeners();
}
```

`removeAt(index)` digunakan untuk menghapus data berdasarkan posisi/index barang dalam list.

Setelah data dihapus, `notifyListeners()` dipanggil agar tampilan diperbarui.

---

# 7. Provider

State `BelanjaModel` dibagikan ke seluruh halaman menggunakan:

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BelanjaModel(),
      child: const MyApp(),
    ),
  );
}
```

### Penjelasan

`ChangeNotifierProvider` menyediakan object:

```dart
BelanjaModel()
```

kepada widget-widget yang berada di bawahnya.

Dengan demikian `DaftarPage` dan `TambahBarangPage` dapat mengakses state yang sama.

---

# 8. Mengambil State dengan context.watch

Pada halaman daftar digunakan:

```dart
final model = context.watch<BelanjaModel>();
```

### Penjelasan

`context.watch()` digunakan untuk mengambil data dari Provider sekaligus membuat widget mendengarkan perubahan state.

Jika daftar barang berubah, halaman akan melakukan rebuild sehingga data terbaru ditampilkan.

---

# 9. Mengambil State dengan context.read

Ketika ingin menjalankan method dari `BelanjaModel`, digunakan:

```dart
context
    .read<BelanjaModel>()
    .toggleDibeli(index);
```

Contoh lainnya:

```dart
context
    .read<BelanjaModel>()
    .hapusBarang(index);
```

### Perbedaan `watch` dan `read`

| Method | Fungsi |
|---|---|
| `context.watch` | Mengambil state dan mendengarkan perubahan |
| `context.read` | Mengambil state tanpa mendengarkan perubahan |

Dalam aplikasi ini:

```dart
context.watch<BelanjaModel>()
```

digunakan untuk menampilkan data.

Sedangkan:

```dart
context.read<BelanjaModel>()
```

digunakan untuk menjalankan aksi seperti tambah, centang, dan hapus.

---

# 10. Menampilkan Daftar Barang

Daftar barang ditampilkan menggunakan `ListView.builder`.

```dart
ListView.builder(
  itemCount: model.items.length,
  itemBuilder: (context, index) {
    final barang = model.items[index];

    return ListTile(
      title: Text(barang.nama),
      subtitle: Text(
        '${barang.jumlah} • ${barang.kategori}',
      ),
    );
  },
)
```

### Penjelasan

`ListView.builder` membuat daftar secara dinamis berdasarkan jumlah data.

Jumlah item ditentukan oleh:

```dart
model.items.length
```

Data barang kemudian diambil berdasarkan index:

```dart
final barang = model.items[index];
```

---

# 11. Checkbox Barang

Checkbox digunakan untuk mengubah status barang.

```dart
Checkbox(
  value: barang.sudahDibeli,
  onChanged: (_) {
    context
        .read<BelanjaModel>()
        .toggleDibeli(index);
  },
)
```

Nilai checkbox berasal dari:

```dart
barang.sudahDibeli
```

Ketika checkbox ditekan, method:

```dart
toggleDibeli(index)
```

dipanggil.

---

# 12. Menghapus Barang

Tombol hapus menggunakan `IconButton`.

```dart
IconButton(
  icon: const Icon(Icons.delete),
  onPressed: () {
    context
        .read<BelanjaModel>()
        .hapusBarang(index);
  },
)
```

Ketika tombol ditekan, barang pada index tersebut akan dihapus dari list.

---

# 13. Form Tambah Barang

Halaman tambah menggunakan `Form`.

```dart
final _formKey = GlobalKey<FormState>();
```

Kemudian:

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      // input form
    ],
  ),
)
```

### Penjelasan

`GlobalKey<FormState>` digunakan untuk mengontrol dan menjalankan validasi pada form.

Validasi dijalankan menggunakan:

```dart
_formKey.currentState!.validate()
```

---

# 14. Input Nama Barang

Nama barang menggunakan `TextFormField`.

```dart
TextFormField(
  controller: _namaController,
  decoration: const InputDecoration(
    labelText: 'Nama barang',
    border: OutlineInputBorder(),
  ),
  validator: (value) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'Nama barang wajib diisi';
    }

    return null;
  },
)
```

### Penjelasan

Validator mengecek apakah nama barang kosong.

Jika kosong:

```text
Nama barang wajib diisi
```

Jika sudah diisi, validator mengembalikan:

```dart
return null;
```

yang berarti input valid.

---

# 15. Input Jumlah

Jumlah barang menggunakan:

```dart
TextFormField(
  controller: _jumlahController,
  keyboardType: TextInputType.number,
)
```

`keyboardType` digunakan agar keyboard angka ditampilkan ketika pengguna mengisi jumlah.

Validasinya:

```dart
validator: (value) {
  if (value == null ||
      value.trim().isEmpty) {
    return 'Jumlah wajib diisi';
  }

  final jumlah = int.tryParse(value.trim());

  if (jumlah == null) {
    return 'Jumlah harus berupa angka';
  }

  if (jumlah <= 0) {
    return 'Jumlah harus lebih dari 0';
  }

  return null;
},
```

Validasi tersebut memastikan:

1. Jumlah tidak boleh kosong.
2. Jumlah harus berupa angka.
3. Jumlah harus lebih dari 0.

---

# 16. Dropdown Kategori

Kategori menggunakan `DropdownButtonFormField`.

```dart
DropdownButtonFormField<String>(
  value: _kategori,

  decoration: const InputDecoration(
    labelText: 'Kategori',
    border: OutlineInputBorder(),
  ),

  items: _kategoriList.map((kategori) {
    return DropdownMenuItem(
      value: kategori,
      child: Text(kategori),
    );
  }).toList(),

  onChanged: (value) {
    setState(() {
      _kategori = value;
    });
  },

  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Kategori wajib dipilih';
    }

    return null;
  },
)
```

Kategori yang tersedia:

```dart
final List<String> _kategoriList = [
  'Makanan',
  'Minuman',
  'Kebutuhan Rumah',
  'Elektronik',
  'Lainnya',
];
```

Validator memastikan pengguna memilih salah satu kategori.

---

# 17. Tombol Simpan dan Validasi

Ketika tombol Simpan ditekan:

```dart
void _simpan() {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  final nama = _namaController.text.trim();
  final jumlah = int.parse(
    _jumlahController.text.trim(),
  );

  context.read<BelanjaModel>().tambahBarang(
    nama,
    jumlah,
    _kategori!,
  );

  Navigator.pop(context);
}
```

### Alur proses

```text
Klik Simpan
     ↓
Jalankan validate()
     ↓
Apakah semua input valid?
     │
   ┌─┴─┐
  Tidak Ya
   │    │
   ↓    ↓
 Error  Tambahkan
        barang
          ↓
      Kembali ke
      halaman daftar
```

Jika terdapat input yang salah, proses berhenti:

```dart
return;
```

Jika semua valid, barang dimasukkan ke `BelanjaModel`.

---

# 18. TextEditingController

Controller digunakan untuk mengambil isi input.

```dart
final _namaController = TextEditingController();
final _jumlahController = TextEditingController();
```

Untuk membaca nilai:

```dart
_namaController.text
```

dan:

```dart
_jumlahController.text
```

Controller juga harus dibersihkan ketika halaman tidak digunakan lagi:

```dart
@override
void dispose() {
  _namaController.dispose();
  _jumlahController.dispose();
  super.dispose();
}
```

Hal ini dilakukan untuk melepaskan resource yang digunakan oleh controller.

---

# 📱 Tampilan Aplikasi

## Halaman Daftar

Halaman utama menampilkan:

- Judul aplikasi.
- Jumlah barang yang belum dibeli.
- Daftar barang.
- Checkbox status pembelian.
- Tombol hapus.
- Floating Action Button untuk menambahkan barang.

Contoh:

```text
┌─────────────────────────────────┐
│ Daftar Belanja (2 belum dibeli) │
├─────────────────────────────────┤
│ ☐ Beras                         │
│   2 • Makanan              🗑   │
│                                 │
│ ☑ Minyak                        │
│   1 • Kebutuhan Rumah      🗑   │
│                                 │
│                         (+)     │
└─────────────────────────────────┘
```

---

## Halaman Form Tambah

Form terdiri dari:

```text
Nama Barang
[_____________________]

Jumlah
[_____________________]

Kategori
[ Pilih kategori     ▼ ]

[        Simpan       ]
```

Jika terdapat kesalahan input, pesan validasi akan muncul di bawah field yang bersangkutan.

---

# 🧪 Pengujian Validasi

Beberapa kondisi yang diuji:

| Input | Hasil |
|---|---|
| Nama kosong | `Nama barang wajib diisi` |
| Jumlah kosong | `Jumlah wajib diisi` |
| Jumlah berupa huruf | `Jumlah harus berupa angka` |
| Jumlah 0 | `Jumlah harus lebih dari 0` |
| Kategori tidak dipilih | `Kategori wajib dipilih` |
| Semua input benar | Barang berhasil ditambahkan |

---

# 🔄 Alur State Management

State aplikasi menggunakan satu `BelanjaModel`.

```text
                 BelanjaModel
                 ChangeNotifier
                      │
          ┌───────────┴───────────┐
          │                       │
     DaftarPage              TambahBarangPage
          │                       │
     watch/read               read
          │                       │
          └───────────┬───────────┘
                      │
                  notifyListeners()
                      │
                UI diperbarui
```

Dengan pendekatan ini, data barang tidak dibuat terpisah di setiap halaman. Semua halaman menggunakan state yang sama dari `BelanjaModel`.

---

# 📚 Kesimpulan

Aplikasi Daftar Belanja menerapkan konsep **Form Input dan State Management** pada Flutter.

Konsep utama yang digunakan adalah:

1. `TextFormField` untuk membuat input.
2. `TextEditingController` untuk mengakses isi input.
3. `Form` dan `GlobalKey<FormState>` untuk validasi.
4. `DropdownButtonFormField` untuk pilihan kategori.
5. `ChangeNotifier` untuk menyimpan dan mengelola state.
6. `Provider` untuk membagikan state ke widget.
7. `context.watch()` untuk mendengarkan perubahan state.
8. `context.read()` untuk menjalankan aksi pada state.
9. `notifyListeners()` untuk memperbarui tampilan ketika data berubah.

Dengan implementasi tersebut, aplikasi dapat menambahkan, menampilkan, menandai, dan menghapus barang belanja sekaligus menampilkan jumlah barang yang belum dibeli.

---

# ▶️ Cara Menjalankan

Clone repository atau buka folder project Flutter, kemudian jalankan:

```bash
flutter pub get
```

Kemudian:

```bash
flutter run
```

Untuk menjalankan pada emulator Android:

```bash
flutter devices
```

Lalu:

```bash
flutter run -d emulator-5554
```

Sesuaikan `emulator-5554` dengan device yang tersedia.

---

# 📸 Dokumentasi

Screenshot yang disarankan untuk dimasukkan ke repository:

```text
screenshots/
├── daftar_barang.png
├── form_tambah.png
├── validasi_nama.png
├── validasi_jumlah.png
├── validasi_kategori.png
└── barang_sudah_dibeli.png
```

Screenshot tersebut menunjukkan halaman daftar, form tambah, pesan validasi, serta perubahan status barang.