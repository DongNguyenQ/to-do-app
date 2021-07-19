import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:to_do_app/redux/app_state.dart';
import 'package:to_do_app/model/todo_entity.dart';
import 'package:to_do_app/redux/actions.dart';
import 'package:to_do_app/redux/config.dart';
import 'package:to_do_app/redux/middleware.dart';
import 'package:to_do_app/redux/reducers.dart';
import 'package:collection/collection.dart';

Future<void> main() async {
  final store = await ReduxConfig().getStore();
  group('Test Reducer', () {
    test('App first start must have 0 todo', () {

      expect(store.state.todos, []);
    });

    test('State have 1 todo when action AddTodoAction was fired', () async {

      await store.dispatch(AddTodoAction('content'));
      expect(store.state.todos.first.content, 'content');
    });

    test('State have 3 todo when action AddTodoAction was fired 4 time and RemoveActionTodo 1 time', () async {
      final todo1 = 'content1';
      final todo2 = 'content2';
      final todo3 = 'content3';
      final todo4 = 'content4';

      await store.dispatch(AddTodoAction(todo1));
      await store.dispatch(AddTodoAction(todo2));
      await store.dispatch(AddTodoAction(todo3));
      await store.dispatch(AddTodoAction(todo4));
      await store.dispatch(RemoveTodoAction(store.state.todos.firstWhere((element) => element.content == todo2)));

      final removedTodo = store.state.todos.firstWhereOrNull((element) => element.content == todo2);
      
      expect(removedTodo, null);
    });

    test('State was updated when user update status of todo via UpdateTodoAction', () async {
      final todo1 = 'content1';
      final todo2 = 'content2';
      final todo3 = 'content3';
      final todo4 = 'content4';

      await store.dispatch(AddTodoAction(todo1));
      await store.dispatch(AddTodoAction(todo2));
      await store.dispatch(AddTodoAction(todo3));
      await store.dispatch(AddTodoAction(todo4));

      final updatingTodo = store.state.todos.firstWhere((element) => element.content == todo2);
      await store.dispatch(UpdateTodoAction(updatingTodo.id, isCompleted: !updatingTodo.isCompleted));
      final updatedTodo = store.state.todos.firstWhere((element) => element.content == todo2);

      expect(updatedTodo.isCompleted, true);

    });

    test('State was updated when user update content of todo via UpdateTodoAction', () async {

      final todo1 = 'content1';

      await store.dispatch(AddTodoAction(todo1));

      final updatingTodo = store.state.todos.firstWhere((element) => element.content == todo1);
      await store.dispatch(UpdateTodoAction(updatingTodo.id, content: 'new content'));
      final updatedTodo = store.state.todos.firstWhere((element) => element.content == 'new content', orElse: null);

      expect(updatedTodo.content, 'new content');

    });

  });
}