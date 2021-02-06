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
              cursorColor: Colors.black54,
              decoration: _textInputDecor('Email'),
              validator: (text) {
                if (text.isNotEmpty && text.contains('@')) {
                  return null;
                } else {
                  return ('정확한 이메일 주소를 입력해 주세요');
                }
              },
            ),
            SizedBox(
              height: common_xs_gap,
            ),
            TextFormField(
              controller: _pwController,
              cursorColor: Colors.black54,
              //비밀번호 노출 금지
              obscureText: true,
              decoration: _textInputDecor('Password'),
              validator: (text) {
                if (text.isNotEmpty && text.length > 5) {
                  return null;
                } else {
                  return ('정확한 password를 입력해 주세요');
                }
              },
            ),
            SizedBox(
              height: common_xs_gap,
            ),
            TextFormField(
              controller: _cpwController,
              cursorColor: Colors.black54,
              //비밀번호 노출 금지
              obscureText: true,
              decoration: _textInputDecor('Confirm Password'),
              validator: (text) {
                if (text.isNotEmpty && _pwController.text == text) {
                  return null;
                } else {
                  return ('password가 일치하지 않습니다.');
                }
              },
            ),
            FlatButton(
              onPressed: () {
                //_formKey.currentState.validate();
                //form에 있는 각각의 validator들이 전부 null을 반환하면 true가 온다
                //false가 오면 각각의 validator의 else return값을 출력한다
                if(_formKey.currentState.validate()){
                  print('Validation success!!');
                }
              },
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Join',
                style: TextStyle(color: Colors.white),
              ),
            )
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

        //error가 발생해도 폼스타일을 그대로 유지하기위해
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(common_s_gap),
        ),

        //error가 난 필드를 클릭하면 보더가 바뀌는데 바뀌는걸 방지하기 위해 같은 스타일을 준다
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(common_s_gap),
        ),
        filled: true,
        fillColor: Colors.grey[100]);
  }
}
