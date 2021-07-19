import 'package:flutter/material.dart';

import 'shared/consts.dart';
import 'views/completed_todo_screen.dart';
import 'views/home_screen.dart';
import 'views/uncompleted_todo_screen.dart';

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({Key? key}) : super(key: key);

  @override
  _MainNavigationWrapperState createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {

  int _currentIndex = 0;
  final List<Widget> pages = [
    HomeScreen(key: screenHomeKey),
    CompletedTodoScreen(key: screenCompletedKey),
    UnCompleteTodoScreen(key: screenUnCompletedHomeKey)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.request_page_outlined, key: bottomNavHomeKey),
              label: 'All'
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.check_circle, key: bottomNavCompletedKey),
              label: 'Done'
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.check_circle_outline, key: bottomNavUnCompletedKey),
              label: 'Un-Done'
          ),
        ],
      ),
    );
  }
}
