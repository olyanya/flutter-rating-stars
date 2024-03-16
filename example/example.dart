import 'package:flutter/material.dart';
import 'package:rating_stars/rating_stars.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rating Stars')),
      body: RatingStars(
        activeColor: Colors.purple,
        backgroundColor: Colors.blue,
        onChanged: (value) => setState(() => rating = value),
      ),
    );
  }
}
