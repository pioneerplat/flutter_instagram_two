import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/screen_size.dart';
import 'package:flutter_instagram_two/screens/camera_screen.dart';
import 'package:flutter_instagram_two/screens/feed_screen.dart';
import 'package:flutter_instagram_two/screens/profile_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.yellow,
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;
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
    // 3번째 버튼을 클릭했을 때 새로운 창을 띄우고 나머지는 _screens에서 불러온다
    // 새로운 창을 띄우는 방법 push 는 해당창을 없애지 않고 뒤로 보내고 새로운 창을 띄운다
    switch (index) {
      case 2:
        _openCamera();
        break;
      default:
        setState(() {
          _selectedIndex = index;
        });
    }
  }

  void _openCamera() async {
    if (await checkIfPermissionGranted(context))
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CameraScreen()));
    else {
      SnackBar snackbar = SnackBar(
        content: Text('사진, 파일, 마이크 접근 허용 해주셔야 카메라 사용 가능합니다.'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            //스낵바 없애기
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );
      //아래것으로 바뀜
      //Scaffold.of(context).showSnackBar(snackbar);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  // permission들이 허락이 되었는지 체크
  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.camera, Permission.microphone].request();
    bool permitted = true;

    //key와 value를 각각 받아와서 하나라도 허락이 되지않았다면 permitted를 false로 준다
    statuses.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) permitted = false;
    });
    return permitted;
  }
}
