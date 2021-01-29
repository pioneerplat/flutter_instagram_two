import 'package:flutter/material.dart';

class homaPage extends StatefulWidget {
  homaPage({
    Key key,
  }) : super(key: key);

  @override
  _homaPageState createState() => _homaPageState();
}

class _homaPageState extends State<homaPage> {



  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '1'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: '2'),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: '3'),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: '4'),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '5'),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Container(
            color: Colors.amber,
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onBtmItemClick,
            //선택되었을때 움직이제 않게 고정
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            items: btmNavItems,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black87,
          ),
        ));
  }

  void _onBtmItemClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
