import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          right: 0,
          height: 1,
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        Container(
          height: 3,
          width: 60,
          color: Colors.grey[50],
        ),
        Text(
          'OR',
          style:
          TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}