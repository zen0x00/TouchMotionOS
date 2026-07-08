import 'package:flutter/material.dart';

import 'router/router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TomoroLauncher());
}

class TomoroLauncher extends StatelessWidget {
  const TomoroLauncher({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TOMORO',
      theme: appTheme,
      routerConfig: router,
    );
  }
}
