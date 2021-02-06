import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/common_size.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(common_gap),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: common_l_gap,
            ),
            Image.asset('assets/images/insta_text_logo.png'),
            TextFormField(
              controller: _emailController,
              decoration: _textInputDecor('Email'),
              validator: (text){
                if(text.isNotEmpty && text.contains('@')){
                  return null;
                } else {
                  return('정확한 이메일 주소를 입력해 주세요');
                }
              },
            ),
            SizedBox(
              height: common_xs_gap,
            ),
            TextFormField(
              controller: _pwController,
              decoration: _textInputDecor('Password'),
              validator: (text){
                if(text.isNotEmpty && text.length > 5){
                  return null;
                } else {
                  return('정확한 password를 입력해 주세요');
                }
              },
            ),
            SizedBox(
              height: common_xs_gap,
            ),
            TextFormField(
              controller: _cpwController,
              decoration: _textInputDecor('Confirm Password'),
              validator: (text){
                if(text.isNotEmpty && _pwController.text == text){
                  return null;
                } else {
                  return('password가 일치하지 않습니다.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _textInputDecor(String hint) {
    return InputDecoration(
                hintText: hint,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[200],
                  ),
                  borderRadius: BorderRadius.circular(common_s_gap),
                ),
                filled: true,
                fillColor: Colors.grey[100]);
  }
}
