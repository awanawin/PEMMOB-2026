# PRODUCT REQUIREMENTS DOCUMENT (PRD)
## NUVORA — Aplikasi E-Learning dan Manajemen Akademik Berbasis Android

| Metadata | Keterangan |
|---|---|
| Nama Produk | Nuvora |
| Versi Dokumen | 1.0 |
| Status | Draft untuk Review |
| Dasar Dokumen | BRD Nuvora v1.0 |
| Platform | Android (Flutter) + Web Admin (HTML/CSS/JS) |
| Backend | FastAPI (Python) + MySQL |
| Metode Pengembangan | Incremental Development (8 tahap) |
| Tim | Satu pengembang (solo developer) |

---

## 1. RINGKASAN PRODUK

### 1.1 Deskripsi
Nuvora adalah platform e-learning dan manajemen akademik yang menyatukan aktivitas pembelajaran (materi, tugas, kuis, nilai, pengumuman) dalam satu sistem. Guru dan siswa menggunakan aplikasi Android; admin menggunakan halaman web. Notifikasi tambahan dikirim melalui WhatsApp Business Cloud API.

### 1.2 Problem Statement
| Masalah | Dampak |
|---|---|
| Materi, pengumuman, dan penilaian tersebar di banyak media (dokumen, grup chat, mekanisme berbeda) | Informasi tercecer, siswa terlambat tahu tugas |
| Guru mengelola aktivitas belajar tanpa struktur | Beban administrasi tinggi |
| Penilaian kuis pilihan ganda dilakukan manual | Memakan waktu, rawan salah |
| Hak akses data tidak jelas | Risiko kebocoran data nilai/pribadi |

### 1.3 Visi Produk
Satu aplikasi sederhana, terjangkau, dan dapat dipelihara mandiri yang memusatkan seluruh aktivitas belajar-mengajar dengan pembagian hak akses yang jelas dan penilaian kuis otomatis yang aman.

### 1.4 Tujuan Produk dan Indikator
| # | Tujuan | Indikator Keberhasilan |
|---|---|---|
| G1 | Memusatkan informasi pembelajaran | Semua materi, tugas, kuis, nilai, dan pengumuman dapat diakses dalam satu aplikasi |
| G2 | Memudahkan guru mengelola materi & tugas | Guru dapat membuat materi/tugas/kuis tanpa media eksternal |
| G3 | Memudahkan siswa mengakses informasi | Siswa melihat tugas, tenggat, status, dan nilai dari satu akun |
| G4 | Menghilangkan penilaian manual kuis PG | Skor dihitung otomatis oleh backend |
| G5 | Pengelolaan nilai terstruktur | Nilai tugas & kuis tersimpan, terpisah jenisnya, dan terkontrol aksesnya |
| G6 | Pengelolaan data akademik terpusat | Admin mengelola akun, kelas, mapel, anggota kelas lewat web |
| G7 | Ketepatan informasi via WhatsApp | Notifikasi tugas/kuis/pengumuman terkirim dan tercatat |
| G8 | Sistem sederhana dan dapat dipelihara | Arsitektur satu backend, tanpa JWT/ORM/Firebase wajib |

### 1.5 Non-Goals (Di Luar Cakupan Versi Awal)
Video conference/kelas virtual, pembayaran biaya pendidikan, absensi GPS, sistem keuangan sekolah, integrasi sistem akademik eksternal, kuis esai dengan AI, aplikasi iOS, chat pribadi antarpengguna, integrasi Firebase, rekomendasi materi berbasis AI.

---

## 2. PERSONA PENGGUNA

### 2.1 Admin — "Bu Rina, staf tata usaha"
- **Platform:** Web browser.
- **Kebutuhan:** membuat akun guru/siswa, mengatur kelas & mapel, menetapkan guru pengampu, mendaftarkan siswa, mengelola pengumuman umum.
- **Pain point:** data akademik tersebar; sulit memastikan siswa terdaftar di kelas yang benar.
- **Keberhasilan:** seluruh data utama dikelola dari satu halaman; hanya admin yang dapat operasi administratif.

### 2.2 Guru — "Pak Budi, guru Matematika"
- **Platform:** Android.
- **Kebutuhan:** unggah materi, buat tugas & kuis, periksa pengumpulan, beri nilai & komentar, buat pengumuman, lihat status pengumpulan dan hasil kuis.
- **Pain point:** materi dibagi lewat grup chat, penilaian kuis manual.
- **Keberhasilan:** satu aplikasi untuk seluruh siklus pengajaran pada kelas yang diampu.

