# Nuvora Flutter

Proyek hasil konversi arsip Stitch: 27 halaman.

## Menjalankan
1. Ekstrak ZIP.
2. Buka folder proyek di VS Code / Android Studio.
3. Jalankan `flutter pub get`.
4. Jalankan `flutter run`.

## Struktur
- `lib/main.dart`: galeri navigasi seluruh halaman.
- `lib/screens/`: satu file Dart per halaman.
- `assets/screens/`: HTML asli dan screenshot referensi.

## Catatan
Setiap halaman dirender dengan `webview_flutter` dari HTML asli Stitch. Ini mempertahankan tampilan lebih akurat daripada konversi otomatis HTML/Tailwind kompleks menjadi widget native. Tailwind CDN dan Google Fonts pada HTML mungkin membutuhkan koneksi internet.
