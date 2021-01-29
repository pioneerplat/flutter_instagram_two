import 'package:flutter/material.dart';

class homaPage extends StatelessWidget {
  const homaPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('cool app'),
          ),
          body: Container(
            color: Colors.amber,
          ),
        ));
  }
}