import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide8Screen extends StatelessWidget {
  const Slide8Screen({super.key});

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

          //Tip8
          Positioned(
            top: sy(111),
            left: sx(826),
            child: SvgPicture.asset(
              'assets/slide8/Tip8.svg',
              width: sx(267.06),
              height: sy(209.54),
              fit: BoxFit.contain,
            ),
          ),

          //title
          Positioned(
            top: sy(360),
            left: sx(446),
            child: SvgPicture.asset(
              'assets/slide8/Avoid8.svg',
              width: sx(1227),
              height: sy(294),
              fit: BoxFit.contain,
            ),
          ),

          //Dress8
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Center(
              child: SvgPicture.asset(
                'assets/slide8/Dress8.svg',
                width: sx(1500),
                fit: BoxFit.contain,
              ),
            ),
          ),

        ],
      ),
    );
  }
}