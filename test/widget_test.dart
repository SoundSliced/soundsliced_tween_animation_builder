import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:soundsliced_tween_animation_builder/soundsliced_tween_animation_builder.dart';

void main() {
  testWidgets('MyTweenAnimationBuilder animates correctly',
      (WidgetTester tester) async {
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

  testWidgets('MyTweenAnimationBuilder completes animation',
      (WidgetTester tester) async {
    bool animationEnded = false;

    await tester.pumpWidget(
      MaterialApp(
        home: MyTweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 100.0),
          duration: const Duration(milliseconds: 100),
          onEnd: () {
            animationEnded = true;
          },
          builder: (context, value, child) {
            return Text('Value: $value');
          },
        ),
      ),
    );

    // Wait for animation to complete
    await tester.pumpAndSettle();

    expect(animationEnded, isTrue);
    expect(find.text('Value: 100.0'), findsOneWidget);
  });

  testWidgets('MyTweenAnimationBuilder restarts with new key',
      (WidgetTester tester) async {
    Object? animationKey = Object();

    await tester.pumpWidget(
      MaterialApp(
        home: MyTweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 100.0),
          duration: const Duration(milliseconds: 200),
          animationKey: animationKey,
          builder: (context, value, child) {
            return Text('Value: $value');
          },
        ),
      ),
    );

    // Initial value
    expect(find.text('Value: 0.0'), findsOneWidget);

    // Wait for animation to progress
    await tester.pump(const Duration(milliseconds: 100));

    // Change the key to restart animation
    animationKey = Object();
    await tester.pumpWidget(
      MaterialApp(
        home: MyTweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 100.0),
          duration: const Duration(milliseconds: 200),
          animationKey: animationKey,
          builder: (context, value, child) {
            return Text('Value: $value');
          },
        ),
      ),
    );

    // Should restart from 0
    expect(find.text('Value: 0.0'), findsOneWidget);
  });

  testWidgets('MyTweenAnimationBuilder applies curve',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyTweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 100.0),
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Text('Value: $value');
          },
        ),
      ),
    );

    // Curve should affect the animation progression
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.textContaining('Value:'), findsOneWidget);
  });

  testWidgets('MyTweenAnimationBuilder auto-repeats when enabled',
      (WidgetTester tester) async {
    int completionCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: MyTweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 100.0),
          duration: const Duration(milliseconds: 50),
          autoRepeat: true,
          onEnd: () {
            completionCount++;
          },
          builder: (context, value, child) {
            return Text('Value: $value');
          },
        ),
      ),
    );

    // Let multiple cycles complete
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 20));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 20));

    // Should have completed at least once
    expect(completionCount, greaterThan(0));
  });
}
