import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/feed_screen.dart';
import 'package:flutter_instagram_two/screens/profile_screen.dart';

class HomaPage extends StatefulWidget {
  HomaPage({
    Key key,
  }) : super(key: key);

  @override
  _HomaPageState createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {



  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '1'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: '2'),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: '3'),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: '4'),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '5'),
  ];

  int _selectedIndex = 0;

  //static 상수선언, static은 호출 전까지 초기화 되지 않음
  static List<Widget> _screens = [
    FeedScreen(),
    Container(color: Colors.blue,),
    Container(color: Colors.green,),
    Container(color: Colors.yellow,),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
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
