# 📚 Digital Library App (UKL XI RPL SMK Telkom Malang)

[![Flutter](https://img.shields.io/badge/Framework-Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Language](https://img.shields.io/badge/Language-Dart-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Status](https://img.shields.io/badge/Project%20Focus-Frontend%20Slicing-informational)]()

Aplikasi Perpustakaan Digital ini dikembangkan sebagai bagian dari Uji Kenaikan Level (UKL) Kelas XI Rekayasa Perangkat Lunak (RPL) di **SMK Telkom Malang**.

Fokus utama proyek ini adalah **slicing tampilan (front-end development)**. Tujuannya adalah mengubah desain _wireframe_ menjadi antarmuka pengguna (UI) yang fungsional, berwarna, dan memiliki navigasi antar halaman, menggunakan framework **Flutter**.

## ✨ Fitur dan Halaman Aplikasi

Semua data (teks, gambar, daftar buku) dalam aplikasi ini menggunakan data _dummy_ yang dibuat langsung dalam bentuk _Array_ di kode Flutter.

| Halaman | Komponen Kunci (_Wireframe_) | Fungsionalitas Wajib |
| :--- | :--- | :--- |
| **Splash Screen** | Gambar/Logo | Muncul selama **3 detik**. |
| **Login** | Email, Password, Login, Daftar | Password harus disembunyikan (`***`). |
| **Beranda (Home)** | Search, Carousel Slider, Terakhir Diakses, Rekomendasi, Populer | Kategori buku (_Terakhir Diakses_ sampai _Populer_) menggunakan **horizontal scroll**. |
| **Linimasa (Timeline)** | Daftar Buku, Rating Bintang, Edit, Hapus | Dapat **tambah, ubah, dan hapus** data buku (melalui _modal_). Klik konten menampilkan **Detail Konten**. |
| **Detail Konten** | Judul, Publisher, Rating, Sinopsis, Status, Berikan Ulasan | Menampilkan detail lengkap dari buku yang dipilih. |
| **Profil** | Foto Profil, Nama, Edit Profile, Riwayat Pinjam | Riwayat Pinjam harus dapat di-_scroll_ horizontal. |

## 💻 Struktur Data (_Book Model_)

Berikut adalah contoh struktur data buku yang digunakan (sesuai instruksi soal):

```dart
// lib/models/book_model.dart
class BookModel {
  final int id;
  final String title;
  final String overview;
  final String publisher;
  final String status;
  final double voteAverage;
  final String posterPath; 

  // ... Constructor dan metode lainnya ...
}

// Contoh Data Dummy (Array)
final List<BookModel> bookList = [
  BookModel(
    id: 1,
    title: "Kebijakan Pendidikan",
    overview: "Konsep, model, dan isu strategis di Indonesia",
    publisher: "Dr. Rahmat Fadhli, Ed.M.",
    status: "Available",
    voteAverage: 4.0,
    posterPath: "assets/img1.jpeg",
  ),
  // ... data buku lainnya ...
];
