import 'package:flutter/material.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 2',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const MenuPage(),
    );
  }
}

class Makanan {
  final String nama;
  final int harga;
  //tambahkan variabel baru
  final String deskripsi;

  const Makanan(this.nama, this.harga, this.deskripsi);
}

const daftarMenu = [
  Makanan('Nasi Goreng', 15000,'nasi murah'),
  Makanan('Mie Ayam', 12000,'mie ayam bakso'),
  Makanan('Es Teh', 4000,'es teh enak banget'),
  Makanan('Ayam Bakar', 20000,'ayam bakar suramadu enak'),
  Makanan('Ikan Bakekok',100000,'ikan bakekok khas madura'),
  Makanan('Ayam Aneh',100500,'ayamhahahahaha'),
  Makanan('dimsum emntai',100000,'dararimsum euy')
];

//code untuk formt ribuan
String formatHarga(int harga) {
  return harga.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (match) => '.',
  );
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Menu')),
      body: ListView.builder(
        itemCount: daftarMenu.length,
        itemBuilder: (context, index) {
          final item = daftarMenu[index];
          //ganti card ke container
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: const Icon(Icons.restaurant),
              title: Text(item.nama),
              //ubah format harga
              subtitle: Text('Rp ${formatHarga(item.harga)}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailPage(makanan: item)),
                );
              },

            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Makanan makanan;

  const DetailPage({super.key, required this.makanan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(makanan.nama)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.restaurant_menu, size: 80),
            const SizedBox(height: 16),
            Text(makanan.nama, style: const TextStyle(fontSize: 24)),
            Text('Rp ${makanan.harga}'),
            Text(makanan.deskripsi,textAlign: TextAlign.center,),
            const SizedBox(height: 24),
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
