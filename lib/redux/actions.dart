import 'package:to_do_app/model/todo_entity.dart';

class AddTodoAction {
  final String content;
  AddTodoAction(this.content);
  @override
  String toString() {
    return super.toString() + ' | ' + 'Content :' + content;
  }
}

class RemoveTodoAction {
  final TodoEntity todo;
  RemoveTodoAction(this.todo);
  @override
  String toString() {
    return super.toString() + ' | TODO: ${todo.toString()}';
  }
}

class UpdateTodoAction {
  final String id;
  final String? content;
  final bool? isCompleted;

  UpdateTodoAction(this.id, {this.content, this.isCompleted});
  @override
  String toString() {
    return super.toString() + ' | TODO : id ($id) : content ($content) : isCompleted ($isCompleted)';
  }
}

class MapModifiedTodosToStateAction {
  final List<TodoEntity>? todos;

  MapModifiedTodosToStateAction(this.todos);

  @override
  String toString() {
    return super.toString() + ' | TODOS : $todos';
  }
}

class RemoveAllTodoAction {}

class GetAllTodoAction {}

class MapLoadedAllTodoFromSharePrefsToStateAction {
  final List<TodoEntity>? todos;
  MapLoadedAllTodoFromSharePrefsToStateAction(this.todos) {
    print('LOAD ALL TODO ACTION');
  }
  @override
  String toString() {
    return super.toString() + ' | TODO : ${todos.toString()}';
  }
}
