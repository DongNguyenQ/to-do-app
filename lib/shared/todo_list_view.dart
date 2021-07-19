import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:to_do_app/redux/app_state.dart';
import 'package:to_do_app/model/todo_entity.dart';
import 'package:to_do_app/widgets/todo_form_view.dart';

import '../main.dart';
import 'no_data_view.dart';
import 'styles.dart';
import '../widgets/todo_item_view.dart';

class TodoListView extends StatelessWidget {
  final String? title;
  final List<TodoEntity> todos;
  final Function(TodoEntity) onRemoveTodo;
  final Function(String) onAddTodo;
  final void Function(String, {String? content, bool? isCompleted}) onUpdateTodo;
  const TodoListView({
    Key? key, this.title, required this.todos,
    required this.onRemoveTodo, required this.onUpdateTodo, required this.onAddTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: Colors.grey.withOpacity(0.6),
        child: ReduxDevTools(store, stateMaxLines: 10, actionMaxLines: 10,),
      ),
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
              onPressed: () {
                _showTodoForm(context, onAddTodo);
              },
              icon: Icon(Icons.add_outlined)
          )
          // InkWell(
          //   onTap: _onCreateNew,
          //   child: Text('New'),
          // )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: todos.isEmpty
        ? Center(
          child: NoDataView(
            title: "No todo yet, let's add one",
            onClick: () {
              _showTodoForm(context, onAddTodo);
            },
          ),
        )
        : Column(
          children: [
            Styles.STDVertSpacing12,
            Flexible(
              child: ListView.builder(
                itemCount: todos.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TodoItemView(
                    key: ValueKey(todos[index].id),
                    todo: todos[index],
                    onRemove: onRemoveTodo,
                    onUnCheck: onUpdateTodo,
                    onUpdateContent: onUpdateTodo,
                  );
                },
              ),
            ),
            ListTile(
              onTap: () {
                _showTodoForm(context, onAddTodo);
              },
              leading: Icon(Icons.add_outlined),
              title: Text('Add new'),
            )
          ],
        )
      ),
    );
  }

  void _showTodoForm(BuildContext context, Function(String) onFinish) {
    var sheetController = showModalBottomSheet(
        context: context, isScrollControlled: true,
        shape: Styles.BottomModelShape,
        builder: (context){
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: TodoFormView(title: 'New Todo'),
            ),
          );
        }
    );
    sheetController.then((value) {
      if (value != null) {
        onFinish(value);
      }
    });
  }
}
