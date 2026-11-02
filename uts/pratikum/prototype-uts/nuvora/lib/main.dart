import 'package:flutter/material.dart';
import 'screens/detail_kelas_siswa.dart';
import 'screens/halaman_awal_nuvora.dart';
import 'screens/beranda_guru.dart';
import 'screens/kelola_materi_guru.dart';
import 'screens/tugas_siswa.dart';
import 'screens/login_siswa_1.dart';
import 'screens/beranda_siswa.dart';
import 'screens/daftar_kelas_guru.dart';
import 'screens/login_siswa_2.dart';
import 'screens/daftar_pengumpulan_tugas.dart';
import 'screens/kuis_siswa.dart';
import 'screens/daftar_kelas_siswa.dart';
import 'screens/buat_kuis_guru.dart';
import 'screens/nilai_siswa.dart';
import 'screens/buat_tugas_guru.dart';
import 'screens/pengumuman_siswa.dart';
import 'screens/detail_tugas_siswa.dart';
import 'screens/kumpulkan_tugas_siswa.dart';
import 'screens/profil_guru.dart';
import 'screens/edit_profil_siswa.dart';
import 'screens/profil_siswa.dart';
import 'screens/kerjakan_kuis_siswa.dart';
import 'screens/nilai_kelas_guru.dart';
import 'screens/pengaturan_siswa.dart';
import 'screens/edit_profil_guru.dart';
import 'screens/pengaturan_guru.dart';
import 'screens/tentang_aplikasi_siswa.dart';

void main() => runApp(const NuvoraApp());

class NuvoraApp extends StatelessWidget {
  const NuvoraApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Nuvora Learning',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0031C4)),
    ),
    home: const NuvoraScreenGallery(),
  );
}

class _ScreenEntry {
  final String title;
  final Widget page;
  const _ScreenEntry(this.title, this.page);
}

class NuvoraScreenGallery extends StatelessWidget {
  const NuvoraScreenGallery({super.key});

  static const screens = <_ScreenEntry>[
    _ScreenEntry('Detail Kelas Siswa', const DetailKelasSiswaScreen()),
    _ScreenEntry('Halaman Awal Nuvora', const HalamanAwalNuvoraScreen()),
    _ScreenEntry('Beranda Guru', const BerandaGuruScreen()),
    _ScreenEntry('Kelola Materi Guru', const KelolaMateriGuruScreen()),
    _ScreenEntry('Tugas Siswa', const TugasSiswaScreen()),
    _ScreenEntry('Login Siswa 1', const LoginSiswa1Screen()),
    _ScreenEntry('Beranda Siswa', const BerandaSiswaScreen()),
    _ScreenEntry('Daftar Kelas Guru', const DaftarKelasGuruScreen()),
    _ScreenEntry('Login Siswa 2', const LoginSiswa2Screen()),
    _ScreenEntry('Daftar Pengumpulan Tugas', const DaftarPengumpulanTugasScreen()),
    _ScreenEntry('Kuis Siswa', const KuisSiswaScreen()),
    _ScreenEntry('Daftar Kelas Siswa', const DaftarKelasSiswaScreen()),
    _ScreenEntry('Buat Kuis Guru', const BuatKuisGuruScreen()),
    _ScreenEntry('Nilai Siswa', const NilaiSiswaScreen()),
    _ScreenEntry('Buat Tugas Guru', const BuatTugasGuruScreen()),
    _ScreenEntry('Pengumuman Siswa', const PengumumanSiswaScreen()),
    _ScreenEntry('Detail Tugas Siswa', const DetailTugasSiswaScreen()),
    _ScreenEntry('Kumpulkan Tugas Siswa', const KumpulkanTugasSiswaScreen()),
    _ScreenEntry('Profil Guru', const ProfilGuruScreen()),
    _ScreenEntry('Edit Profil Siswa', const EditProfilSiswaScreen()),
    _ScreenEntry('Profil Siswa', const ProfilSiswaScreen()),
    _ScreenEntry('Kerjakan Kuis Siswa', const KerjakanKuisSiswaScreen()),
    _ScreenEntry('Nilai Kelas Guru', const NilaiKelasGuruScreen()),
    _ScreenEntry('Pengaturan Siswa', const PengaturanSiswaScreen()),
    _ScreenEntry('Edit Profil Guru', const EditProfilGuruScreen()),
    _ScreenEntry('Pengaturan Guru', const PengaturanGuruScreen()),
    _ScreenEntry('Tentang Aplikasi Siswa', const TentangAplikasiSiswaScreen()),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Nuvora Learning'),
      backgroundColor: const Color(0xFF0031C4),
      foregroundColor: Colors.white,
    ),
    body: ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: screens.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final entry = screens[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(entry.title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => entry.page),
            ),
          ),
        );
      },
    ),
  );
}
