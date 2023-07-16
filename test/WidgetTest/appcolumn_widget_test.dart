import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pawfect/Widgets/AppColumn.dart';

void main() {
  testWidgets('AppColumn should render with the provided data',
      (WidgetTester tester) async {
    final Name = 'Buddy';
    final breed = 'Golden Retriever';
    final color = 'Golden';
    final price = 5000;

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: AppColumn(
      Name: Name,
      breed: breed,
      color: color,
      price: price,
    ))));

    expect(find.text('Buddy'), findsOneWidget);
    expect(find.text('Breed: Golden Retriever'), findsOneWidget);
    expect(find.text('Price: 5000'), findsOneWidget);
    expect(find.text('Color: Golden'), findsOneWidget);
  });
}
