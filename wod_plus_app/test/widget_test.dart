import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wod_plus_app/main.dart';
import 'package:wod_plus_app/screens/home_screen.dart';

void main() {
  testWidgets('shows splash screen for 3 seconds then shows the time',
      (WidgetTester tester) async {
    await tester.pumpWidget(const WodPlusApp());

    expect(find.byType(HomeScreen), findsNothing);
    expect(find.byType(Image), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(HomeScreen), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(HomeScreen), findsOneWidget);
    final timeFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          RegExp(r'^\d{2}:\d{2}:\d{2}$').hasMatch(widget.data ?? ''),
    );
    expect(timeFinder, findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
