import 'package:flutter_test/flutter_test.dart';

import 'package:sushior/main.dart';

void main() {
  testWidgets('Title screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SushiorApp());
    await tester.pump();

    expect(find.text('寿司か寿司じゃないか'), findsOneWidget);
    expect(find.text('スタート'), findsOneWidget);
  });
}
