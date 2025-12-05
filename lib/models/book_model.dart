class BookModel {
  final int id;
  final String title;
  final String overview;
  final String publisher;
  final String status;
  final double voteAverage;
  final String posterPath;

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
