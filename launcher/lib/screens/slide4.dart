import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide4Screen extends StatelessWidget {
  const Slide4Screen({super.key});

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
          //Lamp4
          Positioned(
            top: sy(-21),
            left: sx(617),
            child: SvgPicture.asset(
              'assets/slide4/Lamp4.svg',
              width: sx(561.63),
              height: sy(282.40),
              fit: BoxFit.contain,
            ),
          ),

          //Clock4
          Positioned(
            top: sy(73),
            left: sx(1724),
            child: SvgPicture.asset(
              'assets/slide4/Clock4.svg',
              width: sx(138.04),
              height: sy(126.23),
              fit: BoxFit.contain,
            ),
          ),

          //title
          Positioned(
            top: sy(218),
            left: sx(487),
            child: SvgPicture.asset(
              'assets/slide4/Lets4.svg',
              width: sx(945),
              height: sy(196),
              fit: BoxFit.contain,
            ),
          ),

          //TV4
          Positioned(
            top: sy(477),
            left: sx(578),
            child: SvgPicture.asset(
              'assets/slide4/Tv4.svg',
              width: sx(752.20),
              height: sy(418.59),
              fit: BoxFit.contain,
            ),
          ),

          //Frame4
          Positioned(
            top: sy(414),
            left: sx(1349),
            child: SvgPicture.asset(
              'assets/slide4/Frame4.svg',
              width: sx(442.14),
              height: sy(240.22),
              fit: BoxFit.contain,
            ),
          ),

          //Sofa4
          Positioned(
            top: sy(750),
            left: sx(1228),
            child: SvgPicture.asset(
              'assets/slide4/Sofa4.svg',
              width: sx(654.90),
              height: sy(296.40),
              fit: BoxFit.contain,
            ),
          ),

          //line1
          Positioned(
            top: sy(896),
            left: 0,
            right: 0,
            child: Container(
              height: 1.3,
              color: Colors.black.withOpacity(0.15),
            ),
          ),

          //line2
          Positioned(
            top: sy(1044),
            left: sx(571),
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
