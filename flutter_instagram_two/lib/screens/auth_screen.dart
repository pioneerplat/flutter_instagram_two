import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/screens/profile_screen.dart';
import 'package:flutter_instagram_two/widgets/fade_stack.dart';
import 'package:flutter_instagram_two/widgets/sign_in_form.dart';
import 'package:flutter_instagram_two/widgets/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  int selectedForm = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          FadeStack(
            selectedForm: selectedForm,
          ),
          Container(
            child: FlatButton(
              onPressed: () {
                setState(() {
                  selectedForm == 0 ? selectedForm = 1 : selectedForm = 0;
                });
              },
              child: Text('go to Sign up'),
            ),
          ),
        ],
      ),
    );
  }
}
