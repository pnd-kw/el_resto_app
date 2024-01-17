import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final double height;
  final Color color;
  final Widget? child;

  const TextBox(
      {super.key, required this.height, required this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border.all(width: 1.0),
      ),
      child: child,
    );
  }
}
