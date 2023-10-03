import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qry/qry_post.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({super.key});

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> with QryPost {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void main() {
  testWidgets('Check initial state of QryPost', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomWidget(),
        ),
      ),
    );

    final _CustomWidgetState state = tester.state(find.byType(CustomWidget));

    expect(state.isLoading, false);
    expect(state.isSuccess, false);
    expect(state.hasError, false);
    expect(state.statusCode, null);
    expect(state.error, null);
    expect(state.data, null);
    expect(state.dataList, null);
  });

  testWidgets('Check if postData function is provided', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomWidget(),
        ),
      ),
    );

    final _CustomWidgetState state = tester.state(find.byType(CustomWidget));

    expect(state.postData, isNotNull);
  });
}
