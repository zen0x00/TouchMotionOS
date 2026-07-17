/// Languages the launcher UI (and voice guide) supports. Shared by the
/// standalone language screen and the settings page picker.
class AppLanguage {
  const AppLanguage(this.code, this.name, this.native);

  final String code;
  final String name;
  final String native;
}

const appLanguages = <AppLanguage>[
  AppLanguage('en', 'English', 'English'),
  AppLanguage('te', 'Telugu', 'తెలుగు'),
  AppLanguage('hi', 'Hindi', 'हिन्दी'),
  AppLanguage('ta', 'Tamil', 'தமிழ்'),
  AppLanguage('ml', 'Malayalam', 'മലയാളം'),
  AppLanguage('kn', 'Kannada', 'ಕನ್ನಡ'),
];
