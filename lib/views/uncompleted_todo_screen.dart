import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:to_do_app/redux/app_state.dart';

import '../model/todo_viewmodel.dart';
import '../shared/todo_list_view.dart';

class UnCompleteTodoScreen extends StatelessWidget {
  const UnCompleteTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodoViewModel>(
        converter: (Store<AppState> store) =>
            TodoViewModel.create(store),
        builder: (BuildContext context, TodoViewModel vm) {
          return TodoListView(
            todos: vm.todos.where((element) => !element.isCompleted).toList(),
            onAddTodo: vm.onAddTodo,
            onRemoveTodo: vm.onRemoveTodo,
            onUpdateTodo: vm.onUpdateTodo,
          );
        }
    );
  }
}
