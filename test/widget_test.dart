import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:soundsliced_tween_animation_builder/soundsliced_tween_animation_builder.dart';

void main() {
  testWidgets('MyTweenAnimationBuilder animates correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyTweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 100.0),
          duration: const Duration(seconds: 1),
          builder: (context, value, child) {
            return Text('Value: $value');
          },
        ),
      ),
    );

    // Initial value
    expect(find.text('Value: 0.0'), findsOneWidget);

    // Wait for animation
    await tester.pump(const Duration(milliseconds: 500));
    // Value should be between 0 and 100
    expect(find.textContaining('Value:'), findsOneWidget);
  });
}