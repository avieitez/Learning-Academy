import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_academy/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });
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
    expect(find.text('Choose an operation'), findsOneWidget);
    expect(find.byKey(const ValueKey('addition-operation')), findsOneWidget);

    final characters = tester.getRect(
      find.byKey(const ValueKey('operation-characters')),
    );
    final title = tester.getRect(find.byKey(const ValueKey('operation-title')));
    expect(title.top, greaterThanOrEqualTo(characters.bottom));
  });

  testWidgets('settings changes language and mascot', (tester) async {
    await tester.pumpWidget(const LearningAcademyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('settings-button')));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Automatic'), findsNothing);

    await tester.tap(find.text('Español'));
    await tester.pumpAndSettle();
    expect(find.text('Configuración'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('mascot-fox')));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.text('Matemáticas'), findsOneWidget);
    expect(find.text('Números romanos'), findsOneWidget);
    expect(find.text('El reloj'), findsOneWidget);
    expect(find.text('Espacio publicitario'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('selected-mascot')),
        matching: find.text('🦊'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('addition opens a twelve-level map', (tester) async {
    await tester.pumpWidget(const LearningAcademyApp());
    await tester.pumpAndSettle();
    final mathCard = find.byKey(const ValueKey('mathematics-card'));
    await tester.scrollUntilVisible(
      mathCard,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(mathCard);
    await tester.pumpAndSettle();
    final addition = find.byKey(const ValueKey('addition-operation'));
    await tester.scrollUntilVisible(
      addition,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(addition);
    await tester.pumpAndSettle();

    expect(find.text('Level Map'), findsOneWidget);
    expect(find.byKey(const ValueKey('level-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('play-level')), findsOneWidget);
  });

  testWidgets('settings has no overflow in Spanish on a narrow phone', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const LearningAcademyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('settings-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Español'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Acerca de Learning Academy'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Acerca de Learning Academy'), findsOneWidget);
  });
}
