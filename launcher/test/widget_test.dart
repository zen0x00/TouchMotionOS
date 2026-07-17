import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:tomoro_launcher/screens/home_screen.dart';

void main() {
  testWidgets('home screen shows library with game cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.pump();

    expect(find.text('Library'), findsOneWidget);
    expect(find.text('Sky Hopper'), findsOneWidget);
    expect(find.text('Cat Nap Chase'), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow_rounded), findsNWidgets(2));
  });
}
