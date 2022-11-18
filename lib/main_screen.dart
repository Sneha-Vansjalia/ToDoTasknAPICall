import 'package:flutter/material.dart';
import 'package:to_do_task/themedata.dart';
import 'package:to_do_task/todo_task.dart';
import 'package:to_do_task/userdetail_api_call.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  String? title;
  static const List<Widget> _widgetOptions = <Widget>[
    ToDoTask(),
    UserDetailScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: BottomNavigationBar(
            unselectedItemColor: ThemeClass.whiteColor.withOpacity(0.6),
            selectedLabelStyle: const TextStyle(fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            backgroundColor: ThemeClass.orangeColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.view_list_rounded),
                label: 'Daily Task',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: 'User Detail',
              ),
            ],
            currentIndex: _selectedIndex,
            showSelectedLabels: true,
            selectedItemColor: ThemeClass.whiteColor,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
