import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Slide10Screen extends StatelessWidget {
  const Slide10Screen({super.key});

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

          //Clock10
          Positioned(
            top: sy(74.86),
            left: sx(119),
            child: SvgPicture.asset(
              'assets/slide10/Clock10.svg',
              width: sx(133.97),
              height: sy(122.50),
              fit: BoxFit.contain,
            ),
          ),

          //Tip10
          Positioned(
            top: sy(-58.07),
            left: sx(374),
            child: SvgPicture.asset(
              'assets/slide10/Tip10.svg',
              width: sx(1178.5),
              height: sy(498.07),
              fit: BoxFit.contain,
            ),
          ),

          //title
          Positioned(
            top: sy(505),
            left: sx(365),
            child: SvgPicture.asset(
              'assets/slide10/Make10.svg',
              width: sx(1188),
              height: sy(196),
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            top: sy(755),
            left: sx(837),
            child: SvgPicture.asset(
              'assets/slide10/Done10.svg',
              width: sx(230),
              height: sy(56),
              fit: BoxFit.contain,
            ),
          ),


          //line
          Positioned(
            top: sy(896),
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