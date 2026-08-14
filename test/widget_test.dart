import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_academy/app/app.dart';

void main() {
  testWidgets('home builds learning areas from reusable cards', (tester) async {
    await tester.pumpWidget(const LearningAcademyApp());
    await tester.pumpAndSettle();

    expect(find.text('Learning Academy'), findsOneWidget);
    expect(find.byKey(const ValueKey('mathematics-card')), findsOneWidget);
    expect(find.byKey(const ValueKey('roman-numbers-card')), findsOneWidget);
    expect(find.byKey(const ValueKey('clock-card')), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('coming-soon-card')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byKey(const ValueKey('coming-soon-card')), findsOneWidget);
    expect(find.text('Ad space'), findsOneWidget);
  });

  testWidgets('mathematics card opens its feature', (tester) async {
    await tester.pumpWidget(const LearningAcademyApp());
    await tester.pumpAndSettle();
    final card = find.byKey(const ValueKey('mathematics-card'));
    await tester.scrollUntilVisible(
      card,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(card);
    await tester.pumpAndSettle();
    expect(find.text('Mathematics'), findsWidgets);
  });

  testWidgets('language selector updates widget text from ARB', (tester) async {
    await tester.pumpWidget(const LearningAcademyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('language-selector')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Español'));
    await tester.pumpAndSettle();

    expect(find.text('Matemáticas'), findsOneWidget);
    expect(find.text('Números romanos'), findsOneWidget);
    expect(find.text('El reloj'), findsOneWidget);
    expect(find.text('Espacio publicitario'), findsOneWidget);
  });
}
