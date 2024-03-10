class Book {
  final int id;
  final String bookName;
  final String authorName;
  final String category;
  final int shelf;
  final int section;

  Book({
    required this.id,
    required this.bookName,
    required this.authorName,
    required this.category,
    required this.shelf,
    required this.section,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      bookName: json['bookName'] as String,
      authorName: json['authorName'] as String,
      category: json['category'] as String,
      shelf: json['shelf'] as int,
      section: json['section'] as int,
    );
  }
}
