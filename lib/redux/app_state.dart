import 'package:flutter/cupertino.dart';
import 'package:to_do_app/model/todo_entity.dart';

@immutable
class AppState {
  final List<TodoEntity> todos;

  const AppState({required this.todos});

  AppState.initialState() : todos = List.unmodifiable(<TodoEntity>[]);

  AppState.fromJson(Map json)
      : todos = (json['todos'] as List).map((i) => TodoEntity.fromJson(i)).toList();

  Map toJson() => {'todos': todos};

  @override
  int get hashCode => todos.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other)
        || other is AppState && runtimeType == other.runtimeType
        && todos == other.todos;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}