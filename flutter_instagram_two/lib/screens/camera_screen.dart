import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(color: Colors.green,),
          Container(color: Colors.blue,),
          Container(color: Colors.red,),
        ],
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
      });
  }
}
