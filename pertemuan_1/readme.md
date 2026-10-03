# Praktikum Flutter Fundamental - Pertemuan 1

## Deskripsi
Praktikum ini membahas dasar-dasar pengembangan aplikasi menggunakan Flutter dan Dart. 
Materi mencakup konsep Widget, pembuatan tampilan menggunakan layout sederhana, serta pengelolaan state menggunakan StatefulWidget.

## Materi yang Dipelajari

### 1. Widget pada Flutter
Widget merupakan komponen utama dalam membangun antarmuka aplikasi Flutter.

- `StatelessWidget` digunakan untuk tampilan yang tidak berubah.
- `StatefulWidget` digunakan untuk tampilan yang dapat berubah berdasarkan state.
- `setState()` digunakan untuk memperbarui tampilan ketika nilai state berubah.
- Hot Reload digunakan untuk melihat perubahan kode dengan cepat.

### 2. Layout Flutter
Praktikum menggunakan beberapa widget dasar untuk menyusun tampilan, yaitu:

- `Column` untuk menyusun widget secara vertikal.
- `Center` untuk menempatkan widget di tengah.
- `Text` untuk menampilkan teks.
- `Icon` untuk menampilkan ikon.
- `SizedBox` untuk memberikan jarak antar-widget.
- `Scaffold` sebagai struktur dasar halaman aplikasi.
- `AppBar` sebagai bagian atas halaman.

### 3. StatefulWidget dan Counter
Praktikum membuat aplikasi counter sederhana menggunakan `StatefulWidget`.

Fitur yang dipelajari:
- Menambah nilai counter.
- Mengurangi nilai counter.
- Mereset counter menjadi `0`.
- Mencegah nilai counter menjadi negatif.

Perubahan nilai counter dilakukan menggunakan `setState()` agar tampilan aplikasi ikut diperbarui.

### 4. Kartu Perkenalan
Sebagai tugas akhir, dibuat aplikasi satu halaman berupa **Kartu Perkenalan** yang menampilkan:

- Foto atau ikon.
- Nama.
- NIM.
- Jurusan.
- Hobi.

Tampilan dibuat menggunakan `Column`, `Text`, `Icon`, dan `SizedBox`.

## Tujuan Praktikum
Praktikum ini bertujuan memahami dasar penggunaan Flutter, struktur widget, pembuatan layout sederhana, serta perbedaan antara `StatelessWidget` dan `StatefulWidget`.