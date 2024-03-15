library rating_stars;

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RatingStars extends StatefulWidget {
  final ValueChanged<int> onChanged;
  final Color activeColor;
  final Color backgroundColor;
  final int? initialValue;

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
  StateMachineController? controller;
  SMIInput<double>? initialValue;
  double rating = 0.0;

  void _onInit(Artboard artboard) {
    controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
      onStateChange: (stateMachineName, stateName) {
        setState(() {
          int? id = initialValue!.id;
          rating = controller!.getInputValue(id);
          widget.onChanged(rating.toInt());
        });
      },
    );
    if (controller != null) {
      artboard.addController(controller!);
      initialValue = controller?.findInput<double>("Rating");
      initialValue!.change(widget.initialValue?.toDouble() ?? 1.0);

      artboard.forEachComponent((child) {
        if (child is Shape) {
          final Shape shape = child;
          if (shape.name == "Star_1" ||
              shape.name == "Star_2" ||
              shape.name == "Star_3" ||
              shape.name == "Star_4" ||
              shape.name == "Star_5") {
            (shape.fills.first.children[0] as SolidColor).colorValue =
                widget.activeColor.value;
          } else if (shape.name == "Star_base_1" ||
              shape.name == "Star_base_2" ||
              shape.name == "Star_base_3" ||
              shape.name == "Star_base_4" ||
              shape.name == "Star_base_5") {
            (shape.fills.first.children[0] as SolidColor).colorValue =
                widget.backgroundColor.value;
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
