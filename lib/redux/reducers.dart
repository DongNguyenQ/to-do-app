import 'dart:math';

import 'package:redux/redux.dart';
import 'package:to_do_app/redux/app_state.dart';
import 'package:to_do_app/model/todo_entity.dart';
import 'package:to_do_app/redux/actions.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(todos: todoReducer(state.todos, action));
}

Reducer<List<TodoEntity>> todoReducer = combineReducers<List<TodoEntity>>([
  TypedReducer<List<TodoEntity>, MapLoadedAllTodoFromSharePrefsToStateAction>(loadAllTodoReducer),
  TypedReducer<List<TodoEntity>, MapModifiedTodosToStateAction>(mapModifiedListReducer)
]);

List<TodoEntity> mapModifiedListReducer(
    List<TodoEntity> todos, MapModifiedTodosToStateAction action) {
  return List.unmodifiable(action.todos!);
}

List<TodoEntity> loadAllTodoReducer(
    List<TodoEntity> todos, MapLoadedAllTodoFromSharePrefsToStateAction action) {
  if (action.todos != null) {
    return action.todos!;
  }
  return todos;
}