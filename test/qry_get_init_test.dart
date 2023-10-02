import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qry/qry_get.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({super.key});

  @override
  State<CustomWidget> createState() => CustomWidgetState();
}

class CustomWidgetState extends State<CustomWidget> with QryGet {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void main() {
  testWidgets(
    'Check initial state of QryGet mixin',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomWidget(),
          ),
        ),
      );

      final CustomWidgetState state = tester.state(find.byType(CustomWidget));

      expect(state.isLoading, true);
      expect(state.isSuccess, false);
      expect(state.hasError, false);
      expect(state.statusCode, null);
      expect(state.errorMessage, null);
      expect(state.data, null);
      expect(state.dataList, null);
    },
  );

  testWidgets(
    'Check if getData function is provided',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomWidget(),
          ),
        ),
      );

      final CustomWidgetState state = tester.state(find.byType(CustomWidget));

      expect(state.getData, isNotNull);
    },
  );

  testWidgets(
    'Check if errorMapping function is provided',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomWidget(),
          ),
        ),
      );

      final CustomWidgetState state = tester.state(find.byType(CustomWidget));

      expect(state.errorMapping, isNotNull);
    },
  );
}
