import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/status_button.dart';

import 'consts.dart';
import 'styles.dart';

class NoDataView extends StatelessWidget {
  final Function onClick;
  final String title;
  const NoDataView({Key? key = noTodoViewKey, required this.onClick, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 80,
          width: 80,
          child: FittedBox(
            child: Icon(Icons.hourglass_empty),
          ),
        ),
        Styles.STDVertSpacing12,
        Styles.STDVertSpacing12,
        Styles.STDVertSpacing12,
        Text(title),
        Styles.STDVertSpacing12,
        Container(
          width: 160,
          child: StatusButton(
            key: noTodoCreateButtonKey,
            title: 'New Todo',
            leading: Icon(Icons.add_outlined, color: Colors.white,),
            onTap: () {
              onClick();
            },
          ),
        ),
      ],
    );
  }
}

