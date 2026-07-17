import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../l10n/app_localizations.dart';
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
  final String Function(AppLocalizations) tagline;
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
      tagline: (l10n) => l10n.taglineSkyHopper,
      accent: _lavender,
      artBuilder: (sx, sy) =>
          Image.asset('assets/slide15/slide15.png', fit: BoxFit.cover),
    ),
    _Game(
      id: 'tomoro-catnap',
      title: 'Cat Nap Chase',
      tagline: (l10n) => l10n.taglineCatNap,
      accent: _lavenderDeep,
      artBuilder: (sx, sy) => Padding(
        padding: EdgeInsets.symmetric(horizontal: sx(60), vertical: sy(40)),
        child: SvgPicture.asset('assets/slide1/Cat.svg', fit: BoxFit.contain),
      ),
    ),
    _Game(
      id: 'tomoro-dashlands',
      title: 'Dashlands',
      tagline: (l10n) => l10n.taglineDashlands,
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

  String _greeting(AppLocalizations l10n) {
    if (_now.hour < 12) return l10n.goodMorning;
    if (_now.hour < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            width: 480,
            content: Text(
              AppLocalizations.of(context)!.notInstalled(game.title),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
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
    final l10n = AppLocalizations.of(context)!;

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
                          _greeting(l10n),
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
                          l10n.pickAGame,
                          style: TextStyle(
                            color: _ink.withValues(alpha: 0.55),
                            fontSize: sy(26),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Clock and controls sit on the greeting's first line.
                  Padding(
                    padding: EdgeInsets.only(top: sy(14)),
                    child: Row(
                      children: [
                        Text(
                          _clock,
                          style: TextStyle(
                            color: _ink,
                            fontSize: sy(30),
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(width: sx(36)),
                        _headerButton(
                          tooltip: l10n.contactPhysio,
                          icon: Icons.support_agent_rounded,
                          size: sy(56),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const PhysioScreen(),
                            ),
                          ),
                        ),
                        SizedBox(width: sx(16)),
                        _headerButton(
                          tooltip: l10n.settings,
                          icon: Icons.settings_outlined,
                          size: sy(56),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SettingsScreen(),
                            ),
                          ),
                        ),
                        SizedBox(width: sx(16)),
                        PowerButton(size: sy(56)),
                      ],
                    ),
                  ),
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
                l10n.library,
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
                    Expanded(child: _gameCard(game, l10n, sx, sy)),
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
                    l10n.tapCardToPlay,
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

  Widget _headerButton({
    required String tooltip,
    required IconData icon,
    required double size,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _ink.withValues(alpha: 0.15),
                width: 1.3,
              ),
            ),
            child: Icon(
              icon,
              size: size * 0.5,
              color: _ink.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gameCard(
    _Game game,
    AppLocalizations l10n,
    double Function(double) sx,
    double Function(double) sy,
  ) {
    final launching = _launching == game.id;
    return AnimatedScale(
      scale: launching ? 0.97 : 1.0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sy(28)),
          boxShadow: [
            BoxShadow(
              color: _ink.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: game.accent,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sy(28)),
            side: BorderSide(color: _ink.withValues(alpha: 0.12), width: 1.3),
          ),
          child: InkWell(
            onTap: () => _launchGame(game),
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
                              game.tagline(l10n),
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
      ),
    );
  }
}
