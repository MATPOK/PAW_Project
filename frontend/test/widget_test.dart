import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('Smoke test - apka wstaje', (WidgetTester tester) async {
    await tester.pumpWidget(const Pill4UApp());
  });
}