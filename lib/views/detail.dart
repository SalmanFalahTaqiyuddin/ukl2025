import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../controllers/book_controller.dart';

class DetailInteractiveStarRating extends StatefulWidget {
  final double initialRating;
  final Function(double newRating) onRatingChanged;

  const DetailInteractiveStarRating({
    required this.initialRating,
    required this.onRatingChanged,
    super.key,
  });

  @override
  State<DetailInteractiveStarRating> createState() =>
      _DetailInteractiveStarRatingState();
}

class _DetailInteractiveStarRatingState
    extends State<DetailInteractiveStarRating> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  void didUpdateWidget(covariant DetailInteractiveStarRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialRating != oldWidget.initialRating) {
      _currentRating = widget.initialRating;
    }
  }

  void _updateRating(double newRating) {
    setState(() {
      _currentRating = newRating;
    });

    widget.onRatingChanged(newRating);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            double starValue = (index + 1).toDouble();

            IconData icon;
            if (_currentRating >= starValue) {
              icon = Icons.star;
            } else if (_currentRating >= starValue - 0.5) {
              icon = Icons.star_half;
            } else {
              icon = Icons.star_border;
            }

            return GestureDetector(
              onTap: () {
                _updateRating(index + 1.0);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: Icon(icon, color: Colors.amber, size: 30),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),

        Text(
          'Rating: ${_currentRating.toStringAsFixed(1)} / 5.0',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ],
    );
  }
}

class DetailContentPage extends StatefulWidget {
  final BookModel item;
  final BookController bookController;
  final VoidCallback onDataUpdated;

  const DetailContentPage({
    required this.item,
    required this.bookController,
    required this.onDataUpdated,
    super.key,
  });

  @override
  State<DetailContentPage> createState() => _DetailContentPageState();
}

class _DetailContentPageState extends State<DetailContentPage> {
  late double _liveRating;

  @override
  void initState() {
    super.initState();
    _liveRating = widget.item.voteAverage;
  }

  void _updateBookRatingInController(double newRating) {
    setState(() {
      _liveRating = newRating;
    });

    final bookIndex = widget.bookController.books.indexWhere(
      (b) => b.id == widget.item.id,
    );

    if (bookIndex != -1) {
      BookModel existingBook = widget.bookController.books[bookIndex];

      widget.bookController.books[bookIndex] = BookModel(
        id: existingBook.id,
        title: existingBook.title,
        overview: existingBook.overview,
        publisher: existingBook.publisher,
        status: existingBook.status,
        voteAverage: newRating,
        posterPath: existingBook.posterPath,
      );
    }
  }

  Widget _buildStarRating(double? rating) {
    double clampedRating = (rating ?? 0.0).clamp(0.0, 5.0);
    int fullStars = clampedRating.floor();
    bool hasHalfStar = (clampedRating - fullStars) >= 0.5;

    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(const Icon(Icons.star, color: Colors.amber, size: 20));
      } else if (i == fullStars && hasHalfStar) {
        stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 20));
      } else {
        stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 20));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...stars,
        const SizedBox(width: 8),
        Text(
          '(${rating?.toStringAsFixed(1)})',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookIndex = widget.bookController.books.indexWhere(
      (b) => b.id == widget.item.id,
    );
    final currentBook = bookIndex != -1
        ? widget.bookController.books[bookIndex]
        : widget.item;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Konten',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF1A2D25),
          onPressed: () {
            widget.onDataUpdated();
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[300],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: currentBook.posterPath.isNotEmpty
                        ? Image.network(
                            currentBook.posterPath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.image_outlined,
                                  color: Colors.white,
                                  size: 50,
                                ),
                          )
                        : const Icon(
                            Icons.image_outlined,
                            color: Colors.white,
                            size: 50,
                          ),
                  ),
                ),
                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentBook.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A2D25),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Publisher: ${currentBook.publisher}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                        ),
                      ),
                      const SizedBox(height: 8),

                      _buildStarRating(_liveRating),
                      const SizedBox(height: 10),

                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: const Text('Beri Rating'),
                                content: Builder(
                                  builder: (innerContext) {
                                    return DetailInteractiveStarRating(
                                      initialRating: _liveRating,
                                      onRatingChanged: (newRating) {
                                        _updateBookRatingInController(
                                          newRating,
                                        );
                                      },
                                    );
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.star),
                        label: const Text('Berikan Ulasan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Sinopsis Buku',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(currentBook.overview, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 20),

            const Text(
              'Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Chip(
              label: Text(
                currentBook.status,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
          ],
        ),
      ),
    );
  }
}
