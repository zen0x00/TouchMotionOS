import 'package:flutter/material.dart';

class Slide15Screen extends StatelessWidget {
  const Slide15Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        'assets/slide15/slide15.png',
        fit: BoxFit.cover,
      ),
    );
  }
}