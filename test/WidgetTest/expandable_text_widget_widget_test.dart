import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pawfect/Widgets/ExpandableTextWidget.dart';

void main() {
  testWidgets('ExpandableTextWidget shows truncated text by default',
      (WidgetTester tester) async {
    final String longText =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam volutpat sapien vel eros gravida facilisis. Pellentesque eget eleifend enim, at efficitur risus. Sed posuere eu sapien vel viverra. Suspendisse potenti. Praesent dapibus massa nisi, at pellentesque nulla luctus et. Fusce hendrerit blandit bibendum. Nam eleifend mauris sed turpis commodo rhoncus. Nullam ac sapien imperdiet, luctus nunc id, iaculis odio. Donec feugiat dolor orci, eget feugiat velit hendrerit ut.';

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ExpandableTextWidget(
      Des_text: longText,
    ))));

    final initialTextFinder = find.text(longText.substring(0, 330) + '...');
    expect(initialTextFinder, findsOneWidget);

    final showMoreButtonFinder = find.text('Show more');
    expect(showMoreButtonFinder, findsOneWidget);
  });

  testWidgets(
      'ExpandableTextWidget shows truncated text after tapping "Show less"',
      (WidgetTester tester) async {
    final String longText =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam volutpat sapien vel eros gravida facilisis. Pellentesque eget eleifend enim, at efficitur risus. Sed posuere eu sapien vel viverra. Suspendisse potenti. Praesent dapibus massa nisi, at pellentesque nulla luctus et. Fusce hendrerit blandit bibendum. Nam eleifend mauris sed turpis commodo rhoncus. Nullam ac sapien imperdiet, luctus nunc id, iaculis odio. Donec feugiat dolor orci, eget fe';
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ExpandableTextWidget(
      Des_text: longText,
    ))));

    final showMoreButtonFinder = find.text('Show more');
    expect(showMoreButtonFinder, findsOneWidget);

    await tester.tap(showMoreButtonFinder);
    await tester.pumpAndSettle();

    final showLessButtonFinder = find.text('Show less');
    expect(showLessButtonFinder, findsOneWidget);

    await tester.tap(showLessButtonFinder);
    await tester.pumpAndSettle();

    final truncatedTextFinder = find.text(longText.substring(0, 330) + '...');
    expect(truncatedTextFinder, findsOneWidget);
  });
}
