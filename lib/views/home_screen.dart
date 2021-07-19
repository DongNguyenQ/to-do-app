// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';
// import 'package:to_do_app/model/app_state.dart';
// import 'package:to_do_app/model/todo_entity.dart';
// import 'package:to_do_app/redux/actions.dart';
// import 'package:to_do_app/shared/styles.dart';
//
// import 'shared/no_data_view.dart';
// import 'widgets/todo_form_view.dart';
// import 'widgets/todo_item_view.dart';
//
// class HomeScreen extends StatefulWidget {
//
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Todo List'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               _showCreateTodoForm();
//             },
//             icon: Icon(Icons.add_outlined)
//           )
//           // InkWell(
//           //   onTap: _onCreateNew,
//           //   child: Text('New'),
//           // )
//         ],
//       ),
//       body: SizedBox(
//         width: double.infinity,
//         child: StoreConnector<AppState, _ViewModel>(
//           converter: (Store<AppState> store) => _ViewModel.create(store),
//           builder: (BuildContext context, _ViewModel vm) {
//             if (vm.todos.isEmpty) {
//               return Center(
//                 child: NoDataView(
//                   title: "No todo yet, let's add one",
//                   onClick: () async {
//                     final String? content = await _showCreateTodoForm();
//                     print('CONTENT : ${content ?? 'no content'}');
//                     if (content != null) {
//                       vm.onAddTodo(content);
//                     }
//                   },
//                 ),
//               );
//             }
//             return Column(
//               children: [
//                 Text("Let's finish"),
//                 Styles.STDVertSpacing12,
//                 ...vm.todos.map((e) =>
//                   TodoItemView(
//                     key: ValueKey(e.id),
//                     todo: e,
//                     onRemove: vm.onRemoveTodo,
//                     onUnCheck: vm.onUpdateTodo
//                   )
//                 ),
//                 ListTile(
//                   onTap: () {
//                     _showTodoForm(vm.onAddTodo);
//                   },
//                   leading: Icon(Icons.add_outlined),
//                   title: Text('Add new'),
//                 )
//               ],
//             );
//           }
//         ),
//       ),
//     );
//   }
//
//   void _showTodoForm(Function(String) onFinish) {
//     var sheetController = showModalBottomSheet(
//         context: context, isScrollControlled: true,
//         shape: Styles.BottomModelShape,
//         builder: (context){
//           return Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//               child: TodoFormView(title: 'New Todo'),
//             ),
//           );
//         }
//     );
//     sheetController.then((value) {
//       if (value != null) {
//         onFinish(value);
//       }
//     });
//   }
//
//   Future<String?> _showCreateTodoForm() async {
//     var sheetController = await showModalBottomSheet(
//         context: context, isScrollControlled: true,
//         shape: Styles.BottomModelShape,
//         builder: (context){
//           return Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//               child: TodoFormView(title: 'New Todo'),
//             ),
//           );
//         }
//     );
//     return sheetController;
//   }
// }
//
//
// class _ViewModel {
//   final List<TodoEntity> todos;
//   final Function(String) onAddTodo;
//   final Function(TodoEntity) onRemoveTodo;
//   final Function() onRemoveAllTodo;
//   final Function(String, {String? content, bool? isCompleted}) onUpdateTodo;
//
//   _ViewModel({
//     required this.todos, required this.onAddTodo,
//     required this.onRemoveTodo, required this.onRemoveAllTodo,
//     required this.onUpdateTodo
//   });
//
//   factory _ViewModel.create(Store<AppState> store) {
//     _onAddTodo(String content) {
//       store.dispatch(AddTodoAction(content));
//     }
//
//     _onRemoveTodo(TodoEntity todo) {
//       store.dispatch(RemoveTodoAction(todo));
//     }
//
//     _onRemoveAllTodo() {
//       store.dispatch(RemoveAllTodoAction());
//     }
//
//     _onUpdateTodo(String id, {String? content, bool? isCompleted}) {
//       store.dispatch(UpdateTodoAction(
//           id, content: content, isCompleted: isCompleted));
//     }
//
//     return _ViewModel(
//       todos: store.state.todos,
//       onAddTodo: _onAddTodo,
//       onRemoveTodo: _onRemoveTodo,
//       onRemoveAllTodo: _onRemoveAllTodo,
//       onUpdateTodo: _onUpdateTodo
//     );
//   }
//
// }


import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../redux/app_state.dart';
import '../view_model/todo_viewmodel.dart';
import '../widgets/todo_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodoViewModel>(
        converter: (Store<AppState> store) => TodoViewModel.create(store),
        builder: (BuildContext context, TodoViewModel vm) {
          return TodoListView(
            todos: vm.todos,
            onAddTodo: vm.onAddTodo,
            onRemoveTodo: vm.onRemoveTodo,
            onUpdateTodo: vm.onUpdateTodo,
          );
        }
    );
  }

  // Widget _buildNoData() {
  //   return
  // }
}
