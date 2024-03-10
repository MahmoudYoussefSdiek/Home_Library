/*
* This file contains the HomeScreen which is the first screen that the user sees when the app is opened.
* It contains a search bar to search for books in the library.
 */

import 'package:flutter/material.dart';
import 'package:home_library/data_layer/model/book.dart';
import 'package:home_library/data_layer/data_base_helper/database_operations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showNoResultsMessage = false;
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
                  const Text(
                    'Home Library',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: _searchController,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search for books...",
                        hintStyle: const TextStyle(
                          color: Color(0xFF9098B1),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.50,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color(0xFFE5E5E5),
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search, color: Colors.blue),
                          onPressed: () {
                            _searchBooks();
                          },
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _searchBooks();
                        } else {
                          setState(() {
                            _searchResults.clear();
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_searchResults.isEmpty && _showNoResultsMessage)
                    const Text(
                      'No results found.',
                      style: TextStyle(color: Colors.red),
                    ),
                  if (_searchResults.isNotEmpty)
                    Column(
                      children: [
                        for (int i = 0; i < _searchResults.length; i++)
                          Column(
                            children: [
                              ListTile(
                                title: Text(_searchResults[i].bookName),
                                subtitle: Text(
                                  'Author: ${_searchResults[i].authorName}, Category: ${_searchResults[i].category}, Shelf: ${_searchResults[i].shelf}, Section: ${_searchResults[i].section}',
                                ),
                              ),
                              if (i < _searchResults.length - 1)
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                            ],
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _searchBooks() {
    final String searchTerm = _searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      searchBooksByName(searchTerm).then((results) {
        setState(() {
          _searchResults = results;
          _showNoResultsMessage = _searchResults.isEmpty;
        });
      });
    } else {
      setState(() {
        _searchResults.clear();
        _showNoResultsMessage = false;
      });
    }
  }
}
