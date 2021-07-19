// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'package:to_do_app/main.dart';
import 'package:to_do_app/redux/app_state.dart';
import 'package:to_do_app/redux/middleware.dart';
import 'package:to_do_app/redux/reducers.dart';
import 'package:to_do_app/shared/consts.dart';

void main() {
  
  testWidgets('Test startup app : Show home screen and have create button', (WidgetTester tester) async {

    final store = DevToolsStore<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
        middleware: appStateMiddleware()
    );
    await tester.pumpWidget(MyApp(store: store));

    expect(find.byKey(screenHomeKey), findsOneWidget);
    expect(find.byKey(screenCompletedKey), findsNothing);
    expect(find.byKey(screenUnCompletedHomeKey), findsNothing);
    expect(find.byKey(noTodoCreateButtonKey), findsOneWidget);
    expect(find.text("No todo yet, let's add one"), findsOneWidget);
  });
}
