import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/status_button.dart';
import 'package:to_do_app/shared/styles.dart';
import 'package:to_do_app/model/todo_entity.dart';

import 'decorated_text_field.dart';

class TodoFormView extends StatefulWidget {

  final TodoEntity? updateTodo;
  final String title;

  const TodoFormView({Key? key, this.updateTodo, required this.title}) : super(key: key);

  @override
  _TodoFormViewState createState() => _TodoFormViewState();
}

class _TodoFormViewState extends State<TodoFormView> {

  late final TextEditingController _todoController;
  late bool _isFinishesAction;
  bool _isNew = true;

  @override
  void initState() {
    super.initState();
    _todoController = TextEditingController();
    _isFinishesAction = false;
    if (widget.updateTodo != null) {
      _isNew = false;
      _todoController.text = widget.updateTodo!.content;
    }
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedTextInputField(
            controller: _todoController,
            hint: 'What should we do today ? Swimming, Working, Playing ....',
          ),
          Styles.STDVertSpacing12,
          Styles.STDVertSpacing12,
          SizedBox(
            width: 160,
            child: StatusButton(
              title: 'New',
              leading: Icon(Icons.add_outlined, color: Colors.white,),
              busy: _isFinishesAction,
              onTap: () {
                Navigator.of(context).pop(_todoController.text);
              },
            ),
          )
        ],
    );
  }
}