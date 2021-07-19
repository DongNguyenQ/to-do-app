import 'dart:math';

import 'package:redux/redux.dart';
import 'package:to_do_app/model/todo_entity.dart';
import 'package:to_do_app/redux/actions.dart';
import 'package:to_do_app/repositories/todo_repository.dart';

import 'app_state.dart';

List<Middleware<AppState>> appStateMiddleware({
    TodoRepository repository = const TodoRepository()
  }) {
  final loadTodos = _loadData(repository);
  final saveAddedTodo = _saveAddedTodo(repository);
  final saveUpdateTodo = _saveUpdateTodo(repository);
  final saveRemovedTodo = _saveRemovedTodo(repository);

  return [
    TypedMiddleware<AppState, AddTodoAction>(saveAddedTodo),
    TypedMiddleware<AppState, RemoveTodoAction>(saveRemovedTodo),
    TypedMiddleware<AppState, UpdateTodoAction>(saveUpdateTodo),
    TypedMiddleware<AppState, GetAllTodoAction>(loadTodos)
  ];
}

Middleware<AppState> _loadData(TodoRepository repository) {
  return(Store<AppState> store, action, NextDispatcher next) {

    repository.loadAppStateFromPrefs().then(
      (value) => store.dispatch(MapLoadedAllTodoFromSharePrefsToStateAction(value?.todos))
    );

    next(action);
  };
}

Middleware<AppState> _saveUpdateTodo(TodoRepository repository) {
  return (Store<AppState> storeWithOldState, action, NextDispatcher next) async {
    final updateAction = action as UpdateTodoAction;

    var list = storeWithOldState.state.todos;
    List<TodoEntity> newTodos = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == action.id) {
        TodoEntity updatedTodo = list[i].copyWith(
          content: updateAction.content,
          isCompleted: updateAction.isCompleted
        );
        newTodos.add(updatedTodo);
      } else {
        newTodos.add(list[i]);
      }
    }

    await repository.saveAppStateToPrefs(AppState(todos: newTodos))
      .then((value) {
        if (value == null) {
          storeWithOldState.dispatch(MapModifiedTodosToStateAction(newTodos));
        }
    });

    next(action);
  };
}

Middleware<AppState> _saveAddedTodo(TodoRepository repository) {
  return(Store<AppState> storeWithOldState, action, NextDispatcher next) async {
    final addAction = action as AddTodoAction;
    final List<TodoEntity> newTodos = List.from(
        storeWithOldState.state.todos)..add(TodoEntity(
        Random().nextInt(1000000).toString(), addAction.content, false));

    await repository.saveAppStateToPrefs(AppState(todos: newTodos))
      .then((value) {
      if (value == null) {
        storeWithOldState.dispatch(MapModifiedTodosToStateAction(newTodos));
      }
    });

    next(action);
  };
}

Middleware<AppState> _saveRemovedTodo(TodoRepository repository) {
  return(Store<AppState> storeWithOldState, action, NextDispatcher next) async {
    final removeAction = action as RemoveTodoAction;
    final List<TodoEntity> newTodos = List.from(storeWithOldState.state.todos)
      ..remove(removeAction.todo);
    await repository.saveAppStateToPrefs(AppState(todos: newTodos))
        .then((value) {
      if (value == null) {
        storeWithOldState.dispatch(MapModifiedTodosToStateAction(newTodos));
      }
    });

    next(action);
  };
}

