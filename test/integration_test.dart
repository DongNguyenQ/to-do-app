import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:redux/redux.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/redux/actions.dart';
import 'package:to_do_app/redux/app_state.dart';
import 'package:to_do_app/redux/config.dart';
import 'package:to_do_app/redux/middleware.dart';
import 'package:to_do_app/redux/reducers.dart';
import 'package:to_do_app/shared/consts.dart';
import 'package:to_do_app/widgets/no_data_view.dart';


// Note : For best accuracy, run each test separately, comment another tests
// and just test the one u want, each time 1 test. README
Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Check start app show nodata, then insert data, '
      'verify nodata view gone and data show up',
          (WidgetTester tester) async {
    final store = await ReduxConfig().getStore();

    await tester.pumpWidget(MyApp(store: store));

    expect(find.byType(NoDataView), findsOneWidget);

    final todo1 = 'content1';
    final todo2 = 'content2';
    await store.dispatch(AddTodoAction(todo1));
    await store.dispatch(AddTodoAction(todo2));
    await tester.pumpAndSettle();

    // expect(find.byKey(noTodoViewKey), findsNothing);
    expect(find.text('content1'), findsOneWidget);
    expect(find.text('content2'), findsOneWidget);
  });

  testWidgets('Test filter different screens, '
      'All : show all todo'
      'Completed : show all completed todo'
      'UnCompleted : show all un-completed todo',
          (WidgetTester tester) async {
        final store = await ReduxConfig().getStore();
        await tester.pumpWidget(MyApp(store: store));

        print('STORE ============================= : ${store.state.todos}');
        expect(find.byType(NoDataView), findsOneWidget);

        final todo1 = 'content1';
        final todo2 = 'content2';
        await store.dispatch(AddTodoAction(todo1));
        await store.dispatch(AddTodoAction(todo2));
        await tester.pumpAndSettle();

        // expect(find.byKey(noTodoViewKey), findsNothing);
        expect(find.text('content1'), findsOneWidget);
        expect(find.text('content2'), findsOneWidget);

        await tester.tap(find.byKey(bottomNavUnCompletedKey));
        await tester.pumpAndSettle();
        expect(find.text('content1'), findsOneWidget);
        expect(find.text('content2'), findsOneWidget);

        // Tap on completed tab -> show no data
        print(' ========= Tap on completed tab -> show no data');
        await tester.tap(find.byKey(bottomNavCompletedKey));
        await tester.pumpAndSettle();
        expect(find.byType(NoDataView), findsOneWidget);

        // Move to all todo page, and tap finish todo content1
        print(' ========= Move to all todo page, and tap finish todo content1');
        await tester.tap(find.byKey(bottomNavHomeKey));
        await tester.pumpAndSettle();
        await tester.tap(find.text('content1'));
        await tester.pumpAndSettle();

        // Back to completed tab -> show todo content
        print(' ========= Back to completed tab -> show todo content');
        await tester.tap(find.byKey(bottomNavCompletedKey));
        await tester.pumpAndSettle();
        expect(find.text('content1'), findsOneWidget);
        expect(find.text('content2'), findsNothing);

        // Move to un complete tab -> show todo content2
        print(' ========= Move to un complete tab -> show todo content2');
        await tester.tap(find.byKey(bottomNavUnCompletedKey));
        await tester.pumpAndSettle();
        expect(find.text('content2'), findsOneWidget);
        expect(find.text('content1'), findsNothing);;
      });

  testWidgets('Test swipe todo to delete. sync on all screen',
          (WidgetTester tester) async {

        final store = await ReduxConfig().getStore();

        print('STORE NEW : ${store.state.todos}');

        await tester.pumpWidget(MyApp(store: store));
        await tester.pumpAndSettle();

        print(' =========== SART PAGE SHOE EMPTY');
        expect(find.byType(NoDataView), findsOneWidget);

        final todo1 = 'content1';
        final todo2 = 'content2';
        final todo3 = 'content3';
        await store.dispatch(AddTodoAction(todo1));
        await store.dispatch(AddTodoAction(todo2));
        await store.dispatch(AddTodoAction(todo3));
        await store.dispatch(UpdateTodoAction(
            store.state.todos.first.id, isCompleted: true
        ));
        await tester.pumpAndSettle();
        print(' =========== DISPATCH ACTION');
        print('STORE AFTER UPDATED : ${store.state.todos}');

        print(' =========== Test visibility of 3 todo');
        expect(find.text('content1'), findsOneWidget);
        expect(find.text('content2'), findsOneWidget);
        expect(find.text('content3'), findsOneWidget);

        print(' =========== Delete todo 2');
        await tester.drag(find.text('content2'), const Offset(500.0, 0.0));
        await tester.pumpAndSettle();
        expect(find.text('content1'), findsOneWidget);
        expect(find.text('content2'), findsNothing);
        expect(find.text('content3'), findsOneWidget);

        print(' =========== ');
        await tester.tap(find.byKey(bottomNavUnCompletedKey));
        await tester.pumpAndSettle();
        expect(find.text('content1'), findsNothing);
        expect(find.text('content2'), findsNothing);
        expect(find.text('content3'), findsOneWidget);

        await tester.tap(find.byKey(bottomNavCompletedKey));
        await tester.pumpAndSettle();
        expect(find.text('content1'), findsOneWidget);
        expect(find.text('content2'), findsNothing);
        expect(find.text('content3'), findsNothing);
      });
}