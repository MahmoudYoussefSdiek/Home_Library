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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}