### 2.3 Siswa — "Dina, siswi kelas 10"
- **Platform:** Android.
- **Kebutuhan:** lihat kelas & mapel, akses materi, lihat tugas & tenggat, kumpulkan jawaban, kerjakan kuis, lihat nilai & pengumuman.
- **Pain point:** terlambat tahu tugas, tidak tahu status pengumpulan.
- **Keberhasilan:** semua informasi akademik pribadi dapat diakses aman dari satu akun.

### 2.4 Pemangku Kepentingan Lain
- **Pengembang sistem:** analisis, desain DB, implementasi, pengujian, dokumentasi, pemeliharaan.
- **Penyedia layanan eksternal:** WhatsApp Cloud API (Meta).
- **Pengelola pendidikan:** memantau data pembelajaran sesuai kewenangan.

---

## 3. MATRIKS PERAN DAN HAK AKSES

| Kapabilitas | Admin | Guru | Siswa |
|---|:-:|:-:|:-:|
| Login | ✅ (web) | ✅ (Android) | ✅ (Android) |
| Kelola akun (buat/ubah/aktif-nonaktif) | ✅ | ❌ | ❌ |
| Kelola kelas & mata pelajaran | ✅ | ❌ | ❌ |
| Tetapkan guru pengampu | ✅ | ❌ | ❌ |
| Daftarkan siswa ke kelas | ✅ | ❌ | ❌ |
| Lihat kelas/mapel | Semua | Yang diampu | Yang diikuti |
| Kelola materi | ❌ | Kelas diampu | ❌ |
| Lihat materi | ❌ | Kelas diampu | Kelas diikuti |
| Buat tugas | ❌ | Kelas diampu | ❌ |
| Kumpulkan tugas | ❌ | ❌ | ✅ (kelas diikuti) |
| Nilai tugas + komentar | ❌ | Kelas diampu | ❌ |
| Buat kuis | ❌ | Kelas diampu | ❌ |
| Kerjakan kuis | ❌ | ❌ | ✅ |
| Lihat hasil kuis | ❌ | Kelas diampu | Milik sendiri |
| Lihat nilai | ❌ | Kelas diampu | Milik sendiri |
| Buat pengumuman kelas | ❌ | Kelas diampu | ❌ |
| Kelola pengumuman umum | ✅ | ❌ | ❌ |
| Lihat pengumuman | ✅ | ✅ | Kelas diikuti + umum |

**Aturan inti:** backend memvalidasi **peran** dan **kepemilikan/keanggotaan data** pada setiap endpoint terlindungi. Guru tidak dapat mengubah kelas yang bukan tanggung jawabnya; siswa tidak dapat mengakses nilai/pengumpulan siswa lain.

---

## 4. ARSITEKTUR SISTEM

### 4.1 Gambaran
```
Flutter App (Guru & Siswa) ─┐
                            ├─► FastAPI REST API (JSON) ─► MySQL
Web Admin (HTML/CSS/JS) ────┘          │
                                       └─► WhatsApp Cloud API
```
- Integrasi WhatsApp **hanya dari backend**, tidak dari aplikasi Android.
- Backend: validasi permintaan, cek token & hak akses, logika bisnis, akses database.

### 4.2 Stack Teknologi
| Teknologi | Fungsi |
|---|---|
| Flutter + Dart | Aplikasi Android |
| Android Studio | Emulator & debugging |
| Python + FastAPI (+ Uvicorn) | REST API & logika bisnis |
| MySQL + mysql-connector-python | Database, query SQL langsung (tanpa SQLAlchemy) |
| HTML/CSS/JavaScript | Halaman admin web |
| Postman, Swagger UI | Pengujian & dokumentasi API |
| Git + GitHub | Version control |
| WhatsApp Cloud API | Notifikasi |

### 4.3 Keputusan Teknis (Constraints)
- Autentikasi memakai **token acak** (modul bawaan Python, mis. `secrets`), bukan JWT wajib.
- Password di-hash dengan algoritma khusus password (mis. bcrypt/argon2).
- Hash token disimpan di DB (`auth_tokens`), bukan token mentah.
- Query wajib berparameter (anti SQL injection).
- Pydantic dipakai secara internal oleh FastAPI; model kompleks tidak diwajibkan.
- Kredensial DB/WhatsApp tidak boleh ada di aplikasi Flutter atau repo publik.
- HTTPS wajib di produksi.

### 4.4 Modul Backend (Logis)
Autentikasi · Pengguna · Akademik · Materi · Tugas · Kuis · Nilai · Pengumuman · Notifikasi.
Satu aplikasi FastAPI dengan pemisahan modul, bukan layanan terpisah.

---

## 5. PERSYARATAN FUNGSIONAL

Prioritas: **P0 = Tinggi (wajib versi awal)**, **P1 = Sedang**.

### 5.1 Modul Autentikasi & Akun

