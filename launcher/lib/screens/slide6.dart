import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide6Screen extends StatelessWidget {
  const Slide6Screen({super.key});

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
          //Frame6
          Positioned(
            top: sy(460.8),
            left: sx(10),
            child: SvgPicture.asset(
              'assets/slide6/Frame6.svg',
              width: sx(269.86),
              height: sy(146.62),
              fit: BoxFit.contain,
            ),
          ),

          //title
          Positioned(
            top: sy(366),
            left: sx(281),
            child: SvgPicture.asset(
              'assets/slide6/Alright6.svg',
              width: sx(1357),
              height: sy(294),
              fit: BoxFit.contain,
            ),
          ),

          //Sofa6
          Positioned(
            top: sy(784),
            left: sx(673),
            child: SvgPicture.asset(
              'assets/slide6/Sofa6.svg',
              width: sx(574.37),
              height: sy(259.95),
              fit: BoxFit.contain,
            ),
          ),

          //line
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
