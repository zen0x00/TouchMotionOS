import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/power_button.dart';
import 'physio_screen.dart';
import 'settings_screen.dart';

/// Tomoro home screen, styled after the onboarding slides: white canvas,
/// hand-drawn illustration accents, soft lavender fills and bold dark
/// headlines laid out against the 1920x1080 Figma reference frame.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _Game {
  const _Game({
    required this.id,
    required this.title,
    required this.tagline,
    required this.accent,
    required this.artBuilder,
  });

  /// Binary name looked up on PATH when the card is tapped.
  final String id;
  final String title;
  final String tagline;
  final Color accent;
  final Widget Function(double Function(double) sx, double Function(double) sy)
  artBuilder;
}

class _HomeScreenState extends State<HomeScreen> {
  static const _ink = Color(0xFF1C1C1E);
  static const _lavender = Color(0xFFF2E7FA);
  static const _lavenderDeep = Color(0xFFE3CDF6);

  static final _games = <_Game>[
    _Game(
      id: 'tomoro-skyhopper',
      title: 'Sky Hopper',
      tagline: 'Flap through the city — one hop at a time',
      accent: _lavender,
      artBuilder: (sx, sy) =>
          Image.asset('assets/slide15/slide15.png', fit: BoxFit.cover),
    ),
    _Game(
      id: 'tomoro-catnap',
      title: 'Cat Nap Chase',
      tagline: 'Keep the cat awake with your best moves',
      accent: _lavenderDeep,
      artBuilder: (sx, sy) => Padding(
        padding: EdgeInsets.symmetric(horizontal: sx(60), vertical: sy(40)),
        child: SvgPicture.asset('assets/slide1/Cat.svg', fit: BoxFit.contain),
      ),
    ),
    _Game(
      id: 'tomoro-dashlands',
      title: 'Dashlands',
      tagline: 'Dash, jump, and race across the lands',
      accent: _lavender,
      artBuilder: (sx, sy) =>
          Image.asset('assets/dashlands/dashlands.png', fit: BoxFit.cover),
    ),
  ];

  late Timer _clockTimer;
  DateTime _now = DateTime.now();
  String? _launching;

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  String get _clock {
    final h = _now.hour % 12 == 0 ? 12 : _now.hour % 12;
    final m = _now.minute.toString().padLeft(2, '0');
    final ampm = _now.hour < 12 ? 'AM' : 'PM';
    return '$h:$m $ampm';
  }

  String get _greeting {
    if (_now.hour < 12) return 'Good morning!';
    if (_now.hour < 17) return 'Good afternoon!';
    return 'Good evening!';
  }

  Future<void> _launchGame(_Game game) async {
    if (_launching != null) return;
    setState(() => _launching = game.id);
    try {
      await Process.start(game.id, const [], mode: ProcessStartMode.detached);
    } on ProcessException {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: _ink,
            content: Text('${game.title} is not installed yet'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _launching = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    const figmaW = 1920.0;
    const figmaH = 1080.0;
    double sx(double val) => val * (screenW / figmaW);
    double sy(double val) => val * (screenH / figmaH);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: screenW,
        height: screenH,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // Decorative shelf, top-right — mirrors slide1 scenery.
            Positioned(
              top: sy(90),
              left: sx(1620),
              child: SvgPicture.asset(
                'assets/slide1/Shelf.svg',
                width: sx(130),
                height: sy(107),
                fit: BoxFit.contain,
              ),
            ),

            // Decorative plant, bottom-right.
            Positioned(
              top: sy(860),
              left: sx(1770),
              child: SvgPicture.asset(
                'assets/slide1/Plant.svg',
                width: sx(88),
                height: sy(183),
                fit: BoxFit.contain,
              ),
            ),

            // Header: greeting + clock + power.
            Positioned(
              top: sy(64),
              left: sx(96),
              right: sx(96),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _greeting,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: _ink,
                            fontSize: sy(72),
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1,
                            height: 1.05,
                          ),
                        ),
                        SizedBox(height: sy(12)),
                        Text(
                          'Pick a game and get moving',
                          style: TextStyle(
                            color: _ink.withValues(alpha: 0.55),
                            fontSize: sy(26),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _clock,
                    style: TextStyle(
                      color: _ink,
                      fontSize: sy(30),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: sx(24)),
                  IconButton(
                    tooltip: 'Contact my physio',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PhysioScreen(),
                      ),
                    ),
                    icon: Icon(
                      Icons.support_agent,
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(width: sx(8)),
                  IconButton(
                    tooltip: 'Settings',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SettingsScreen(),
                      ),
                    ),
                    icon: Icon(
                      Icons.settings_outlined,
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(width: sx(8)),
                  const PowerButton(),
                ],
              ),
            ),

            // Divider line, same treatment as the slides.
            Positioned(
              top: sy(252),
              left: sx(96),
              right: sx(96),
              child: Container(
                height: 1.3,
                color: Colors.black.withValues(alpha: 0.15),
              ),
            ),

            // Library section.
            Positioned(
              top: sy(300),
              left: sx(96),
              child: Text(
                'Library',
                style: TextStyle(
                  color: _ink,
                  fontSize: sy(44),
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            Positioned(
              top: sy(392),
              left: sx(96),
              right: sx(96),
              height: sy(520),
              child: Row(
                children: [
                  for (final game in _games) ...[
                    Expanded(child: _gameCard(game, sx, sy)),
                    if (game != _games.last) SizedBox(width: sx(48)),
                  ],
                ],
              ),
            ),

            // Footer hint.
            Positioned(
              bottom: sy(40),
              left: sx(96),
              child: Row(
                children: [
                  Icon(
                    Icons.touch_app_outlined,
                    color: _ink.withValues(alpha: 0.35),
                    size: sy(24),
                  ),
                  SizedBox(width: sx(12)),
                  Text(
                    'Tap a card to play',
                    style: TextStyle(
                      color: _ink.withValues(alpha: 0.35),
                      fontSize: sy(20),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gameCard(
    _Game game,
    double Function(double) sx,
    double Function(double) sy,
  ) {
    final launching = _launching == game.id;
    return GestureDetector(
      onTap: () => _launchGame(game),
      child: AnimatedScale(
        scale: launching ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            color: game.accent,
            borderRadius: BorderRadius.circular(sy(28)),
            border: Border.all(color: _ink.withValues(alpha: 0.12), width: 1.3),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: game.artBuilder(sx, sy)),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: sx(36),
                  vertical: sy(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            game.title,
                            style: TextStyle(
                              color: _ink,
                              fontSize: sy(32),
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: sy(6)),
                          Text(
                            game.tagline,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: _ink.withValues(alpha: 0.55),
                              fontSize: sy(20),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: sx(24)),
                    launching
                        ? SizedBox(
                            width: sy(36),
                            height: sy(36),
                            child: const CircularProgressIndicator(
                              strokeWidth: 3,
                              color: _ink,
                            ),
                          )
                        : Container(
                            width: sy(56),
                            height: sy(56),
                            decoration: const BoxDecoration(
                              color: _ink,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: sy(36),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
