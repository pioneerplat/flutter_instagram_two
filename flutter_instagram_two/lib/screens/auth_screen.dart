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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    selectedForm == 0 ? selectedForm = 1 : selectedForm = 0;
                  });
                },
                child: RichText(
                  text: TextSpan(
                      text: (selectedForm == 0)
                          ? 'Already have an account?'
                          : "Don't have an account?",
                      style: TextStyle(color: Colors.grey[500]),
                      children: [
                        TextSpan(text: '  '),
                        TextSpan(
                            text: (selectedForm == 0) ? 'Sign In' : 'Sign Up',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
