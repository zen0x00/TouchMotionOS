import 'package:flutter/material.dart';
import 'onboarding_state.dart';
import 'widgets/power_button.dart';
import 'screens/organisation_screen.dart';
import 'screens/slide1.dart';
import 'screens/slide2.dart';
import 'screens/slide3.dart';
import 'screens/slide4.dart';
import 'screens/slide5.dart';
import 'screens/slide6.dart';
import 'screens/slide7.dart';
import 'screens/slide8.dart';
import 'screens/slide9.dart';
import 'screens/slide10.dart';
import 'screens/slide11.dart';
import 'screens/slide12.dart';
import 'screens/slide13.dart';
import 'screens/slide14.dart';
import 'screens/slide15.dart';
import 'screens/slide16.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingState.isDone
          ? const OrganisationScreen()
          : const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _pageCount = 16;

  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (page) => setState(() => _page = page),
            children: const [
              Slide1Screen(),
              Slide2Screen(),
              Slide3Screen(),
              Slide4Screen(),
              Slide5Screen(),
              Slide6Screen(),
              Slide7Screen(),
              Slide8Screen(),
              Slide9Screen(),
              Slide10Screen(),
              Slide11Screen(),
              Slide12Screen(),
              Slide13Screen(),
              Slide14Screen(),
              Slide15Screen(),
              Slide16Screen(),
            ],
          ),

          // Power button
          Positioned(
            top: 16,
            right: 16,
            child: const PowerButton(),
          ),

          // Back arrow
          if (_page > 0)
            Positioned(
              left: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.chevron_left, size: 36),
                  onPressed: () => _controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
            ),

          // Next arrow
          if (_page < _pageCount - 1)
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.chevron_right, size: 36),
                  onPressed: () => _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
            ),

          // Page dots
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pageCount, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _page ? 10 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: i == _page
                        ? Colors.black
                        : Colors.black.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}