| ID | Kebutuhan | Prio |
|---|---|:-:|
| FR01 | Halaman login untuk admin (web), guru & siswa (Android) | P0 |
| FR02 | Validasi kredensial lewat backend | P0 |
| FR03 | Token autentikasi dibuat setelah login berhasil | P0 |
| FR04 | Validasi token pada endpoint terlindungi | P0 |
| FR05 | Logout dan pencabutan token | P0 |
| FR06 | Admin dapat mengaktifkan/menonaktifkan akun | P0 |
| FR07 | Akun nonaktif ditolak login/akses | P0 |
| FR08 | Pembatasan fitur berdasarkan peran | P0 |

**User Stories & Acceptance Criteria**

**US-AUTH-01** — Sebagai pengguna, saya ingin login dengan kredensial saya agar dapat mengakses fitur sesuai peran.
- Kredensial benar & akun aktif → respons berisi token dan peran.
- Kredensial salah → ditolak dengan pesan umum (tidak membocorkan field mana yang salah).
- Akun nonaktif → ditolak dengan pesan jelas.
- Token yang tidak valid/kedaluwarsa/dicabut → ditolak (HTTP 401).

**US-AUTH-02** — Sebagai pengguna, saya ingin logout agar sesi saya tidak dapat disalahgunakan.
- Setelah logout, token lama tidak dapat dipakai lagi.

**US-AUTH-03** — Sebagai admin, saya ingin menonaktifkan akun agar pengguna yang tidak berhak tidak dapat masuk.
- Akun yang dinonaktifkan kehilangan akses meskipun memiliki token sebelumnya.

### 5.2 Modul Kelas & Mata Pelajaran

| ID | Kebutuhan | Prio |
|---|---|:-:|
| FR09 | Admin CRUD kelas sesuai aturan relasi data | P0 |
| FR10 | Admin kelola mata pelajaran | P0 |
| FR11 | Admin tetapkan guru pengampu pada kelas/mapel | P0 |
| FR12 | Admin daftarkan siswa ke kelas | P0 |
| FR13 | Guru melihat kelas/mapel tanggung jawabnya | P0 |
| FR14 | Siswa melihat kelas/mapel tempat terdaftar | P0 |

**US-CLS-01** — Sebagai admin, saya ingin membuat kelas dan mapel lalu menetapkan guru dan siswa agar aktivitas belajar terhubung ke pengguna yang benar.
- Penghapusan kelas yang masih memiliki relasi (anggota, tugas, dll.) ditangani sesuai aturan relasi (ditolak atau dengan konfirmasi/cascade yang terdefinisi).
- Guru hanya melihat kelas dari `teaching_assignments` miliknya; siswa hanya dari `class_members` miliknya.

### 5.3 Modul Materi

| ID | Kebutuhan | Prio |
|---|---|:-:|
| FR15 | Guru membuat materi | P0 |
| FR16 | Isi judul, deskripsi, kelas, mapel, info materi | P0 |
| FR17 | Unggah file yang didukung atau tambah tautan | P0 |
| FR18 | Guru ubah/hapus materi miliknya | P1 |
| FR19 | Siswa melihat daftar materi kelas yang diikuti | P0 |
| FR20 | Akses file materi dibatasi berdasarkan hak akses | P0 |

**US-MAT-01** — Sebagai guru, saya ingin mengunggah materi (file/tautan) ke kelas yang saya ampu.
- Tipe & ukuran file divalidasi; file di luar ketentuan ditolak.
- Guru tidak dapat menambah materi ke kelas yang bukan miliknya.

**US-MAT-02** — Sebagai siswa, saya ingin membuka materi kelas saya.
- Siswa di luar kelas yang bersangkutan ditolak saat mengakses materi **maupun URL file**-nya.

### 5.4 Modul Tugas

| ID | Kebutuhan | Prio |
|---|---|:-:|
| FR21 | Guru membuat tugas untuk kelas yang diajar | P0 |
| FR22 | Tentukan judul, deskripsi, tenggat, lampiran | P0 |
| FR23 | Siswa melihat tugas kelas yang diikuti | P0 |
| FR24 | Siswa kirim jawaban/lampiran | P0 |
| FR25 | Sistem catat identitas pengumpul & waktu | P0 |
| FR26 | Tampilkan status pengumpulan | P0 |
| FR27 | Guru lihat hasil pengumpulan kelasnya | P0 |
| FR28 | Guru beri nilai & komentar | P0 |
| FR29 | Siswa melihat nilai tugasnya | P0 |
| FR30 | Aturan pengumpulan ulang sesuai kebijakan tugas | P1 |

