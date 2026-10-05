# Praktikum Pemrograman Mobile — Pertemuan 2

## Deskripsi

Praktikum Pertemuan 2 membahas dasar pembuatan antarmuka aplikasi menggunakan Flutter. Materi berfokus pada penggunaan widget layout, pembuatan daftar data, penggunaan model/class pada Dart, serta navigasi dari halaman utama menuju halaman detail.

Pada praktikum ini dibuat aplikasi sederhana yang menampilkan daftar menu dan halaman detail dari setiap menu.

---

## Tujuan Praktikum

Tujuan dari praktikum ini adalah:

1. Memahami penggunaan widget `Container`, `Padding`, `Row`, `Column`, dan `Expanded`.
2. Memahami penggunaan `ListView.builder` untuk membuat daftar data.
3. Memahami penggunaan `Card` dan `ListTile`.
4. Membuat model data menggunakan `class` pada Dart.
5. Menampilkan data dari sebuah list ke dalam antarmuka Flutter.
6. Memahami navigasi antar halaman menggunakan `Navigator.push()` dan `Navigator.pop()`.
7. Mengirim data dari halaman utama ke halaman detail.

---

## Materi yang Dipelajari

### 1. Layout Flutter

Flutter menyediakan berbagai widget untuk mengatur posisi dan tampilan komponen.

Beberapa widget yang digunakan:

* `Container` — membuat wadah untuk widget.
* `Padding` — memberikan jarak di sekitar widget.
* `Row` — menyusun widget secara horizontal.
* `Column` — menyusun widget secara vertikal.
* `Expanded` — membuat widget mengisi ruang yang tersedia.

Contoh:

```dart
Column(
  children: [
    Text('Nama'),
    SizedBox(height: 10),
    Text('NIM'),
  ],
)
```

---

### 2. Model Data dengan Class

Data dapat dibuat menggunakan `class` agar lebih terstruktur.

Contoh dari praktikum:

```dart
class Makanan {
  final String nama;
  final int harga;

  const Makanan(this.nama, this.harga);
}
```

Class tersebut memiliki dua properti yaitu `nama` dan `harga`.

Objek kemudian dapat dibuat seperti:

```dart
const daftarMenu = [
  Makanan('Nasi Goreng', 15000),
  Makanan('Mie Ayam', 12000),
  Makanan('Es Teh', 4000),
];
```

Dengan cara tersebut, setiap menu menjadi sebuah objek dari class `Makanan`.

---

### 3. ListView.builder

`ListView.builder` digunakan untuk membuat daftar secara dinamis berdasarkan jumlah data yang tersedia.

Contoh:

```dart
ListView.builder(
  itemCount: daftarMenu.length,
  itemBuilder: (context, index) {
    final item = daftarMenu[index];

    return ListTile(
      title: Text(item.nama),
      subtitle: Text('Rp ${item.harga}'),
    );
  },
)
```

`itemCount` menentukan jumlah data yang ditampilkan, sedangkan `itemBuilder` digunakan untuk membuat tampilan setiap item.

---

### 4. Card dan ListTile

`Card` dapat digunakan sebagai pembungkus item agar setiap data terlihat seperti sebuah kartu.

Contoh:

```dart
Card(
  child: ListTile(
    leading: const Icon(Icons.restaurant),
    title: Text(item.nama),
    subtitle: Text('Rp ${item.harga}'),
  ),
)
```

`ListTile` menyediakan struktur sederhana untuk menampilkan informasi seperti:

* `leading`
* `title`
* `subtitle`
* `trailing`

---

### 5. Navigasi dengan Navigator

Flutter menggunakan `Navigator` untuk berpindah antar halaman.

Untuk membuka halaman baru digunakan:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => DetailPage(makanan: item),
  ),
);
```

Data `item` dikirim ke halaman `DetailPage`.

Untuk kembali ke halaman sebelumnya digunakan:

```dart
Navigator.pop(context);
```

---

## Mengirim Data ke Halaman Detail

Data dapat diterima oleh halaman detail melalui constructor.

Contoh:

```dart
class DetailPage extends StatelessWidget {
  final Makanan makanan;

  const DetailPage({
    super.key,
    required this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(makanan.nama),
      ),
    );
  }
}
```

Dengan cara tersebut, objek `Makanan` dari halaman utama dapat digunakan kembali pada halaman detail.

---

## Pengembangan pada Praktikum

Pada implementasi tugas, aplikasi dikembangkan menjadi aplikasi daftar kontak.

Model data diubah menjadi:

```dart
class Kontak {
  final String nama;
  final String nomorTelepon;
  final String email;

  const Kontak(
    this.nama,
    this.nomorTelepon,
    this.email,
  );
}
```

Data kontak disimpan dalam sebuah list:

```dart
const daftarKontak = [
  Kontak(
    'Gunawan Nastiar',
    '081234567890',
    'gunawan@gmail.com',
  ),
  Kontak(
    'Bani Adam',
    '082345678901',
    'bani@gmail.com',
  ),
];
```

Daftar tersebut kemudian ditampilkan menggunakan `ListView.builder`.

Avatar dengan huruf pertama nama dibuat menggunakan:

```dart
CircleAvatar(
  child: Text(
    kontak.nama[0],
  ),
)
```

Ketika kontak ditekan, aplikasi berpindah ke halaman detail:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => DetailPage(
      kontak: kontak,
    ),
  ),
);
```

Halaman detail menampilkan data kontak dan memiliki tombol kembali:

```dart
ElevatedButton(
  onPressed: () => Navigator.pop(context),
  child: const Text('Kembali'),
)
```

---

## Alur Aplikasi

```text
Halaman Utama
     │
     ▼
Daftar Kontak
     │
     │ klik kontak
     ▼
Halaman Detail
     │
     │ klik kembali
     ▼
Daftar Kontak
```

---

## Kesimpulan

Praktikum Pertemuan 2 memberikan pemahaman dasar mengenai pembuatan antarmuka dan pengelolaan data pada Flutter. Materi yang dipelajari meliputi penggunaan widget layout, pembuatan model menggunakan class, menampilkan data menggunakan `ListView.builder`, penggunaan `ListTile`, serta navigasi antar halaman menggunakan `Navigator.push()` dan `Navigator.pop()`.

Konsep tersebut kemudian diterapkan dalam pembuatan aplikasi **Daftar Kontak** yang memiliki daftar kontak dan halaman detail untuk setiap kontak.
