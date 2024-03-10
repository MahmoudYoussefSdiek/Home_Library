import 'package:flutter/material.dart';
import 'package:home_library/data_layer/data_base_helper/database_operations.dart';
import 'package:home_library/presentation/screens/books.dart';
import 'package:home_library/presentation/screens/favorites_screen.dart';
import 'package:home_library/presentation/screens/home_screen.dart';
import 'package:home_library/presentation/widget/build_bottom_sheet.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _selectedIndex = 1;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isBottomSheetOpen = false;

  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _authorNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _shelfController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();

  bool _isFullNameValid = true;
  bool _isAuthorNameValid = true;
  bool _isCategoryValid = true;
  bool _isShelfValid = true;
  bool _isSectionValid = true;

  final List<Widget> _pages = [
    const BookScreen(),
    const HomeScreen(),
    const FavoritesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          setState(() {
            _isBottomSheetOpen = !_isBottomSheetOpen;
          });
          if (_isBottomSheetOpen) {
            scaffoldKey.currentState!.showBottomSheet((context) {
              return buildBottomSheet(
                  context,
                  _formKey,
                  _bookNameController,
                  _authorNameController,
                  _categoryController,
                  _shelfController,
                  _sectionController,
                  _isFullNameValid,
                  _isAuthorNameValid,
                  _isCategoryValid,
                  _isShelfValid,
                  _isSectionValid,
                  () => addRecord(
                      _bookNameController.text,
                      _authorNameController.text,
                      _categoryController.text,
                      int.tryParse(_shelfController.text) ?? -1,
                      int.tryParse(_sectionController.text) ?? -1));
            });
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Icon(_isBottomSheetOpen ? Icons.remove : Icons.add,
            color: Colors.white),
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
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void addRecord(String bookName, String authorName, String category, int shelf,
      int section) {
    if (_formKey.currentState?.validate() ?? false) {
      insertToDatabase(bookName, authorName, category, shelf, section);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _bookNameController.clear();
    _authorNameController.clear();
    _categoryController.clear();
    _shelfController.clear();
    _sectionController.clear();
    super.dispose();
  }
}

//______________________________________________________________________________
// import 'package:flutter/material.dart';
// import 'package:home_library/presentation/screens/books.dart';
// import 'package:home_library/presentation/screens/favorites_screen.dart';
// import 'package:home_library/presentation/screens/home_screen.dart';
//
// import 'package:sqflite/sqflite.dart';
//
// class HomeLayout extends StatefulWidget {
//   HomeLayout({super.key});
//
//   @override
//   State<HomeLayout> createState() => _HomeLayoutState();
// }
//
// class _HomeLayoutState extends State<HomeLayout> {
//   int _selectedIndex = 1;
//   late final Database database;
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//
//   //
//   final List<Widget> _pages = [
//     const BookScreen(),
//     const HomeScreen(),
//     const FavoritesScreen(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   // void initState() {
//   //   super.initState();
//   //   createDatabase();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: scaffoldKey,
//         body: _pages[_selectedIndex],
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             scaffoldKey.currentState!.showBottomSheet((context) {
//               return Container(
//                 height: 200,
//                 color: Colors.blue,
//                 child: const Center(
//                   child: Text('This is a bottom sheet'),
//                 ),
//               );
//             });
//           },
//           child: const Icon(Icons.add),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.book),
//               label: 'Books',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.favorite),
//               label: 'Favorites',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.blue,
//           onTap: _onItemTapped,
//         ));
//   }
//
//   void createDatabase() async {
//     database = await openDatabase(
//       'library.db',
//       version: 1,
//       onCreate: (database, version) {
//         print('database created');
//         database
//             .execute(
//                 'CREATE TABLE books (id INTEGER PRIMARY KEY, bookName TEXT, authorName TEXT, category TEXT, shelf INTEGER, part INTEGER)')
//             .then((value) => print('table created'))
//             .catchError((error) {
//           print('error creating table ${error.toString()}');
//         });
//       },
//       onOpen: (database) {
//         print('database opened');
//       },
//     );
//   }
//
//   void insertToDatabase() {
//     database.transaction((txn) async {
//       await txn
//           .rawInsert(
//               'INSERT INTO books(bookName, authorName, category, shelf, part) VALUES("bookTest", "authorTest", "categoryTest", 1, 1)')
//           .then((value) {
//         print('$value inserted successfully');
//       }).catchError((error) {
//         print('error when inserting new record ${error.toString()}');
//       });
//     });
//   }
// }
