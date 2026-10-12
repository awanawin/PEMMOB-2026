import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Menjalankan aplikasi Flutter.
void main() {
  runApp(const MyApp());
}

// Widget utama aplikasi.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Praktikum 5',
      debugShowCheckedModeBanner: false,
      home: CatatanPage(),
    );
  }
}

// Model untuk menyimpan data catatan.
class Catatan {
  final int? id;
  final String judul;
  final String isi;
  final String dibuat;

  const Catatan({
    this.id,
    required this.judul,
    required this.isi,
    this.dibuat = '',
  });

  // Mengubah objek Catatan menjadi Map untuk SQLite.
  Map<String, Object?> toMap() => {
    'id': id,
    'judul': judul,
    'isi': isi,
    'dibuat': dibuat,
  };

  // Mengubah data Map dari SQLite menjadi objek Catatan.
  factory Catatan.fromMap(Map<String, Object?> m) => Catatan(
    id: m['id'] as int,
    judul: m['judul'] as String,
    isi: m['isi'] as String,
    dibuat: m['dibuat'] as String? ?? '',
  );
}

// Mengelola database SQLite dan operasi CRUD.
class DbHelper {
  static Database? _db;

  // Membuka database dan membuat tabel jika belum tersedia.
  static Future<Database> get database async {
    if (_db != null && _db!.isOpen) return _db!;

    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'catatan.db');

