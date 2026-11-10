# Tabungku Layout

Tugas Minggu 3: Menyusun Layout dengan Widget Dasar Flutter.

Layar ringkasan tabungan untuk aplikasi Tabungku, dibuat hanya dengan widget dasar Flutter (tanpa paket pihak ketiga).

## Identitas

| | |
|---|---|
| Nama | Gunawan Nastiar |
| NIM | 20240801114 |
| Kampus | Universitas Esa Unggul |
| Mata Kuliah | Pemrograman Mobile |

## Isi Layar

1. **AppBar** berjudul "Ringkasan Tabungan".
2. **Card tabungan**: nama tabungan, saldo, dan target (disusun dengan `Column` dan `Row`), plus indikator progres.
3. **Row kategori**: tiga tombol ikon (Menabung, Tarik, Riwayat).
4. **Daftar transaksi**: empat item statis, masing-masing berisi judul, tanggal, dan nominal.

Widget yang dipakai: `Scaffold`, `AppBar`, `Card`, `Column`, `Row`, `Padding`, `Expanded`, `SizedBox`, `Icon`, `IconButton`, `Text`, `LinearProgressIndicator`, `SingleChildScrollView`, `Center`, `ConstrainedBox`.

## Cara Menjalankan

Prasyarat: Flutter SDK terpasang (`flutter doctor` tanpa masalah).

```bash
# 1. Masuk ke folder proyek
cd tabungku_layout

# 2. Unduh dependensi
flutter pub get

# 3. Jalankan di Chrome
flutter run -d chrome

# atau jalankan di perangkat/emulator Android yang terhubung
flutter run
```

Cek galat dengan:

```bash
flutter analyze
```

## Anti-Overflow

- `SingleChildScrollView` membuat halaman bisa digulir di layar pendek.
- `Expanded` dan `overflow: TextOverflow.ellipsis` menjaga teks tidak keluar dari baris.
- `ConstrainedBox(maxWidth: 600)` membatasi lebar konten di tablet supaya tidak melebar berlebihan.

## Dokumentasi Hasil

Uji dengan dua ukuran layar. Di Chrome, buka DevTools (`F12`), aktifkan mode perangkat (`Ctrl+Shift+M`), lalu pilih ukuran.

### Layar Ponsel (contoh 390 x 844)

![Tampilan ponsel](screenshots/ponsel.png)

### Layar Tablet (contoh 820 x 1180)

![Tampilan tablet](screenshots/tablet.png)

Hasil: tidak ada overflow pada kedua ukuran layar.
