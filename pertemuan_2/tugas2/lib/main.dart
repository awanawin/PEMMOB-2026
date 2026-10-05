import 'package:flutter/material.dart';

// Fungsi utama untuk menjalankan aplikasi
void main() => runApp(const MyApp());

// Class utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Kontak',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),

      // Halaman pertama yang ditampilkan
      home: const KontakPage(),
    );
  }
}

// Class model untuk menyimpan data kontak
class Kontak {
  final String nama;
  final String nomorTelepon;
  final String email;

  // Constructor untuk membuat objek kontak
  const Kontak(this.nama, this.nomorTelepon, this.email);
}

// List yang berisi objek-objek kontak
// Minimal 6 kontak sesuai ketentuan tugas
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
  Kontak(
    'Andi Saputra',
    '083456789012',
    'andi@gmail.com',
  ),
  Kontak(
    'Rizky Ramadhan',
    '084567890123',
    'rizky@gmail.com',
  ),
  Kontak(
    'Fajar Maulana',
    '085678901234',
    'fajar@gmail.com',
  ),
  Kontak(
    'Dimas Pratama',
    '086789012345',
    'dimas@gmail.com',
  ),
];

// Halaman utama yang menampilkan daftar kontak
class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Judul halaman
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
      ),

      // ListView.builder digunakan untuk membuat daftar kontak
      // yang dapat di-scroll
      body: ListView.builder(
        itemCount: daftarKontak.length,

        // Membuat setiap item kontak
        itemBuilder: (context, index) {
          final kontak = daftarKontak[index];

          // Container digunakan sebagai pembungkus ListTile
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),

            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
            ),

            child: ListTile(
              // Avatar berisi huruf pertama dari nama kontak
              leading: CircleAvatar(
                child: Text(
                  kontak.nama[0],
                ),
              ),

              // Menampilkan nama kontak
              title: Text(kontak.nama),

              // Menampilkan nomor telepon
              subtitle: Text(kontak.nomorTelepon),

              // Icon tanda bahwa item dapat diklik
              trailing: const Icon(Icons.chevron_right),

              // Ketika kontak ditekan, pindah ke halaman detail
              onTap: () {
                Navigator.push(
                  context,

                  // Mengirim objek kontak ke DetailPage
                  MaterialPageRoute(
                    builder: (_) => DetailPage(
                      kontak: kontak,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Halaman detail kontak
class DetailPage extends StatelessWidget {
  // Menyimpan objek kontak yang dikirim dari halaman utama
  final Kontak kontak;

  // Constructor untuk menerima data kontak
  const DetailPage({
    super.key,
    required this.kontak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar menampilkan nama kontak
      appBar: AppBar(
        title: Text(kontak.nama),
      ),

      // Menampilkan seluruh data kontak
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar kontak
            CircleAvatar(
              radius: 45,
              child: Text(
                kontak.nama[0],
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Menampilkan nama
            Text(
              kontak.nama,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Menampilkan nomor telepon
            Text(
              'Telepon: ${kontak.nomorTelepon}',
            ),

            const SizedBox(height: 8),

            // Menampilkan email
            Text(
              'Email: ${kontak.email}',
            ),

            const SizedBox(height: 24),

            // Tombol untuk kembali ke halaman daftar kontak
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}