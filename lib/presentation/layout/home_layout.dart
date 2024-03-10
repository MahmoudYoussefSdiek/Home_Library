import 'package:flutter/material.dart';
import 'package:home_library/presentation/screens/books.dart';
import 'package:home_library/presentation/screens/favorites_screen.dart';
import 'package:home_library/presentation/screens/home_screen.dart';

import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _selectedIndex = 1;
  late final Database database;

  //
  final List<Widget> _pages = [
    const BookScreen(),
    const HomeScreen(),
    const FavoritesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            insertToDatabase();
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ));
  }

  void createDatabase() async {
    database = await openDatabase(
      'library.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE books (id INTEGER PRIMARY KEY, bookName TEXT, authorName TEXT, category TEXT, shelf INTEGER, part INTEGER)')
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

  void insertToDatabase() {
    database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO books(bookName, authorName, category, shelf, part) VALUES("bookTest", "authorTest", "categoryTest", 1, 1)')
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('error when inserting new record ${error.toString()}');
      });
    });
  }
}
