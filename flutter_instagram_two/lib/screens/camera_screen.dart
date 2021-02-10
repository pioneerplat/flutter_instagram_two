import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          Container(color: Colors.green,),
          Container(color: Colors.blue,),
          Container(color: Colors.red,),
        ],
        onPageChanged: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 0,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'GALLERY'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'PHOTO'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'VIDEO'),
      ],
        currentIndex: _currentIndex,
        onTap: _onItemTabbed,
      ),
    );
  }

  void _onItemTabbed(index) {
      setState(() {
        _currentIndex = index;
        _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
      });
  }
}
