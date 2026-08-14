import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:azab_app/main.dart';

void main() {
  testWidgets('AZAB App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AzabApp());

    // Verify that the app loads without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
