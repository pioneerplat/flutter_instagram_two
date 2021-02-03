import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/screen_size.dart';
import 'package:flutter_instagram_two/widgets/profile_body.dart';
import 'package:flutter_instagram_two/widgets/profile_side_menu.dart';

//변수가 class 바깥에 지정되어 있으면 static 변수가 되어서 바깥에서 접근 가능하게 된다
//static 변수는 앱이 실행되면서 값이 생성되는것이 아니라 앱이 실행되면서 값이 이미 존재하게 된다
const duration = Duration(milliseconds: 300);

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final menuWidth = size.width/2;

  MenuStatus _menuStatus = MenuStatus.closed;
  double bodyXPos = 0;
  double menuXPos = size.width;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(bodyXPos, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: ProfileBody(
              onMenuChanged: () {
                setState(() {
                  _menuStatus == MenuStatus.opened
                      ? _menuStatus = MenuStatus.closed
                      : _menuStatus = MenuStatus.opened;
                  switch(_menuStatus){
                    case MenuStatus.opened:
                      bodyXPos = -menuWidth;
                      menuXPos = size.width - menuWidth;
                      break;
                    case MenuStatus.closed:
                      bodyXPos = 0;
                      menuXPos = size.width;
                      break;
                  }
                });
              },
            ),
          ),
          //굳이 Positioned 할 필요가 없음 없애줘도 무방하다
          Positioned(
            width: menuWidth,
            top: 0,
            bottom: 0,
            child: AnimatedContainer(
              duration: duration,
              transform: Matrix4.translationValues(menuXPos, 0, 0),
              curve: Curves.fastOutSlowIn,
              child: ProfileSideMenu(menuWidth),
            ),
          ),

        ],
      ),
    );
  }
}

enum MenuStatus { opened, closed }
