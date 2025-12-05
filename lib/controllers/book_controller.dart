import '../models/book_model.dart';

class BookController {
  final List<BookModel> books = [
    BookModel(
      id: 1,
      title: 'Pulang 2023',
      overview:
          'Novel Pulang adalah kisah dua generasi—Dimas Suryo dan putrinya, Lintang Utara—yang bersama-sama menetap di Paris, Prancis. Seperti ribuan warga Indonesia lain yang terjebak di berbagai negara dengan status stateless, keluarga Dimas Suryo tak pernah bisa pulang ke Indonesia karena paspor mereka dicabut dan kehidupan mereka terancam. Pada tahun 1998, Lintang Utara akhirnya berhasil menyentuh tanah air. Dia datang untuk mereka pengalaman keluarga korban Tragedi 1965 sebagai tugas akhir kuliahnya. Apa yang terkuak oleh Lintang bukan sekadar masa lalu ayahnya, tetapi juga bagaimana sejarah paling berdarah di Indonesia berkaitan dengan Dimas Suryo dan kawan-kawannya.',
      publisher: 'Kepustakaan Populer Gramedia',
      status: 'Tersedia',
      voteAverage: 0.0,
      posterPath:
          'https://image.gramedia.net/rs:fit:0:0/plain/https://cdn.gramedia.com/uploads/picture_meta/2023/12/20/xoid3bznddxudnurccgqxi.jpg',
    ),
    BookModel(
      id: 2,
      title: 'Cantik Itu Luka',
      overview:
          'Hidup di era kolonialisme bagi para wanita dianggap sudah setara seperti hidup di neraka. Terutama bagi para wanita berparas cantik yang menjadi incaran tentara penjajah untuk melampiaskan hasrat mereka. Itu lah takdir miris yang dilalui Dewi Ayu, demi menyelamatkan hidupnya sendiri Dewi harus menerima paksaan menjadi pelacur bagi tentara Belanda dan Jepang selama masa kedudukan mereka di Indonesia.',
      publisher: 'Gramedia Pustaka Utama',
      status: 'Tersedia',
      voteAverage: 4.5,
      posterPath:
          'https://image.gramedia.net/rs:fit:0:0/plain/https://cdn.gramedia.com/uploads/items/9786020366517_Cantik-Itu-Luka-Hard-Cover---Limited-Edition.jpg',
    ),
    BookModel(
      id: 3,
      title: 'Seporsi Mie Ayam Sebelum Mati',
      overview:
          'Novel ini mengisahkan tentang perjalanan hidup seorang pria yang menemukan makna kehidupan melalui seporsi mie ayam yang sederhana namun penuh makna.',
      publisher: 'MediaKita',
      status: 'Tersedia',
      voteAverage: 4.2,
      posterPath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQd91MIjkuYVL3MzoN8vpl7SpbEYhIMyU4AEQ&s',
    ),
  ];
}
