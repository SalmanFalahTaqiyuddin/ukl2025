# 📚 Digital Library App (UKL XI RPL SMK Telkom Malang)

[![Flutter](https://img.shields.io/badge/Framework-Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Language](https://img.shields.io/badge/Language-Dart-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Status](https://img.shields.io/badge/Project%20Focus-Frontend%20Slicing-informational)](https://github.com/yourusername/yourrepo)

[cite_start]Aplikasi Perpustakaan Digital ini dikembangkan sebagai bagian dari Uji Kenaikan Level (UKL) Kelas XI Rekayasa Perangkat Lunak (RPL) di **SMK Telkom Malang**[cite: 11, 12, 4]. [cite_start]Fokus utama proyek ini adalah **slicing tampilan (front-end development)**, yaitu mengubah desain _wireframe_ menjadi kode dan tampilan antarmuka pengguna (UI) yang fungsional menggunakan **Flutter**[cite: 19, 20].

## ✨ Fitur dan Halaman Aplikasi

[cite_start]Aplikasi ini harus memiliki navigasi antar halaman dan implementasi tampilan yang sesuai dengan panduan _wireframe_[cite: 21]. [cite_start]Aplikasi tidak menggunakan API _Back-end_, melainkan mengandalkan data _dummy_ yang dibuat dalam bentuk _Array_ di kode Flutter[cite: 44, 4, 23].

| Halaman | Deskripsi Fungsionalitas Kunci | Sumber Data |
| :--- | :--- | :--- |
| **Splash Screen** | [cite_start]Muncul selama **3 detik**, menampilkan Gambar/Logo[cite: 61, 62]. | Assets (`.png`) |
| **Login** | [cite_start]Kolom Email dan Password (password disembunyikan `***`)[cite: 65, 68, 69]. | Input Fungsional |
| **Beranda (Home)** | [cite_start]Menampilkan **Search**, **Carousel Slider**, serta kategori buku **Terakhir Diakses**, **Rekomendasi**, dan **Populer** (semua kategori buku dapat di-scroll horizontal)[cite: 84, 85]. | Data Dummy (Array) |
| **Linimasa (Timeline)** | Menampilkan daftar buku dari _Array List_. [cite_start]Dilengkapi fungsionalitas **Tambah**, **Ubah**, dan **Hapus** data buku (melalui _modal_)[cite: 122, 123]. | Data Dummy (Array) |
| **Detail Konten** | Muncul saat buku di Linimasa diklik. [cite_start]Menampilkan Judul, Publisher, Rating, Sinopsis, Status, dan tombol "Berikan Ulasan"[cite: 125, 130]. | Data Dummy (Array) |
| **Profil** | [cite_start]Menampilkan Foto Profil, Nama, tombol Edit Profile, dan _scrollable_ **Riwayat Pinjam**[cite: 166, 167, 168, 169]. | Assets (Foto), Data Dummy (Riwayat Pinjam) |

## 💻 Struktur Data (_Book Model_)

[cite_start]Semua data buku (teks, gambar, daftar buku) harus menggunakan data _dummy_[cite: 23]. Contoh struktur data yang digunakan:

```dart
// Lokasi: lib/models/book_model.dart (contoh)
class BookModel {
  final int id;
  final String title;
  final String overview;
  final String publisher;
  final String status;
  final double voteAverage;
  final String posterPath; // Path gambar di assets/

  BookModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.publisher,
    required this.status,
    required this.voteAverage,
    required this.posterPath,
  });
}

// Contoh data dummy di lib/data/book_data.dart (contoh)
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
