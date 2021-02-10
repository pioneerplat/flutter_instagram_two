import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/widgets/take_photo.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 1;
  String _title = 'PHOTO';
  PageController _pageController = PageController(initialPage: 1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          Container(
            color: Colors.green,
          ),
          TakePhoto(),
          Container(
            color: Colors.red,
          ),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
            switch (_currentIndex) {
              case 0:
                _title = 'GALLERY';
                break;
              case 1:
                _title = 'PHOTO';
                break;
              case 2:
                _title = 'VIDEO';
                break;
            }
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
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
    });
  }
}