**US-TGS-01** — Sebagai guru, saya ingin membuat tugas dengan tenggat dan lampiran.
**US-TGS-02** — Sebagai siswa, saya ingin mengirim jawaban dan melihat status pengumpulan.
- Backend memvalidasi: siswa terdaftar di kelas tersebut, dan tugas masih dapat dikumpulkan sesuai aturan.
- Waktu pengumpulan dicatat otomatis oleh server (bukan dari klien).
**US-TGS-03** — Sebagai guru, saya ingin menilai pengumpulan dan memberi komentar.
- Siswa melihat nilai **setelah dipublikasikan/ditandai siap dilihat**.

**Status Pengumpulan Tugas (usulan):** `Belum Dikumpulkan` → `Dikumpulkan` (tepat waktu / terlambat, sesuai kebijakan) → `Dinilai`.

### 5.5 Modul Kuis

| ID | Kebutuhan | Prio |
|---|---|:-:|
| FR31 | Guru membuat kuis pilihan ganda | P0 |
| FR32 | Tambah soal, pilihan, kunci jawaban, bobot | P0 |
| FR33 | Tentukan kelas & periode pelaksanaan | P0 |
| FR34 | Siswa melihat kuis tersedia untuk kelasnya | P0 |
| FR35 | Siswa kirim jawaban kuis | P0 |
| FR36 | Backend memeriksa jawaban & hitung skor otomatis | P0 |
| FR37 | Simpan jawaban & hasil kuis | P0 |
| FR38 | Kunci jawaban tidak dikirim ke siswa sebelum penilaian | P0 |
| FR39 | Cegah pengiriman ulang yang melanggar aturan | P0 |
| FR40 | Guru melihat hasil kuis siswa kelasnya | P0 |

**US-KUIS-01** — Sebagai guru, saya ingin membuat kuis PG dengan kunci dan bobot.
**US-KUIS-02** — Sebagai siswa, saya ingin mengerjakan kuis dan mendapat skor otomatis.
- Endpoint soal untuk siswa **tidak** mengembalikan field kunci jawaban.
- Kuis hanya dapat dikerjakan dalam periode pelaksanaan dan oleh siswa kelas terkait.
- Pengiriman berulang ditolak/ditangani sesuai aturan kuis (jumlah percobaan).
- Skor = jumlah bobot jawaban benar, dihitung di backend; hasil tersimpan di `quiz_attempts`/`quiz_answers`.
- Tampilan nilai ke siswa sesuai pengaturan kuis.

### 5.6 Modul Nilai

| ID | Kebutuhan | Prio |
|---|---|:-:|
| FR41 | Siswa lihat nilai tugas miliknya | P0 |
| FR42 | Siswa lihat hasil kuis miliknya | P0 |
| FR43 | Guru lihat nilai siswa kelas tanggung jawabnya | P0 |
| FR44 | Bedakan nilai tugas manual vs kuis otomatis | P1 |
| FR45 | Tolak akses nilai di luar hak pengguna | P0 |

### 5.7 Modul Pengumuman

| ID | Kebutuhan | Prio |
|---|---|:-:|
| FR46 | Guru buat pengumuman kelas yang diajar | P0 |
| FR47 | Admin kelola pengumuman umum | P1 |
| FR48 | Siswa lihat pengumuman kelasnya | P0 |
| FR49 | Simpan pembuat & waktu pembuatan | P1 |

### 5.8 Modul Administrasi Web

| ID | Kebutuhan | Prio |
|---|---|:-:|
| FR50 | Halaman administrasi berbasis web | P0 |
| FR51 | Autentikasi & hak akses admin | P0 |
| FR52 | Kelola akun, kelas, mapel, anggota kelas | P0 |
| FR53 | Tampilkan informasi data yang diperlukan untuk administrasi | P1 |
| FR54 | Backend memvalidasi semua operasi administratif | P0 |

### 5.9 Modul Notifikasi WhatsApp

| ID | Kebutuhan | Prio |
|---|---|:-:|
| FR55 | Notifikasi tugas baru via WhatsApp Cloud API | P1 |
| FR56 | Pengingat tenggat tugas terjadwal | P1 |
| FR57 | Notifikasi kuis / pengumuman penting | P1 |
| FR58 | Catat log pengiriman | P1 |
| FR59 | Kirim hanya ke penerima yang memenuhi ketentuan & telah memberi persetujuan | P0 |
| FR60 | Kegagalan pengiriman tidak mengganggu proses utama | P0 |

