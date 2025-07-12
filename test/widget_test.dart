import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gosh_app/main.dart';

void main() {
  testWidgets('App launches and shows splash screen', (WidgetTester tester) async {
    // Load the app
    await tester.pumpWidget(const GoshLiveApp());

    // Verify splash screen shows GOSH LIVE
    expect(find.text('GOSH APP'), findsOneWidget);
  });
}
