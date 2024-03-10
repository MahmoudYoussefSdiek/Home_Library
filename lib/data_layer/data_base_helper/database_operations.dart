import 'package:home_library/data_layer/model/book.dart';
import 'package:sqflite/sqflite.dart';

late final Database database;

void createDatabase() async {
  database = await openDatabase(
    'library.db',
    version: 1,
    onCreate: (database, version) {
      print('database created');
      database
          .execute(
            'CREATE TABLE books (id INTEGER PRIMARY KEY, bookName TEXT, authorName TEXT, category TEXT, shelf INTEGER, section INTEGER)',
          )
          .then((value) => print('table created'))
          .catchError((error) {
        print('error creating table ${error.toString()}');
      });
    },
    onOpen: (database) {
      print('database opened');
    },
  );
}

void insertToDatabase(String bookName, String authorName, String category,
    int shelf, int section) {
  database.transaction((txn) async {
    await txn
        .rawInsert(
      'INSERT INTO books(bookName, authorName, category, shelf, section) VALUES("$bookName", "$authorName", "$category", $shelf, $section)',
    )
        .then((value) {
      print('$value inserted successfully');
    }).catchError((error) {
      print('error when inserting new record ${error.toString()}');
    });
  });
}

Future<List<Book>> searchBooksByName(String name) async {
  final List<Map<String, dynamic>> results = await database.query(
    'books',
    where: 'bookName LIKE ?',
    whereArgs: ['%$name%'],
  );
  return results.map((e) => Book.fromJson(e)).toList();
}

Future<List<Book>> getAllBooks() async {
  final List<Map<String, dynamic>> results = await database.query('books');
  return results.map((e) => Book.fromJson(e)).toList();
}
