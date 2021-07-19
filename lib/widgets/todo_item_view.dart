import 'package:flutter/material.dart';
import 'package:to_do_app/model/todo_entity.dart';

class TodoItemView extends StatefulWidget {
  final TodoEntity todo;
  final void Function(TodoEntity)? onRemove;
  final void Function(String, {String? content, bool? isCompleted})? onUnCheck;
  final void Function(String, {String? content, bool? isCompleted})? onUpdateContent;
  const TodoItemView({
    Key? key, required this.todo, this.onRemove, this.onUnCheck, this.onUpdateContent}) : super(key: key);

  @override
  _TodoItemViewState createState() => _TodoItemViewState();
}

class _TodoItemViewState extends State<TodoItemView> {

  bool _isOnEditMode = false;
  TextEditingController? _contentController;
  String? _error;

  @override
  Widget build(BuildContext context) {
    if (_isOnEditMode) {
      _contentController = TextEditingController(text: widget.todo.content);
    }
    return GestureDetector(
      onTap: () {
        print('TAP GESTURE ==============================');
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Dismissible(
        key: widget.key!,
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          checkColor: Colors.white,
          selected: widget.todo.isCompleted,
          activeColor: Colors.black,
          value: widget.todo.isCompleted,
          title: !_isOnEditMode
            ? Text(widget.todo.content)
            : _buildContentEditor(),
          onChanged: (value) {
            if (widget.onUnCheck != null) {
              widget.onUnCheck!(widget.todo.id, isCompleted: !widget.todo.isCompleted);
            }
          },
          secondary: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                if (_isOnEditMode) {
                  widget.onUpdateContent!(widget.todo.id, content: _contentController!.text);
                }
                setState(() {
                  _isOnEditMode = !_isOnEditMode;
                });
                // onUpdateContent(todo.id, )
              }
          ),
        ),
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 10),
          color: Colors.redAccent,
          child: Icon(Icons.delete_outline),
        ),
        onDismissed: (direction) {
          if (widget.onRemove != null) {
            widget.onRemove!(widget.todo);
          }
        },
      ),
    );
  }

  String? _validate(String? content) {
    if (content == null || content.length == 0) {
      return 'Please input information';
    }
    return null;
  }

  _buildContentEditor() {
    return Focus(
      onFocusChange: (focus) {
        print('FOCUS : $focus');
        if (!focus) {
          widget.onUpdateContent!(widget.todo.id, content: _contentController!.text);
          setState(() {
            _isOnEditMode = false;
          });
        }
      },
      child: TextField(
        autofocus: true,
        controller: _contentController,
        onSubmitted: (value) {
          widget.onUpdateContent!(widget.todo.id, content: value);
          setState(() {
            _isOnEditMode = false;
          });
        },
        cursorColor: Colors.black,
        decoration: InputDecoration(
          errorText: _error,
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
