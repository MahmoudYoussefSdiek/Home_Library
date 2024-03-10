/*
  Main file of the application
  This file is the entry point of the application
  It is responsible for creating the main widget of the application

  Because the application is simple, the main widget is the HomeLayout widget,
  in other scenarios I give it Router class to handle the navigation and it will
  contain the instance of the business logic presenter [That handle the state of the application]
*/

import 'package:flutter/material.dart';
import 'package:home_library/presentation/layout/home_layout.dart';

void main() {
  runApp(const HomeLibrary());
}

class HomeLibrary extends StatelessWidget {
  const HomeLibrary({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
