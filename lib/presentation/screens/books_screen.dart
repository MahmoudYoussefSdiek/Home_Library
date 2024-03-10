import 'package:flutter/material.dart';
import 'package:home_library/data_layer/data_base_helper/database_operations.dart';
import 'package:home_library/data_layer/model/book.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  List<Book> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllBooks();
  }

  Future<void> fetchAllBooks() async {
    final List<Book> books = await getAllBooks();
    setState(() {
      _books = books;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Books'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _books.isEmpty
              ? const Center(
                  child: Text('No records found.'),
                )
              : ListView.builder(
                  itemCount: _books.length * 2 - 1,
                  itemBuilder: (context, index) {
                    if (index.isOdd) {
                      return const Divider(); // Add a Divider between items
                    }
                    final bookIndex = index ~/ 2;
                    final book = _books[bookIndex];
                    return ListTile(
                      title: Text(book.bookName),
                      subtitle: Text(
                        'Author: ${book.authorName}, Category: ${book.category}, Shelf: ${book.shelf}, Section: ${book.section}',
                      ),
                    );
                  },
                ),
    );
  }
}
