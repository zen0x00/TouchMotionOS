import 'package:flutter/material.dart';

class Slide13Screen extends StatelessWidget {
  const Slide13Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset('assets/slide13/slide13.png', fit: BoxFit.cover),
    );
  }
}
