import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide1Screen extends StatelessWidget {
  const Slide1Screen({super.key});

  @override
  Widget build(BuildContext context) {

    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    const figmaW = 1920.0;
    const figmaH = 1080.0;


    final scaleX = screenW / figmaW;
    final scaleY = screenH / figmaH;

    //scale values
    double sx(double val) => val * scaleX;
    double sy(double val) => val * scaleY;

    return SizedBox(
      width: screenW,
      height: screenH,
      child: Stack(
        children: [

          //Window
          Positioned(
            top: sy(332),
            left: sx(-191),
            child: SvgPicture.asset(
              'assets/slide1/Window.svg',
              width: sx(326.47),
              height: sy(404.79),
              fit: BoxFit.contain,
            ),
          ),

          //TV
          Positioned(
            top: sy(557),
            left: sx(-44),
            child: SvgPicture.asset(
              'assets/slide1/TV.svg',
              width: sx(487.79),
              height: sy(271.45),
              fit: BoxFit.contain,
            ),
          ),

          //Lamp
          Positioned(
            top: sy(-385),
            left: sx(811),
            child: SvgPicture.asset(
              'assets/slide1/Lamp.svg',
              width: sx(122),
              height: sy(778.78),
              fit: BoxFit.contain,
            ),
          ),

          //Clock
          Positioned(
            top: sy(133),
            left: sx(1598),
            child: SvgPicture.asset(
              'assets/slide1/Clock.svg',
              width: sx(138.04),
              height: sy(126.23),
              fit: BoxFit.contain,
            ),
          ),

          //Shelf
          Positioned(
            top: sy(276),
            left: sx(1374),
            child: SvgPicture.asset(
              'assets/slide1/Shelf.svg',
              width: sx(130.05),
              height: sy(106.66),
              fit: BoxFit.contain,
            ),
          ),

          //Plant
          Positioned(
            top: sy(649),
            left: sx(1736),
            child: SvgPicture.asset(
              'assets/slide1/Plant.svg',
              width: sx(87.75),
              height: sy(182.91),
              fit: BoxFit.contain,
            ),
          ),

          //Line
          Positioned(
            top: sy(831),
            left: 0,
            right: 0,
            child: Container(
              height: 1.3,
              color: Colors.black.withOpacity(0.15),
            ),
          ),

          //Title
          Positioned(
            top: sy(452),
            left: sx(465),
            child: SvgPicture.asset(
              'assets/slide1/Lets.svg',
              width: sx(1107),
              height: sy(157),
              fit: BoxFit.contain,
            ),
          ),

          //Subtitle
          Positioned(
            top: sy(599),
            left: sx(470),
            child: SvgPicture.asset(
              'assets/slide1/Press.svg',
              width: sx(1032),
              height: sy(29),
              fit: BoxFit.contain,
            ),
          ),

          //Cat
          Positioned(
            top: sy(941),
            left: sx(955),
            child: SvgPicture.asset(
              'assets/slide1/Cat.svg',
              width: sx(861.09),
              height: sy(97.85),
              fit: BoxFit.contain,
            ),
          ),

        ],
      ),
    );
  }
}