import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tugas {
  String judul;
  bool selesai;

  Tugas(this.judul, {this.selesai = false});
}

class TugasModel extends ChangeNotifier {
  final List<Tugas> _items = [];

  List<Tugas> get items => List.unmodifiable(_items);

  int get jumlahSelesai => _items.where((t) => t.selesai).length;

  void tambah(String judul) {
    _items.add(Tugas(judul));
    notifyListeners();
  }

  void toggle(int index) {
    _items[index].selesai = !_items[index].selesai;
    notifyListeners();
  }

  void hapus(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  // (pengertian) Method untuk menghapus semua tugas yang statusnya sudah selesai.
  void hapusSelesai() {
    _items.removeWhere((t) => t.selesai);
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TugasModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Tugas',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const TugasPage(),
    );
  }
}

class TugasPage extends StatelessWidget {
  const TugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TugasModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tugas (${model.jumlahSelesai}/${model.items.length})',
        ),

        // (pengertian) Tombol untuk menghapus semua tugas yang sudah selesai.
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Hapus tugas selesai',
            onPressed: model.jumlahSelesai == 0
                ? null
                : () {
              context.read<TugasModel>().hapusSelesai();
            },
          ),
        ],
      ),

      // (pengertian) Jika daftar tugas kosong, tampilkan teks di tengah layar.
      body: model.items.isEmpty
          ? const Center(
        child: Text(
          'Belum ada tugas',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (context, i) {
          final t = model.items[i];

          return ListTile(
            leading: Checkbox(
              value: t.selesai,
              onChanged: (_) =>
                  context.read<TugasModel>().toggle(i),
            ),
            title: Text(
              t.judul,
              style: TextStyle(
                decoration: t.selesai
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () =>
                  context.read<TugasModel>().hapus(i),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TambahPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TambahPage extends StatefulWidget {
  const TambahPage({super.key});

  @override
  State<TambahPage> createState() => _TambahPageState();
}

class _TambahPageState extends State<TambahPage> {
  final _controller = TextEditingController();

  // (pengertian) GlobalKey digunakan untuk mengontrol dan menjalankan validasi Form.
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _simpan() {
    // (pengertian) validate() menjalankan validator pada TextFormField.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final judul = _controller.text.trim();

    context.read<TugasModel>().tambah(judul);

    // (pengertian) Menampilkan SnackBar sebagai notifikasi bahwa tugas berhasil ditambahkan.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tugas ditambahkan'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          // (pengertian) Form digunakan untuk mengelompokkan input yang membutuhkan validasi.
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Judul tugas',
                  border: OutlineInputBorder(),
                ),

                // (pengertian) Validator memastikan judul tidak kosong dan minimal memiliki 3 karakter.
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul tugas wajib diisi';
                  }

                  if (value.trim().length < 3) {
                    return 'Judul tugas minimal 3 karakter';
                  }

                  return null;
                },

                // (pengertian) Ketika user menekan Enter, fungsi _simpan() akan dijalankan.
                onFieldSubmitted: (_) => _simpan(),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: _simpan,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}