**US-WA-01** — Sebagai siswa, saya ingin menerima notifikasi tugas/kuis/pengumuman via WhatsApp agar tidak terlewat.
- Notifikasi hanya dikirim jika nomor valid **dan** persetujuan (opt-in) tercatat.
- Penyimpanan tugas/kuis/pengumuman **tidak bergantung** pada keberhasilan WhatsApp (pengiriman bersifat asinkron/terpisah dari transaksi utama).
- Hasil permintaan dan (jika tersedia) status webhook dicatat di `whatsapp_notification_logs`; kegagalan dicatat dan dapat di-retry terkendali.

**Catatan:** FR59 dan FR60 berprioritas tinggi meskipun modul secara keseluruhan sedang — keduanya adalah syarat kepatuhan dan stabilitas.

---

## 6. ALUR PENGGUNA (USER FLOW)

### 6.1 Pengelolaan Akun & Kelas (Admin)
```
Admin login web → Buat akun guru/siswa (isi data, peran) → Aktifkan akun
→ Buat kelas & mapel → Tetapkan guru pengampu → Daftarkan siswa ke kelas
→ Guru/Siswa login → Backend cek kredensial + status → Token → Lihat kelas sesuai peran
```

### 6.2 Tugas
```
Guru pilih kelas → Buat tugas (instruksi, tenggat, lampiran) → Backend simpan
→ (opsional) Notifikasi WhatsApp
→ Siswa lihat tugas → Kirim jawaban → Backend validasi keanggotaan & aturan tenggat → Simpan + waktu
→ Guru periksa → Beri nilai & komentar → Siswa lihat nilai (setelah dipublikasikan)
```

### 6.3 Kuis
```
Guru buat kuis (soal, opsi, kunci, bobot, periode) → Backend simpan kunci (server-side saja)
→ Siswa buka kuis (soal & opsi TANPA kunci) → Kirim jawaban
→ Backend validasi kelayakan → Cek jawaban + hitung skor → Simpan hasil
→ Siswa lihat nilai (sesuai pengaturan) → Guru lihat hasil kelas
```

### 6.4 Notifikasi WhatsApp
```
Guru buat tugas/kuis/pengumuman → Backend simpan data → Tentukan penerima (kelas + jenis notifikasi)
→ Cek nomor & persetujuan → Kirim ke WhatsApp Cloud API → Catat hasil / status webhook
→ Gagal? Catat error + retry terkendali (proses utama tidak terganggu)
```

---

## 7. MODEL DATA (RANCANGAN AWAL)

| Tabel | Fungsi | Catatan Desain |
|---|---|---|
| `users` | Akun, password hash, peran, status aktif, kontak | Tambah kolom nomor telepon & flag persetujuan WA (opt-in) |
| `classes` | Data kelas | |
| `subjects` | Mata pelajaran | |
| `class_members` | Siswa ↔ kelas | Unique (class_id, student_id) |
| `teaching_assignments` | Guru ↔ kelas/mapel | Dasar validasi hak akses guru |
| `materials` | Metadata materi, file/tautan | |
| `assignments` | Tugas & tenggat, kebijakan pengumpulan ulang | |
| `submissions` | Pengumpulan siswa | Waktu dari server |
| `quizzes` | Info kuis, periode, aturan percobaan | |
| `quiz_questions` | Soal & bobot | |
| `quiz_options` | Opsi + penanda kunci | **Hanya backend** yang boleh membaca kunci |
| `quiz_attempts` | Pengerjaan & skor | Skor dapat disimpan di sini (hindari duplikasi dengan `grades`) |
| `quiz_answers` | Jawaban per soal | |
| `grades` | Nilai tugas / nilai lain | |
| `announcements` | Pengumuman (kelas / umum) | Simpan pembuat & timestamp |
| `auth_tokens` | Hash token, user, kedaluwarsa, status cabut | |
| `whatsapp_notification_logs` | Log pengiriman WA | Simpan status request & webhook, error, jumlah retry |

**Relasi inti**
```
users ─< class_members >─ classes
users ─< teaching_assignments >─ classes/subjects
classes ─< materials | assignments | quizzes | announcements
assignments ─< submissions >─ users(student)
quizzes ─< quiz_questions ─< quiz_options
quizzes ─< quiz_attempts ─< quiz_answers
users ─< auth_tokens
```
Relasi harus menjamin setiap submission dan hasil kuis terkait pengguna serta aktivitas yang benar. Operasi yang saling bergantung (mis. simpan attempt + answers + skor) menggunakan **transaksi**.

---

## 8. PERSYARATAN NON-FUNGSIONAL

### 8.1 Keamanan
| # | Persyaratan |
|---|---|
| S1 | Password di-hash dengan algoritma khusus password |
| S2 | Token dibuat dari sumber acak aman |
| S3 | Hash token disimpan di DB, bukan token mentah |
| S4 | Token punya masa berlaku & dapat dicabut |
| S5 | Validasi autentikasi + hak akses di setiap endpoint terlindungi |
| S6 | Query berparameter (anti SQL injection) |
| S7 | Kunci jawaban tidak pernah dikirim ke siswa sebelum penilaian |
| S8 | Validasi tipe & ukuran file unggahan |
| S9 | Kredensial DB & WhatsApp tidak di aplikasi Flutter / repo publik |
| S10 | HTTPS wajib di produksi |

