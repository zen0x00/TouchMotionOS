import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide9Screen extends StatelessWidget {
  const Slide9Screen({super.key});

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
          //Wall9
          Positioned(
            top: sy(14),
            left: sx(1550),
            child: SvgPicture.asset(
              'assets/slide9/Wall9.svg',
              width: sx(370.06),
              height: sy(328.92),
              fit: BoxFit.contain,
            ),
          ),

          //Frame9
          Positioned(
            top: sy(460.8),
            left: sx(10),
            child: SvgPicture.asset(
              'assets/slide9/Frame9.svg',
              width: sx(269.86),
              height: sy(146.62),
              fit: BoxFit.contain,
            ),
          ),

          //Tip9
          Positioned(
            top: sy(111),
            left: sx(826),
            child: SvgPicture.asset(
              'assets/slide9/Tip9.svg',
              width: sx(267.06),
              height: sy(209.54),
              fit: BoxFit.contain,
            ),
          ),

          //title
          Positioned(
            top: sy(360),
            left: sx(509),
            child: SvgPicture.asset(
              'assets/slide9/Avoid9.svg',
              width: sx(900),
              height: sy(196),
              fit: BoxFit.contain,
            ),
          ),

          //TV9
          Positioned(
            top: sy(706),
            left: sx(648),
            child: SvgPicture.asset(
              'assets/slide9/Tv9.svg',
              width: sx(624.24),
              height: sy(337.58),
              fit: BoxFit.contain,
            ),
          ),

          //line1 ──
          Positioned(
            top: sy(896),
            left: 0,
            right: 0,
            child: Container(
              height: 1.3,
              color: Colors.black.withOpacity(0.15),
            ),
          ),

          //line 2
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
