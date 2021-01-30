import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/common_size.dart';
import 'package:flutter_instagram_two/widgets/rounded_Avatar.dart';

class Comment extends StatelessWidget {
  final bool showImage;
  final String username;
  final String text;
  final DateTime dateTime;
  const Comment({
    Key key, this.showImage=true, @required this.username, @required this.text, this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(showImage)
          RoundedAvatar(size: 24),
        if(showImage)
          SizedBox(
            width: common_xxs_gap,
          ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    TextSpan(text: '  '),
                    TextSpan(
                      text: text,
                      style: TextStyle(color: Colors.black87),
                    )
                  ],
                )),
            if(dateTime != null)
              Text(
                dateTime.toIso8601String(),
                style: TextStyle(fontSize: 10, color: Colors.grey[500]),
              )
          ],
        ),
      ],
    );
  }
}