class Book {
  final int id;
  final String bookName;
  final String authorName;
  final String category;
  final int shelf;
  final int part;
  final int position;

  Book({
    required this.id,
    required this.bookName,
    required this.authorName,
    required this.category,
    this.shelf = 0,
    this.part = 0,
    this.position = 0,
  });
}
