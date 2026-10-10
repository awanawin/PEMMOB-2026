# Praktikum Flutter Fundamental - Pertemuan 4
## Aplikasi Daftar Postingan

### 1. Deskripsi Aplikasi

Aplikasi Daftar Postingan merupakan aplikasi Flutter yang mengambil data dari REST API menggunakan HTTP request. Aplikasi menampilkan daftar postingan, isi lengkap postingan, serta komentar yang diperoleh dari endpoint terpisah.

Aplikasi ini dibuat untuk menerapkan materi pemrograman asinkron di Dart, pengolahan JSON, penggunaan model data, dan widget `FutureBuilder`.

### 2. Tujuan Praktikum

- Memahami konsep `Future`, `async`, dan `await`.
- Mengambil data dari REST API menggunakan package `http`.
- Mengubah respons JSON menjadi objek Dart menggunakan `fromJson()`.
- Menampilkan data menggunakan `FutureBuilder`.
- Menangani status loading dan error.
- Menyediakan tombol untuk mencoba kembali ketika terjadi kegagalan.
- Menggunakan navigasi untuk membuka halaman detail postingan.

### 3. Teknologi yang Digunakan

- **Flutter**: framework untuk membangun aplikasi.
- **Dart**: bahasa pemrograman aplikasi.
- **HTTP**: package untuk mengirim permintaan ke REST API.
- **JSONPlaceholder**: API publik untuk data latihan.
- **FutureBuilder**: widget untuk menampilkan hasil operasi asinkron.

### 4. Endpoint REST API

| Endpoint | Fungsi |
|---|---|
| `https://jsonplaceholder.typicode.com/posts` | Mengambil daftar postingan. |
| `https://jsonplaceholder.typicode.com/posts/{id}/comments` | Mengambil komentar berdasarkan ID postingan. |

Contoh endpoint komentar untuk postingan dengan ID 1:

`https://jsonplaceholder.typicode.com/posts/1/comments`

### 5. Struktur File

```text
project/
├── lib/
│   ├── main.dart
│   ├── models.dart
│   └── api_service.dart
├── pubspec.yaml
└── README.md
```

Keterangan:

- `main.dart`: berisi tampilan daftar postingan, halaman detail, navigasi, dan `FutureBuilder`.
- `models.dart`: berisi model `Post` dan `Komentar` beserta fungsi `fromJson()`.
- `api_service.dart`: berisi fungsi untuk mengambil data postingan dan komentar dari API.
- `pubspec.yaml`: berisi konfigurasi project dan dependensi.

### 6. Cara Menjalankan Aplikasi

**Langkah 1 — Instal dependensi HTTP**

Jalankan perintah berikut di terminal pada folder project:

```bash
flutter pub add http
```

**Langkah 2 — Ambil dependensi**

```bash
flutter pub get
```

**Langkah 3 — Jalankan aplikasi**

```bash
flutter run
```

Pastikan perangkat atau emulator terhubung ke internet agar aplikasi dapat mengambil data dari API.

### 7. Fitur Aplikasi

1. **Daftar postingan**  
   Menampilkan judul dan potongan isi postingan dari endpoint `/posts`.

2. **Detail postingan**  
   Menampilkan judul dan isi lengkap postingan yang dipilih.

3. **Daftar komentar**  
   Mengambil komentar dari endpoint `/posts/{id}/comments` menggunakan Future kedua.

4. **Loading**  
   Menampilkan indikator proses ketika data sedang dimuat.

5. **Penanganan error**  
   Menampilkan pesan kesalahan jika pengambilan data gagal.

6. **Tombol Coba Lagi**  
   Mengulang permintaan data ketika terjadi kesalahan.

7. **Navigasi halaman**  
   Memungkinkan pengguna membuka detail postingan dengan mengetuk salah satu item daftar.

### 8. Konsep Pemrograman yang Digunakan

- **Future** adalah objek yang merepresentasikan hasil operasi yang tersedia di masa mendatang.
- **async/await** digunakan untuk menjalankan dan menunggu proses asinkron, seperti HTTP request.
- **HTTP GET** digunakan untuk meminta data dari server.
- **JSON** merupakan format data yang diterima dari REST API.
- **fromJson()** digunakan untuk mengubah data JSON menjadi objek model Dart.
- **FutureBuilder** membangun tampilan berdasarkan status Future, baik loading, error, maupun data berhasil diterima.
- **Navigator.push()** digunakan untuk berpindah dari halaman daftar ke halaman detail.

### 9. Pengujian Aplikasi

| No. | Pengujian | Hasil yang Diharapkan |
|---|---|---|
| 1 | Membuka aplikasi | Daftar postingan tampil setelah data berhasil dimuat. |
| 2 | Mengetuk postingan | Halaman detail menampilkan isi lengkap postingan. |
| 3 | Membuka detail | Daftar komentar dimuat dari endpoint terpisah. |
| 4 | Menggunakan URL yang salah | Aplikasi menampilkan pesan error. |
| 5 | Menekan tombol Coba Lagi | Aplikasi mengulangi permintaan data. |
| 6 | Memutus koneksi internet | Aplikasi menampilkan galat jaringan. |

### 10. Dokumentasi Screenshot

Screenshot yang dikumpulkan:

1. Halaman daftar postingan.
2. Halaman detail postingan beserta komentar.
3. Tampilan galat saat permintaan data gagal.

Screenshot harus diambil dari aplikasi yang benar-benar dijalankan pada emulator atau perangkat.

### 11. Kesimpulan

Melalui praktikum ini, mahasiswa mempelajari cara mengambil data dari REST API menggunakan Flutter, mengolah respons JSON menjadi objek Dart, dan menampilkan data secara asinkron menggunakan `FutureBuilder`.

Pemisahan model, layanan API, dan antarmuka membantu membuat kode lebih terstruktur. Penggunaan penanganan error serta tombol Coba Lagi juga membuat aplikasi lebih siap menghadapi kegagalan jaringan atau respons API yang tidak berhasil.