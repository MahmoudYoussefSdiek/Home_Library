import 'package:flutter/material.dart';
import 'package:home_library/data_layer/data_base_helper/database_operations.dart';
import 'package:home_library/data_layer/model/book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Home Library',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.50,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by book name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          searchBooksByName(value).then((results) {
                            setState(() {
                              _searchResults = results;
                            });
                          });
                        } else {
                          setState(() {
                            _searchResults.clear();
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_searchResults.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _searchResults
                          .map(
                            (book) => ListTile(
                              title: Text(book.bookName),
                              subtitle: Text(
                                'Author: ${book.authorName}, Category: ${book.category}, Shelf: ${book.shelf}, Section: ${book.section}',
                              ),
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//-----------------------------------------
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: const Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'Home Screen',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.50,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
