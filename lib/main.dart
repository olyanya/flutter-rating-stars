import 'package:flutter/material.dart';
import 'package:rating_stars/widgets/rating_stars.dart';

void main() {
  runApp(const HomePage());
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
    return MaterialApp(
      title: 'Basic Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: RatingStars(
            onChanged: (value) => setState(() => rating = value),
          ),
        ),
      ),
    );
  }
}