### 8.2 Kinerja
- Respons wajar pada penggunaan normal; **target angka ditetapkan setelah kapasitas server & skenario uji ditentukan** (sesuai BRD).
- Pagination untuk daftar berpotensi besar.
- Query efisien sesuai kebutuhan.
- WhatsApp tidak boleh menyebabkan request utama gagal.

### 8.3 Usability
- Antarmuka sederhana; navigasi membedakan fitur guru vs siswa.
- Pesan error form jelas.
- Tugas menampilkan tenggat dan status pengumpulan.
- Nilai & hasil kuis ditampilkan terstruktur.
- Web admin berjalan di browser modern.

### 8.4 Kompatibilitas
- Android: diuji pada emulator/perangkat sesuai versi Android target (**perlu ditetapkan**, lihat Open Questions).
- Backend: lingkungan Python sesuai dependensi.
- MySQL: versi kompatibel dengan driver.
- API: JSON konsisten.

### 8.5 Keandalan & Pemeliharaan
- Penanganan error validasi & koneksi terkontrol.
- Transaksi DB untuk operasi bergantung.
- Pencatatan error (logging).
- Kode modular; perubahan skema didokumentasikan.
- Backup DB untuk lingkungan nyata; uji pemulihan.

### 8.6 Privasi Data
- Data pribadi hanya untuk pengguna berhak.
- Nomor telepon hanya untuk tujuan yang diinformasikan.
- Pengiriman WhatsApp mengikuti persetujuan & kebijakan layanan.
- Minimisasi data: hanya data yang dibutuhkan operasional pembelajaran.
- Data siswa tidak tampil terbuka ke pihak tidak berwenang.

---

## 9. SPESIFIKASI API (USULAN GARIS BESAR)

Detail endpoint difinalkan pada tahap perancangan teknis; berikut kerangka awal. Semua endpoint selain login memerlukan token.

| Grup | Contoh Endpoint | Peran |
|---|---|---|
| Auth | `POST /auth/login`, `POST /auth/logout`, `GET /auth/me` | Semua |
| Users | `POST/GET/PUT /admin/users`, `PATCH /admin/users/{id}/status` | Admin |
| Akademik | `/admin/classes`, `/admin/subjects`, `/admin/teaching-assignments`, `/admin/classes/{id}/members` | Admin |
| Kelas saya | `GET /me/classes` | Guru, Siswa |
| Materi | `POST /classes/{id}/materials`, `GET /classes/{id}/materials`, `PUT/DELETE /materials/{id}` | Guru (tulis), Guru+Siswa (baca) |
| Tugas | `POST /classes/{id}/assignments`, `GET /classes/{id}/assignments`, `POST /assignments/{id}/submissions`, `GET /assignments/{id}/submissions`, `PUT /submissions/{id}/grade` | Sesuai matriks |
| Kuis | `POST /classes/{id}/quizzes`, `GET /quizzes/{id}` (tanpa kunci untuk siswa), `POST /quizzes/{id}/attempts`, `GET /quizzes/{id}/results` | Sesuai matriks |
| Nilai | `GET /me/grades`, `GET /classes/{id}/grades` | Siswa / Guru |
| Pengumuman | `POST/GET /classes/{id}/announcements`, `/admin/announcements` | Sesuai matriks |
| Notifikasi | `POST /webhooks/whatsapp` (status webhook) | Sistem |

Konvensi: JSON, kode status HTTP konsisten (401 tidak terautentikasi, 403 tidak berhak, 404 tidak ditemukan, 422 validasi), pagination (`page`, `limit`) untuk list besar, dokumentasi otomatis via Swagger UI.

---

## 10. KEBUTUHAN ANTARMUKA (UI/UX)

### 10.1 Aplikasi Android — Guru
Login · Beranda (daftar kelas/mapel) · Detail kelas (tab: Materi, Tugas, Kuis, Pengumuman, Nilai) · Form materi · Form tugas · Daftar pengumpulan + form nilai · Pembuat kuis (soal, opsi, kunci, bobot, periode) · Hasil kuis · Form pengumuman.

### 10.2 Aplikasi Android — Siswa
Login · Beranda (kelas diikuti) · Detail kelas (Materi, Tugas, Kuis, Pengumuman) · Detail tugas + kirim jawaban + status · Pengerjaan kuis · Halaman nilai (tugas vs kuis) · Pengumuman.

