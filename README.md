# Rating Stars

Customizable package that offers a way to collect user ratings. Based on Rive animation, it delivers a dynamic rating that can be adapted to fit into any app.

![Rating stars example](https://github.com/olyanya/flutter-rating-stars/blob/main/lib/assets/rating_stars_example.gif)

## Getting started

Import `rating_stars` in your file:
```dart
import 'package:rating_stars/rating_stars.dart';
```

## Example

(See `example` for more)

```dart
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
```

