import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/material_white.dart';
import 'package:flutter_instagram_two/home_page.dart';
import 'package:flutter_instagram_two/screens/auth_screen.dart';

import 'home_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch : Colors.blue),
      home: AuthScreen(),
      //home: HomaPage(),
    );
  }
}


