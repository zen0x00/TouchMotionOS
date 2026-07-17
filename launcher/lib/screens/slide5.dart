import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide5Screen extends StatelessWidget {
  const Slide5Screen({super.key});

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
          //TV5
          Positioned(
            top: sy(146),
            left: sx(160),
            child: SvgPicture.asset(
              'assets/slide5/Tv5.svg',
              width: sx(1641.66),
              height: sy(913.56),
              fit: BoxFit.contain,
            ),
          ),

          //Plant5
          Positioned(
            top: sy(395.55),
            left: sx(217.15),
            child: SvgPicture.asset(
              'assets/slide5/Plant5.svg',
              width: sx(154.87),
              height: sy(322.82),
              fit: BoxFit.contain,
            ),
          ),

          //text
          Positioned(
            top: sy(374.83),
            left: sx(495),
            child: SvgPicture.asset(
              'assets/slide5/Center5.svg',
              width: sx(894.42),
              height: sy(153.79),
              fit: BoxFit.contain,
            ),
          ),

          //Subtitle
          Positioned(
            top: sy(556.44),
            left: sx(568),
            child: SvgPicture.asset(
              'assets/slide5/Subtitle5.svg',
              width: sx(647.61),
              height: sy(34.36),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
