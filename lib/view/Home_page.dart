import 'package:app/view/ChangePass_Page.dart';
import 'package:app/view/Dashboard_page.dart';
import 'package:app/view/Info_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String routeName = '/Home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  static final List<Widget> _list = <Widget>[
    DashBoardPage(),
    InfoPage(),
    ChangePasswordPage()
  ];
  void onItemTap(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list.elementAt(_index),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Change password')
        ],
        currentIndex: _index,
        selectedItemColor: Color(0xff64abbf),
        onTap: onItemTap,
      ),
    );
  }
}
