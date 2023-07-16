import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pawfect/Widgets/AppIcon.dart';

void main() {
  testWidgets('AppIcon displays correct icon and colors',
      (WidgetTester tester) async {
    final icon = Icons.person;
    final backgroundColor = Colors.blue;
    final iconColor = Colors.white;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppIcon(
            icon: icon,
            backgroundcolor: backgroundColor,
            iconColor: iconColor,
          ),
        ),
      ),
    );

    final containerFinder = find.byType(Container);
    expect(containerFinder, findsOneWidget);
    final containerWidget = tester.widget<Container>(containerFinder);
    expect(
        containerWidget.decoration,
        BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ));

    final iconFinder = find.byType(Icon);
    expect(iconFinder, findsOneWidget);
    final iconWidget = tester.widget<Icon>(iconFinder);
    expect(iconWidget.icon, icon);
    expect(iconWidget.color, iconColor);
    expect(iconWidget.size, 16.0);
  });
}
