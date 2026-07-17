import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide11Screen extends StatelessWidget {
  const Slide11Screen({super.key});

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
          //Lady11
          Positioned(
            top: sy(214),
            left: 0,
            child: SvgPicture.asset(
              'assets/slide11/Lady11.svg',
              width: sx(659.22),
              height: sy(907.03),
              fit: BoxFit.contain,
            ),
          ),

          //headline
          Positioned(
            top: sy(442),
            left: sx(700),
            child: SvgPicture.asset(
              'assets/slide11/Ok11.svg',
              width: sx(520),
              height: sy(196),
              fit: BoxFit.contain,
            ),
          ),

          //Tree11
          Positioned(
            top: sy(289),
            left: sx(1057),
            child: SvgPicture.asset(
              'assets/slide11/Tree11.svg',
              width: sx(419.04),
              height: sy(487.10),
              fit: BoxFit.contain,
            ),
          ),

          //People11
          Positioned(
            top: sy(492),
            left: sx(1336),
            child: SvgPicture.asset(
              'assets/slide11/People11.svg',
              width: sx(550.66),
              height: sy(556.31),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
