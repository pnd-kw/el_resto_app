import 'package:flutter/material.dart';

class InfoContent extends StatelessWidget {
  final int flex;
  final Widget text;

  const InfoContent({super.key, required this.flex, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(left: 55, right: 20),
        child: text,
      ),
    );
  }
}
