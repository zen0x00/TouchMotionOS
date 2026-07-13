import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide2Screen extends StatelessWidget {
  const Slide2Screen({super.key});

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

          //Window2
          Positioned(
            top: sy(2),
            right: 0,
            child: SvgPicture.asset(
              'assets/slide2/Window2.svg',
              width: sx(500),
              height: sy(750),
              fit: BoxFit.contain,
            ),
          ),

          //Roof
          Positioned(
            top: sy(-32),
            left: sx(648),
            child: SvgPicture.asset(
              'assets/slide2/Roof2.svg',
              width: sx(623),
              height: sy(119.93),
              fit: BoxFit.contain,
            ),
          ),

          //Clock2
          Positioned(
            top: sy(225),
            left: sx(97),
            child: SvgPicture.asset(
              'assets/slide2/Clock2.svg',
              width: sx(137.96),
              height: sy(126.16),
              fit: BoxFit.contain,
            ),
          ),

          //Books2
          Positioned(
            top: sy(473),
            left: sx(0),
            child: SvgPicture.asset(
              'assets/slide2/Books2.svg',
              width: sx(127.08),
              height: sy(178.92),
              fit: BoxFit.contain,
            ),
          ),

          //title
          Positioned(
            top: sy(121),
            left: sx(327),
            child: SvgPicture.asset(
              'assets/slide2/Now2.svg',
              width: sx(1266),
              height: sy(98),
              fit: BoxFit.contain,
            ),
          ),

          //Subtitle
          Positioned(
            top: sy(243),
            left: sx(513),
            child: SvgPicture.asset(
              'assets/slide2/Scan2.svg',
              width: sx(894),
              height: sy(58),
              fit: BoxFit.contain,
            ),
          ),

          //Device
          Positioned(
            top: sy(380),
            left: sx(550),
            child: SvgPicture.asset(
              'assets/slide2/Device2.svg',
              width: sx(1100),
              height: sy(560),
              fit: BoxFit.contain,
            ),
          ),

          //Man2
          Positioned(
            top: sy(685),
            left: sx(-12),
            child: SvgPicture.asset(
              'assets/slide2/Man2.svg',
              width: sx(461.55),
              height: sy(301.65),
              fit: BoxFit.contain,
            ),
          ),

          //Plant
          Positioned(
            top: sy(600),
            right: 0,
            child: SvgPicture.asset(
              'assets/slide2/Plant2.svg',
              width: sx(201.76),
              height: sy(420.53),
              fit: BoxFit.contain,
            ),
          ),

          //line
          Positioned(
            top: sy(982),
            left: 0,
            right: 0,
            child: Container(
              height: 7,
              color: Colors.black.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }
}