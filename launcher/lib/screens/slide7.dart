import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide7Screen extends StatelessWidget {
  const Slide7Screen({super.key});

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
          //Clock7
          Positioned(
            top: sy(74.86),
            left: sx(119),
            child: SvgPicture.asset(
              'assets/slide7/Clock7.svg',
              width: sx(133.96),
              height: sy(122.50),
              fit: BoxFit.contain,
            ),
          ),

          //Tip7
          Positioned(
            top: sy(175),
            left: sx(826),
            child: SvgPicture.asset(
              'assets/slide7/Tip7.svg',
              width: sx(267.06),
              height: sy(209.54),
              fit: BoxFit.contain,
            ),
          ),

          //title
          Positioned(
            top: sy(424),
            left: sx(490),
            child: SvgPicture.asset(
              'assets/slide7/Clean7.svg',
              width: sx(972),
              height: sy(196),
              fit: BoxFit.contain,
            ),
          ),

          //Sofa7
          Positioned(
            top: sy(700),
            left: sx(559),
            child: SvgPicture.asset(
              'assets/slide7/Sofa7.svg',
              width: sx(776.70),
              height: sy(444.67),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
