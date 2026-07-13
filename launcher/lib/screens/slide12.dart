import 'package:flutter/material.dart';

class Slide12Screen extends StatelessWidget {
  const Slide12Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        'assets/slide12/slide12.png',
        fit: BoxFit.cover,
      ),
    );
  }
}