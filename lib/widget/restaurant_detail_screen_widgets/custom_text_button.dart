import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final int flex;
  final TextButton textButton;

  const CustomTextButton(
      {super.key, required this.flex, required this.textButton});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 20),
        child: textButton,
      ),
    );
  }
}
