import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/common_size.dart';
import 'package:flutter_instagram_two/constants/screen_size.dart';
import 'package:flutter_instagram_two/widgets/profile_body.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Duration duration = Duration(milliseconds: 300);
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
          Positioned(
            width: menuWidth,
            top: 0,
            bottom: 0,
            child: AnimatedContainer(
              duration: duration,
              transform: Matrix4.translationValues(menuXPos, 0, 0),
              curve: Curves.fastOutSlowIn,
              child: Container(
                color: Colors.green,
              ),
            ),
          ),

        ],
      ),
    );
  }
}

enum MenuStatus { opened, closed }
