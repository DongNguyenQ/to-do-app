import 'package:redux/redux.dart';
import 'package:to_do_app/redux/actions.dart';

import '../redux/app_state.dart';
import '../model/todo_entity.dart';

class TodoViewModel {
  final List<TodoEntity> todos;
  final Function(String) onAddTodo;
  final Function(TodoEntity) onRemoveTodo;
  final Function() onRemoveAllTodo;
  final List<TodoEntity>? Function() getAllTodo;
  final Function(String, {String? content, bool? isCompleted}) onUpdateTodo;

  TodoViewModel({
    required this.todos, required this.onAddTodo,
    required this.onRemoveTodo, required this.onRemoveAllTodo,
    required this.onUpdateTodo, required this.getAllTodo
  });

  factory TodoViewModel.create(Store<AppState> store) {
    _onAddTodo(String content) {
      print('ACTION >>>>>>>>>>> : VIEWMODEL : ADD TO DO ACTION');
      store.dispatch(AddTodoAction(content));
    }

    _onRemoveTodo(TodoEntity todo) {
      store.dispatch(RemoveTodoAction(todo));
    }

    _onRemoveAllTodo() {
      store.dispatch(RemoveAllTodoAction());
    }

    _onUpdateTodo(String id, {String? content, bool? isCompleted}) {
      store.dispatch(UpdateTodoAction(
          id, content: content, isCompleted: isCompleted));
    }

    _getAllTodo() {
      store.dispatch(GetAllTodoAction());
    }

    return TodoViewModel(
        todos: store.state.todos,
        onAddTodo: _onAddTodo,
        onRemoveTodo: _onRemoveTodo,
        onRemoveAllTodo: _onRemoveAllTodo,
        onUpdateTodo: _onUpdateTodo,
        getAllTodo: _getAllTodo
    );
  }
}