    _db = await openDatabase(
      path,
      version: 2, // Menaikkan versi database menjadi 2.
      onCreate: (db, version) async {
        // Membuat tabel baru dengan kolom tanggal dibuat.
        await db.execute('''
          CREATE TABLE catatan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            judul TEXT NOT NULL,
            isi TEXT NOT NULL,
            dibuat TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Menambahkan kolom dibuat jika database masih versi 1.
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE catatan ADD COLUMN dibuat TEXT',
          );
        }
      },
    );

    return _db!;
  }

  // CREATE: menambahkan catatan baru.
  static Future<int> tambah(Catatan c) async {
    final db = await database;
    return db.insert('catatan', c.toMap());
  }

  // READ: mengambil catatan dengan pencarian dan pengurutan.
  static Future<List<Catatan>> cari(
      String kata,
      String urutan,
      ) async {
    final db = await database;

    // Memilih urutan terbaru atau terlama berdasarkan ID.
    final orderBy = urutan == 'terlama' ? 'id ASC' : 'id DESC';

    // Memfilter judul menggunakan LIKE jika kata pencarian diisi.
    final rows = await db.query(
      'catatan',
      where: kata.trim().isEmpty ? null : 'judul LIKE ?',
      whereArgs: kata.trim().isEmpty ? null : ['%${kata.trim()}%'],
      orderBy: orderBy,
    );

    return rows.map((row) => Catatan.fromMap(row)).toList();
  }

  // UPDATE: mengubah catatan berdasarkan ID.
  static Future<int> ubah(Catatan c) async {
    final db = await database;

    return db.update(
      'catatan',
      c.toMap(),
      where: 'id = ?',
      whereArgs: [c.id],
    );
  }

  // DELETE: menghapus catatan berdasarkan ID.
  static Future<int> hapus(int id) async {
    final db = await database;

    return db.delete(
      'catatan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Halaman daftar catatan, pencarian, dan pengaturan urutan.
class CatatanPage extends StatefulWidget {
  const CatatanPage({super.key});

  @override
  State<CatatanPage> createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  late Future<List<Catatan>> _future;

  // Controller untuk membaca kata pencarian.
  final TextEditingController _cariController = TextEditingController();

  // Menyimpan kata pencarian saat ini.
  String _kata = '';

  // Urutan default catatan adalah terbaru.
  String _urutan = 'terbaru';

  @override
  void initState() {
    super.initState();

    // Menampilkan data awal sebelum preferensi selesai dibaca.
    _future = DbHelper.cari('', _urutan);

    // Membaca pengaturan urutan yang tersimpan.
    _muatPengaturan();
  }

  // Mengambil pilihan urutan dari SharedPreferences.
  Future<void> _muatPengaturan() async {
    final prefs = await SharedPreferences.getInstance();
    final tersimpan = prefs.getString('urutan_catatan') ?? 'terbaru';

    if (!mounted) return;

    setState(() {
      _urutan = tersimpan;
      _muat();
    });
  }

  // Memuat ulang daftar berdasarkan pencarian dan urutan.
  void _muat() {
    _future = DbHelper.cari(_kata, _urutan);
  }

  // Menyimpan perubahan urutan ke SharedPreferences.
  Future<void> _ubahUrutan(String? nilai) async {
    if (nilai == null) return;

    final prefs = await SharedPreferences.getInstance();

    // Menyimpan pilihan agar tetap diingat setelah aplikasi ditutup.
    await prefs.setString('urutan_catatan', nilai);

    if (!mounted) return;

    setState(() {
      _urutan = nilai;
      _muat();
    });
  }

  // Membuka form tambah atau edit catatan.
  Future<void> _buka([Catatan? catatan]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormCatatanPage(catatan: catatan),
      ),
    );

    if (!mounted) return;

    setState(() {
      _muat();
    });
  }

  // Menampilkan dialog konfirmasi sebelum menghapus catatan.
  Future<void> _konfirmasiHapus(Catatan catatan) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Hapus catatan ini?'),
          actions: [
            // Membatalkan proses penghapusan.
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),

            // Mengonfirmasi penghapusan catatan.
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    // Hanya menghapus data jika pengguna memilih Hapus.
    if (konfirmasi != true) return;

    await DbHelper.hapus(catatan.id!);

    if (!mounted) return;

    setState(() {
      _muat();
    });

    // Memberikan informasi bahwa catatan berhasil dihapus.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Catatan berhasil dihapus')),
    );
  }

  @override
  void dispose() {
    // Membersihkan controller saat halaman ditutup.
    _cariController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Saya'),

        // Dropdown untuk memilih urutan terbaru atau terlama.
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _urutan,
                items: const [
                  DropdownMenuItem(
                    value: 'terbaru',
                    child: Text('Terbaru'),
                  ),
                  DropdownMenuItem(
                    value: 'terlama',
                    child: Text('Terlama'),
                  ),
                ],
                onChanged: _ubahUrutan,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // Kolom pencarian berdasarkan judul catatan.
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _cariController,
              decoration: InputDecoration(
                labelText: 'Cari judul catatan',
                hintText: 'Masukkan kata kunci',
                prefixIcon: const Icon(Icons.search),

                // Menghapus teks pencarian.
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _cariController.clear();

                    setState(() {
                      _kata = '';
                      _muat();
                    });
                  },
                ),
                border: const OutlineInputBorder(),
              ),

              // Memperbarui daftar setiap kali kata pencarian berubah.
              onChanged: (nilai) {
                setState(() {
                  _kata = nilai;
                  _muat();
                });
              },
            ),
          ),

          // FutureBuilder menampilkan hasil query database.
          Expanded(
            child: FutureBuilder<List<Catatan>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Menampilkan pesan jika query database gagal.
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Galat: ${snapshot.error}'),
                  );
                }

                final data = snapshot.data ?? [];

                // Pesan berbeda jika pencarian tidak menemukan hasil.
                if (data.isEmpty) {
                  return Center(
                    child: Text(
                      _kata.isEmpty
                          ? 'Belum ada catatan'
                          : 'Catatan tidak ditemukan',
                    ),
                  );
                }

                // Menampilkan daftar catatan hasil pencarian.
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    final c = data[i];

                    return ListTile(
                      title: Text(c.judul),
                      subtitle: Text(
                        '${c.isi}\nDibuat: ${c.dibuat.isEmpty ? "-" : c.dibuat}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Mengetuk catatan membuka form edit.
                      onTap: () => _buka(c),

                      // Tombol hapus meminta konfirmasi terlebih dahulu.
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _konfirmasiHapus(c),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // Tombol untuk menambahkan catatan baru.
      floatingActionButton: FloatingActionButton(
        onPressed: () => _buka(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Form untuk menambah dan mengubah catatan.
class FormCatatanPage extends StatefulWidget {
  final Catatan? catatan;

  const FormCatatanPage({super.key, this.catatan});

  @override
  State<FormCatatanPage> createState() => _FormCatatanPageState();
}

class _FormCatatanPageState extends State<FormCatatanPage> {
  // Key untuk validasi form.
  final _formKey = GlobalKey<FormState>();

  // Controller untuk input judul dan isi catatan.
  late final TextEditingController _judul;
  late final TextEditingController _isi;

  @override
  void initState() {
    super.initState();

    // Mengisi form dengan data lama jika sedang mengedit.
    _judul = TextEditingController(
      text: widget.catatan?.judul ?? '',
    );

    _isi = TextEditingController(
      text: widget.catatan?.isi ?? '',
    );
  }

  @override
  void dispose() {
    // Membersihkan controller agar tidak membebani aplikasi.
    _judul.dispose();
    _isi.dispose();
    super.dispose();
  }

  // Menyimpan catatan baru atau memperbarui catatan lama.
  Future<void> _simpan() async {
    // Menghentikan proses jika validasi gagal.
    if (!_formKey.currentState!.validate()) return;

    final c = Catatan(
      id: widget.catatan?.id,
      judul: _judul.text.trim(),
      isi: _isi.text.trim(),

      // Mempertahankan tanggal asli saat edit.
      // Jika catatan baru, gunakan waktu saat ini.
      dibuat: widget.catatan?.dibuat.isNotEmpty == true
          ? widget.catatan!.dibuat
          : DateTime.now().toIso8601String(),
    );

    // Memilih operasi tambah atau ubah berdasarkan kondisi form.
    if (widget.catatan == null) {
      await DbHelper.tambah(c);
    } else {
      await DbHelper.ubah(c);
    }

    if (!mounted) return;

    // Menutup form dan kembali ke halaman daftar.
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final baru = widget.catatan == null;

    return Scaffold(
      appBar: AppBar(
        title: Text(baru ? 'Catatan Baru' : 'Ubah Catatan'),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Input judul dengan validasi wajib diisi.
            TextFormField(
              controller: _judul,
              decoration: const InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Judul wajib diisi';
                }
                return null;
              },
            ),

            const SizedBox(height: 12),

            // Input isi catatan dengan validasi wajib diisi.
            TextFormField(
              controller: _isi,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Isi catatan',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Isi wajib diisi';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Tombol untuk menyimpan data ke SQLite.
            ElevatedButton(
              onPressed: _simpan,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