### 10.3 Web Admin
Login admin · Manajemen akun (CRUD, aktif/nonaktif) · Manajemen kelas · Manajemen mapel · Penugasan guru · Keanggotaan kelas · Pengumuman umum.

### 10.4 Prinsip UI
- Sederhana, konsisten; navigasi dibedakan per peran.
- Tampilkan state loading, kosong, dan error (termasuk koneksi putus) dengan pesan jelas dan opsi kirim ulang yang aman.
- Token disimpan lewat mekanisme penyimpanan aman Flutter.

---

## 11. METRIK KEBERHASILAN

BRD tidak menetapkan angka kuantitatif; berikut usulan awal untuk disepakati.

| Metrik | Usulan Target |
|---|---|
| Penyelesaian alur inti (login → tugas → nilai) tanpa error kritis | 100% skenario uji lulus |
| Akurasi skor kuis otomatis vs perhitungan manual sampel | 100% |
| Insiden kebocoran kunci jawaban / data lintas kelas | 0 pada pengujian hak akses |
| Kegagalan WA yang menyebabkan kehilangan data tugas/nilai | 0 |
| Cakupan endpoint utama teruji (Swagger/Postman) | 100% endpoint P0 |
| Tingkat keberhasilan notifikasi WA di lingkungan uji | Dicatat & dilaporkan (target ditetapkan setelah uji) |

---

## 12. RISIKO DAN MITIGASI

| Risiko | Dampak | Mitigasi |
|---|---|---|
| Internet tidak stabil | Gagal akses/kirim tugas | Pesan error jelas, retry aman |
| Kesalahan hak akses | Data tak berwenang terbaca | Validasi peran + kepemilikan di setiap endpoint; uji hak akses |
| Token dicuri | Akses akun ilegal | HTTPS, token acak, hash di DB, kedaluwarsa, pencabutan |
| Kunci jawaban terekspos | Kuis disalahgunakan | Kunci hanya di backend; uji respons endpoint siswa |
| SQL injection | Data bocor/berubah | Query berparameter |
| File berbahaya/besar | Keamanan & storage | Batasi ukuran, validasi tipe, atur akses |
| WhatsApp API gagal | Notifikasi tak terkirim | Log, retry terkendali, proses utama independen |
| Biaya WhatsApp tak sesuai | Beban operasional | Cek tarif & ketentuan sebelum aktivasi produksi |
| Waktu terbatas (solo dev) | Fitur tak selesai | Dahulukan P0; tunda WA hingga inti stabil |
| Kerusakan/kehilangan DB | Data hilang | Backup + uji pemulihan |
| Perubahan skema DB | Regresi | Dokumentasi + pengujian regresi |

---

## 13. ASUMSI DAN KETERGANTUNGAN

**Asumsi:** pengguna punya perangkat Android & internet; admin menjaga kebenaran data akun/kelas/mapel; guru berwenang atas kelas yang ditugaskan; siswa terdaftar ke kelas oleh admin; server dapat menjalankan FastAPI + MySQL; satu pengembang.

**Ketergantungan eksternal:** akun Meta Business, kredensial & nomor pengirim WhatsApp, template pesan yang disetujui, kebijakan & tarif WhatsApp, hosting/server dengan HTTPS.

---

## 14. ROADMAP (MAPPING TAHAPAN BRD)

| Tahap | Cakupan | Target Keluaran | Modul/FR |
|---|---|---|---|
| 1 | Persiapan lingkungan | Backend jalan & terhubung MySQL | — |
| 2 | Database & autentikasi | Login aman, akses per peran | FR01–FR08 |
| 3 | Administrasi akademik | Admin kelola data utama + web admin dasar | FR09–FR12, FR50–FR54 |
| 4 | Integrasi Flutter | Login & navigasi per peran, tampilan kelas | FR13–FR14 |
| 5 | Materi & tugas | Alur tugas end-to-end hingga penilaian | FR15–FR30 |
| 6 | Kuis & nilai | Kuis otomatis + halaman nilai | FR31–FR45 |
| 7 | Pengumuman & WhatsApp | Notifikasi terkirim & tercatat | FR46–FR49, FR55–FR60 |
| 8 | Pengujian & dokumentasi | Siap demo | Seluruh |

**Rekomendasi pemotongan lingkup jika waktu mepet:** rilis tanpa Tahap 7 bagian WhatsApp (FR55–FR58) terlebih dahulu; pengumuman tetap tersedia in-app.

---

## 15. RENCANA PENGUJIAN

