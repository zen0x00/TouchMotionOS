import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide3Screen extends StatelessWidget {
  const Slide3Screen({super.key});

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

          //Window
          Positioned(
            top: sy(21),
            left: sx(-72),
            child: SvgPicture.asset(
              'assets/slide3/Window3.svg',
              width: sx(562.63),
              height: sy(663.51),
              fit: BoxFit.contain,
            ),
          ),

          //Lamp3
          Positioned(
            top: sy(40),
            left: sx(360),
            child: SvgPicture.asset(
              'assets/slide3/Lamp3.svg',
              width: sx(100),
              height: sy(320),
              fit: BoxFit.contain,
            ),
          ),

          //Shelf3
          Positioned(
            top: sy(133),
            left: sx(1456),
            child: SvgPicture.asset(
              'assets/slide3/Shelf3.svg',
              width: sx(179.95),
              height: sy(147.59),
              fit: BoxFit.contain,
            ),
          ),

          //Clock3
          Positioned(
            top: sy(27),
            left: sx(1756),
            child: SvgPicture.asset(
              'assets/slide3/Clock3.svg',
              width: sx(138.04),
              height: sy(126.23),
              fit: BoxFit.contain,
            ),
          ),

          //title
          Positioned(
            top: sy(220),
            left: sx(624),
            child: SvgPicture.asset(
              'assets/slide3/Connect3.svg',
              width: sx(672),
              height: sy(98),
              fit: BoxFit.contain,
            ),
          ),

          //TV3
          Positioned(
            top: sy(414),
            left: sx(480),
            child: SvgPicture.asset(
              'assets/slide3/Tv3.svg',
              width: sx(980.09),
              height: sy(545.41),
              fit: BoxFit.contain,
            ),
          ),

          //line
          Positioned(
            top: sy(964),
            left: 0,
            right: 0,
            child: Container(
              height: 1.3,
              color: Colors.black.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }
}