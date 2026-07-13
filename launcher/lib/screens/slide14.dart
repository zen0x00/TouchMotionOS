import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide14Screen extends StatelessWidget {
  const Slide14Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    const figmaW = 1920.0;
    const figmaH = 1080.0;
    double sx(double val) => val * (screenW / figmaW);
    double sy(double val) => val * (screenH / figmaH);

    return Container(
      color: Colors.white,
      width: screenW,
      height: screenH,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [

          //System14
          Positioned(
            top: sy(110),
            left: sx(10),
            right: sx(20),
            child: SvgPicture.asset(
              'assets/slide14/System14.svg',
              width: sx(2100),
              height: sy(950),
              fit: BoxFit.contain,
            ),
          ),

          //Clock14
          Positioned(
            top: sy(42.7),
            left: sx(1766.9),
            child: SvgPicture.asset(
              'assets/slide14/Clock14.svg',
              width: sx(74.10),
              height: sy(67.76),
              fit: BoxFit.contain,
            ),
          ),

        ],
      ),
    );
  }
}