| Area | Skenario Kunci |
|---|---|
| Autentikasi | Login benar/salah; akun nonaktif; token kedaluwarsa/dicabut/invalid |
| Hak akses | Guru mengubah kelas lain (harus ditolak); siswa akses nilai/submission siswa lain (ditolak); siswa akses file materi kelas lain (ditolak) |
| Tugas | Kirim sebelum/sesudah tenggat; kirim ulang sesuai kebijakan; pencatatan waktu server; nilai tampil setelah dipublikasikan |
| Kuis | Respons siswa tidak memuat kunci; skor benar; kirim berulang; di luar periode |
| File | Tipe/ukuran tidak valid ditolak |
| WhatsApp | Penerima tanpa opt-in tidak dikirimi; kegagalan API tidak merusak data; log tercatat |
| Keamanan | Uji injeksi pada input; secret tidak ada di repo/app |
| Integrasi | Flutter ↔ FastAPI; Swagger/Postman untuk semua endpoint P0 |

---

## 16. KRITERIA PENERIMAAN (LEVEL SISTEM)

**Autentikasi & hak akses**
- [ ] Admin login ke web; guru & siswa login via Android
- [ ] Kredensial salah ditolak; akun nonaktif tak dapat mengakses fitur terlindungi
- [ ] Token invalid/kedaluwarsa/dicabut ditolak
- [ ] Guru tak dapat mengubah kelas yang bukan tanggung jawabnya
- [ ] Siswa tak dapat mengakses nilai/pengumpulan siswa lain

**Kelas & materi**
- [ ] Admin buat kelas/mapel, tetapkan guru dan anggota
- [ ] Guru buat materi di kelasnya; siswa akses sesuai keanggotaan
- [ ] Pengguna tak berhak ditolak pada materi/file

**Tugas**
- [ ] Guru buat tugas + tenggat; siswa lihat & kirim jawaban/lampiran
- [ ] Waktu & identitas pengumpulan tercatat
- [ ] Guru beri nilai & komentar; siswa lihat nilainya setelah tersedia

**Kuis**
- [ ] Guru buat kuis PG; siswa kirim jawaban
- [ ] Skor otomatis & hasil tersimpan benar
- [ ] Kunci tidak dikirim ke siswa sebelum penilaian
- [ ] Pengiriman berulang ditangani sesuai aturan

**Administrasi & notifikasi**
- [ ] Admin kelola akun, kelas, mapel
- [ ] Pengumuman tampil ke penerima yang sesuai
- [ ] Notifikasi WhatsApp teruji di lingkungan terkonfigurasi
- [ ] Kegagalan WhatsApp tidak menghilangkan data tugas/nilai
- [ ] Status notifikasi tercatat sesuai kemampuan layanan

**Pengujian menyeluruh**
- [ ] Endpoint utama teruji via Swagger/Postman
- [ ] Flutter berhasil berkomunikasi dengan FastAPI
- [ ] Operasi DB (simpan/ambil/ubah) berhasil
- [ ] Pengujian hak akses & validasi input dilakukan
- [ ] Tidak ada error kritis pada alur utama

---

## 17. OPEN QUESTIONS (PERLU KEPUTUSAN SEBELUM DESAIN TEKNIS)

1. **Versi Android minimum** yang ditarget?
2. **Kebijakan pengumpulan ulang tugas:** apakah diizinkan, berapa kali, dan bagaimana menangani keterlambatan (ditolak atau ditandai terlambat)?
3. **Aturan kuis:** jumlah percobaan maksimal, durasi pengerjaan per percobaan, apakah soal/opsi diacak, kapan nilai dan pembahasan ditampilkan?
4. **Daftar tipe file & batas ukuran** untuk materi dan lampiran tugas; di mana file disimpan (disk server, object storage)?
5. **Masa berlaku token** dan apakah ada refresh/perpanjangan sesi?
6. **Pencatatan persetujuan (opt-in) WhatsApp:** dikumpulkan di mana (saat registrasi oleh admin, di aplikasi?), dan siapa yang berhak menerima notifikasi (siswa, orang tua, guru)?
7. **Template pesan WhatsApp** dan kategori pesan yang akan didaftarkan ke Meta (memengaruhi biaya & persetujuan).
8. **Penjadwalan pengingat tenggat (FR56):** mekanisme scheduler (cron/background worker) dan jadwal pengingat.
9. **Penerbitan nilai tugas:** apakah ada tombol "publikasikan" eksplisit atau otomatis saat dinilai?
10. **Peran Pengelola Pendidikan** (disebut di manfaat): apakah butuh akun/dashboard sendiri, atau cukup melalui admin?
11. **Hosting & lingkungan produksi:** penyedia server, domain, sertifikat HTTPS, strategi backup.
12. **Target waktu respons & kapasitas** (jumlah pengguna bersamaan) untuk pengujian kinerja.
