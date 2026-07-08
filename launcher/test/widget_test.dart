import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tomoro_launcher/main.dart';

void main() {
  testWidgets('renders home page', (WidgetTester tester) async {
    await tester.pumpWidget(const TomoroLauncher());
    await tester.pumpAndSettle();

    expect(find.text('Continue'), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.apps_outlined), findsOneWidget);
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
  });
}
