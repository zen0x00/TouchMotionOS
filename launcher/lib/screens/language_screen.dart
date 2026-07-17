import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../session.dart';
import '../widgets/power_button.dart';
import 'patient_profile_screen.dart';

/// Language selection. Picking a card sets [Session.locale], which switches
/// the whole app's language immediately; Continue moves on to the profile.
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _Language {
  const _Language(this.code, this.name, this.native);

  final String code;
  final String name;
  final String native;
}

class _LanguageScreenState extends State<LanguageScreen> {
  static const _ink = Color(0xFF1C1C1E);
  static const _lavender = Color(0xFFF2E7FA);
  static const _lavenderDeep = Color(0xFFE3CDF6);

  static const _languages = <_Language>[
    _Language('en', 'English', 'English'),
    _Language('te', 'Telugu', 'తెలుగు'),
    _Language('hi', 'Hindi', 'हिन्दी'),
    _Language('ta', 'Tamil', 'தமிழ்'),
    _Language('ml', 'Malayalam', 'മലയാളം'),
    _Language('kn', 'Kannada', 'ಕನ್ನಡ'),
  ];

  String get _selected => Session.locale.value.languageCode;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    double sx(double val) => val * (screenW / 1920.0);
    double sy(double val) => val * (screenH / 1080.0);

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(top: 16, right: 16, child: const PowerButton()),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: sx(1100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.chooseLanguage,
                    style: TextStyle(
                      color: _ink,
                      fontSize: sy(56),
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                  SizedBox(height: sy(12)),
                  Text(
                    l10n.voiceGuideHint,
                    style: TextStyle(
                      color: _ink.withValues(alpha: 0.55),
                      fontSize: sy(24),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: sy(56)),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: sx(32),
                    runSpacing: sy(32),
                    children: [
                      for (final lang in _languages)
                        GestureDetector(
                          onTap: () => setState(
                            () => Session.locale.value = Locale(lang.code),
                          ),
                          child: Container(
                            width: sx(240),
                            height: sy(220),
                            decoration: BoxDecoration(
                              color: _selected == lang.code
                                  ? _lavenderDeep
                                  : _lavender,
                              borderRadius: BorderRadius.circular(sy(24)),
                              border: Border.all(
                                color: _selected == lang.code
                                    ? _ink
                                    : _ink.withValues(alpha: 0.12),
                                width: _selected == lang.code ? 2.2 : 1.3,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  lang.native,
                                  style: TextStyle(
                                    color: _ink,
                                    fontSize: sy(40),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: sy(8)),
                                Text(
                                  lang.name,
                                  style: TextStyle(
                                    color: _ink.withValues(alpha: 0.55),
                                    fontSize: sy(22),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: sy(72)),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const PatientProfileScreen(),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: sx(72),
                        vertical: sy(24),
                      ),
                      decoration: BoxDecoration(
                        color: _ink,
                        borderRadius: BorderRadius.circular(sy(40)),
                      ),
                      child: Text(
                        l10n.continueLabel,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sy(28),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
