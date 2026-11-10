import 'package:flutter/material.dart';

// Titik awal aplikasi
void main() {
  runApp(const TabungkuApp());
}

// Widget akar aplikasi: mengatur judul dan tema
class TabungkuApp extends StatelessWidget {
  const TabungkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabungku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const RingkasanPage(),
    );
  }
}

// Model sederhana untuk satu transaksi (data statis)
class Transaksi {
  final String judul;
  final String tanggal;
  final int nominal; // positif = masuk, negatif = keluar

  const Transaksi(this.judul, this.tanggal, this.nominal);
}

// Halaman Ringkasan Tabungan
class RingkasanPage extends StatelessWidget {
  const RingkasanPage({super.key});

  // Data transaksi hard-code
  static const List<Transaksi> daftarTransaksi = [
    Transaksi('Setoran Gaji', '01 Nov 2026', 500000),
    Transaksi('Beli Buku', '03 Nov 2026', -75000),
    Transaksi('Uang Saku Tambahan', '05 Nov 2026', 150000),
    Transaksi('Tarik Tunai', '08 Nov 2026', -200000),
  ];

  // Mengubah angka menjadi format Rupiah, mis. 1250000 -> Rp 1.250.000
  static String rupiah(int angka) {
    final negatif = angka < 0;
    final teks = angka.abs().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < teks.length; i++) {
      if (i > 0 && (teks.length - i) % 3 == 0) buffer.write('.');
      buffer.write(teks[i]);
    }
    return '${negatif ? '-' : ''}Rp $buffer';
  }

  @override
  Widget build(BuildContext context) {
    const int saldo = 1250000;
    const int target = 5000000;

    return Scaffold(
      // AppBar dengan judul halaman
      appBar: AppBar(
        title: const Text('Ringkasan Tabungan'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Center + ConstrainedBox: konten dibatasi lebarnya agar tetap rapi di tablet
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          // SingleChildScrollView: mencegah overflow vertikal di layar kecil
          child: SingleChildScrollView(
            // Padding: jarak tepi seluruh isi halaman
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _kartuTabungan(context, saldo, target),
                const SizedBox(height: 24),
                _barisKategori(context),
                const SizedBox(height: 24),
                const Text(
                  'Transaksi Terakhir',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _daftarTransaksi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Bagian 1: Kartu berisi nama tabungan, saldo, dan target
  Widget _kartuTabungan(BuildContext context, int saldo, int target) {
    final progres = saldo / target;

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        // Column menyusun isi kartu dari atas ke bawah
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row: ikon dan nama tabungan sejajar horizontal
            const Row(
              children: [
                Icon(Icons.savings, color: Colors.teal),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tabungan Laptop Baru',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Row: saldo di kiri, target di kanan, dibagi rata dengan Expanded
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Saldo', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        rupiah(saldo),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Target', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        rupiah(target),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Indikator progres menuju target
            LinearProgressIndicator(value: progres, minHeight: 8),
            const SizedBox(height: 6),
            Text('${(progres * 100).toStringAsFixed(0)}% tercapai'),
          ],
        ),
      ),
    );
  }

  // Bagian 2: Satu Row berisi tiga kategori (Menabung, Tarik, Riwayat)
  Widget _barisKategori(BuildContext context) {
    return Row(
      // spaceEvenly: jarak antar tombol merata
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _itemKategori(Icons.add_circle, 'Menabung', Colors.green),
        _itemKategori(Icons.remove_circle, 'Tarik', Colors.red),
        _itemKategori(Icons.history, 'Riwayat', Colors.blue),
      ],
    );
  }

  // Satu tombol kategori: ikon di atas, label di bawah
  Widget _itemKategori(IconData ikon, String label, Color warna) {
    return Expanded(
      child: Column(
        children: [
          IconButton.filledTonal(
            onPressed: () {}, // belum ada fungsi, hanya tata letak
            iconSize: 32,
            icon: Icon(ikon, color: warna),
          ),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }

  // Bagian 3: Daftar transaksi sederhana (judul, tanggal, nominal)
  Widget _daftarTransaksi() {
    return Column(
      // Setiap data diubah menjadi satu baris Card
      children: daftarTransaksi.map((t) {
        final masuk = t.nominal >= 0;
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  masuk ? Icons.arrow_downward : Icons.arrow_upward,
                  color: masuk ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 12),
                // Expanded: judul dan tanggal mengisi sisa ruang agar tidak overflow
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.judul,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        t.tanggal,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                // Nominal di sisi kanan, hijau untuk masuk dan merah untuk keluar
                Text(
                  '${masuk ? '+' : ''}${rupiah(t.nominal)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: masuk ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
