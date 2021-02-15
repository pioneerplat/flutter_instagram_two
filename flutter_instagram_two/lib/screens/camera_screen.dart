import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/models/camera_state.dart';
import 'package:flutter_instagram_two/widgets/my_gallery.dart';
import 'package:flutter_instagram_two/widgets/take_photo.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {

  CameraState _cameraState = CameraState();
  @override
  _CameraScreenState createState(){
    //Screen을 리턴하기전에 getReadyToTakePhoto를 실행시켜 카메라 찍을 준비를 미리 한다
    _cameraState.getReadyToTakePhoto();
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 1;
  String _title = 'PHOTO';
  PageController _pageController = PageController(initialPage: 1);

  @override
  void dispose() {
    _pageController.dispose();
    widget._cameraState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //MultiProvider를 정의해 두면 child: Scaffold 하위 위젯에서 다 사용할 수 있다.
      providers: [
        //value로 위젯에 정의해둔 CameraState를 가지고 옴
        // 이렇게 하는 이유는 위에서 getReadyToTakePhoto를 먼저 실행해주기 위해서
        ChangeNotifierProvider<CameraState>.value(value: widget._cameraState),

        //CameraState를 바로생성해서 사용하는 방법도 있다
        //ChangeNotifierProvider(create: (context) => CameraState(),)
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: PageView(
          controller: _pageController,
          children: [
            MyGallery(),
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


