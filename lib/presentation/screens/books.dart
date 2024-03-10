import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Here you can see all your books with information.',
              softWrap: true, // Allow the text to wrap to the next line
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.50,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Work in progress...',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
