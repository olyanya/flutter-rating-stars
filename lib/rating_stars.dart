library rating_stars;

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// RatingStars is a dynamic widget for capturing user ratings with visually interactive stars
///
/// ```dart
/// RatingStars(
///   activeColor: Colors.purple,
///   backgroundColor: Colors.blue,
///   onChanged: (value) => setState(() => rating = value),
/// )
/// ```
class RatingStars extends StatefulWidget {
  /// This function will be executed each time the user change the number of selected stars
  final ValueChanged<int> onChanged;

  /// Change the colors of the selected stars
  final Color? activeColor;

  /// Change the color of the background of the stars
  final Color? backgroundColor;

  /// The initial rating value
  final int? initialValue;

  /// Default constructor
  const RatingStars({
    super.key,
    this.activeColor = Colors.amber,
    this.backgroundColor = Colors.white,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  /// Rive controller for animation control
  StateMachineController? controller;

  /// Initial value in the Rive animation
  SMIInput<double>? initialValue;

  /// Rating value
  double rating = 0.0;

  /// Initializes the Rive animation with custom parameters
  void _onInit(Artboard artboard) {
    controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
      onStateChange: (stateMachineName, stateName) {
        // Callback for when a state change occurs in the Rive animation
        setState(() {
          int? id = initialValue!.id;
          rating = controller!.getInputValue(id);

          // Notifies the widget user of the rating change
          widget.onChanged(rating.toInt());
        });
      },
    );
    if (controller != null) {
      artboard.addController(controller!);

      // Sets the initial rating value within the Rive animation
      initialValue = controller?.findInput<double>("Rating");

      // Finds and sets the initial value input for the rating
      initialValue!.change(widget.initialValue?.toDouble() ?? 1.0);

      artboard.forEachComponent((child) {
        if (child is Shape) {
          final Shape shape = child;

          // Customizes the color of selected stars based on the activeColor
          if (shape.name == "Star_1" ||
              shape.name == "Star_2" ||
              shape.name == "Star_3" ||
              shape.name == "Star_4" ||
              shape.name == "Star_5") {
            (shape.fills.first.children[0] as SolidColor).colorValue =
                widget.activeColor!.value;

            // Customizes the background color of stars based on the backgroundColor
          } else if (shape.name == "Star_base_1" ||
              shape.name == "Star_base_2" ||
              shape.name == "Star_base_3" ||
              shape.name == "Star_base_4" ||
              shape.name == "Star_base_5") {
            (shape.fills.first.children[0] as SolidColor).colorValue =
                widget.backgroundColor!.value;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset('assets/stars.riv', onInit: _onInit);
  }
}
