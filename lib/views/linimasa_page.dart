import 'package:flutter/material.dart';
import 'package:ukl2025/views/detail.dart';
import '../controllers/book_controller.dart';
import '../models/book_model.dart';
import 'package:ukl2025/widgets/modal_widget.dart';

class LinimasaPage extends StatefulWidget {
  const LinimasaPage({super.key});

  @override
  State<LinimasaPage> createState() => _LinimasaPageState();
}

class _LinimasaPageState extends State<LinimasaPage> {
  final formKey = GlobalKey<FormState>();

  BookController bookController = BookController();
  ModalWidget modalWidget = ModalWidget();

  TextEditingController titleController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  String? _selectedStatus;

  List<BookModel> timelineItems = [];
  int? bookId;

  void getTimelineItems() {
    setState(() {
      timelineItems = bookController.books;
    });
  }

  @override
  void initState() {
    super.initState();
    getTimelineItems();

    _selectedStatus = 'Tersedia';
  }

  @override
  void dispose() {
    titleController.dispose();
    imageController.dispose();
    descriptionController.dispose();
    publisherController.dispose();
    super.dispose();
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
          rating != null ? rating.toStringAsFixed(1) : '0.0',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF1A2D25),
          ),
        ),
      ],
    );
  }

  void _showContentFormModal({BookModel? itemToEdit, int? index}) {
    if (itemToEdit != null) {
      bookId = itemToEdit.id;
      titleController.text = itemToEdit.title;
      imageController.text = itemToEdit.posterPath;
      descriptionController.text = itemToEdit.overview;
      publisherController.text = itemToEdit.publisher;
      _selectedStatus = itemToEdit.status;
    } else {
      bookId = null;
      titleController.text = '';
      imageController.text = '';
      descriptionController.text = '';
      publisherController.text = '';

      _selectedStatus = 'Tersedia';
    }

    setState(() {});

    modalWidget.showFullModal(
      context,
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: _buildAddEditForm(
            itemToEdit,
            index,
            itemToEdit?.voteAverage ?? 0.0,
          ),
        ),
      ),
    );
  }

  InputDecoration _customInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      fillColor: Colors.grey[50],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.deepOrange, width: 2.0),
      ),
      floatingLabelStyle: const TextStyle(
        color: Colors.deepOrange,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAddEditForm(
    BookModel? itemToEdit,
    int? index,
    double currentRating,
  ) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Form Konten Buku',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A2D25),
            ),
          ),
          const Divider(height: 30, thickness: 1),

          TextFormField(
            controller: titleController,
            decoration: _customInputDecoration('Judul Konten'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Judul harus diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          TextFormField(
            controller: imageController,
            decoration: _customInputDecoration('URL Gambar/Poster'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'URL Gambar harus diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          TextFormField(
            controller: descriptionController,
            maxLines: 3,
            decoration: _customInputDecoration('Deskripsi/Overview'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Deskripsi harus diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          TextFormField(
            controller: publisherController,
            decoration: _customInputDecoration('Publisher'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Publisher harus diisi';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          DropdownButtonFormField<String>(
            value: _selectedStatus,
            decoration: _customInputDecoration('Status Bacaan'),

            items: <String>['Tersedia', 'Tidak Tersedia']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                .toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedStatus = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Status harus dipilih';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (itemToEdit != null) {
                  int targetId = itemToEdit.id;
                  int listIndex = bookController.books.indexWhere(
                    (b) => b.id == targetId,
                  );

                  if (listIndex != -1) {
                    bookController.books[listIndex] = BookModel(
                      id: targetId,
                      title: titleController.text,
                      overview: descriptionController.text,
                      publisher: publisherController.text,
                      status: _selectedStatus!,
                      voteAverage: currentRating,
                      posterPath: imageController.text,
                    );
                  }
                  getTimelineItems();
                  Navigator.pop(context);
                } else {
                  int id = bookController.books.isEmpty
                      ? 1
                      : bookController.books.last.id + 1;
                  bookController.books.add(
                    BookModel(
                      id: id,
                      title: titleController.text,
                      overview: descriptionController.text,
                      publisher: publisherController.text,
                      status: _selectedStatus!,
                      voteAverage: 0.0,
                      posterPath: imageController.text,
                    ),
                  );
                  getTimelineItems();
                  Navigator.pop(context);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
            ),
            child: Text(
              itemToEdit != null ? 'UBAH KONTEN' : 'SIMPAN KONTEN',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BookModel item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text(
            'Apakah Anda yakin ingin menghapus konten "${item.title}"?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                bookController.books.removeWhere((book) => book.id == item.id);

                getTimelineItems();
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Konten "${item.title}" berhasil dihapus.'),
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimelineCard(BookModel item, int index) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailContentPage(
              item: item,
              bookController: bookController,
              onDataUpdated: getTimelineItems,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 15),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 70,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[300],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: item.posterPath.isNotEmpty
                      ? Image.network(
                          item.posterPath,
                          width: 70,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.image_outlined,
                                color: Colors.white,
                                size: 40,
                              ),
                        )
                      : const Icon(
                          Icons.image_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                ),
              ),
              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A2D25),
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${item.publisher}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        _buildStarRating(item.voteAverage),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              _showContentFormModal(
                                itemToEdit: item,
                                index: index,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                            ),
                            child: const Text('Edit'),
                          ),
                        ),
                        const SizedBox(width: 8),

                        SizedBox(
                          width: 60,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              _showDeleteConfirmation(item);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                            ),
                            child: const Text('Hapus'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: const Text(
          'Linimasa',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              _showContentFormModal(itemToEdit: null, index: null);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: timelineItems.length,
              itemBuilder: (context, index) {
                return _buildTimelineCard(timelineItems[index], index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
