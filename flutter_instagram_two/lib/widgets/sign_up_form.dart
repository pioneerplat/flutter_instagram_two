import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/common_size.dart';
import 'package:flutter_instagram_two/home_page.dart';

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
    return Scaffold(
      // 키보드가 올라올때 화면에 가려진걸 볼 수 있게 하기위해 Scaffold로 감싸고 resizeToAvoidBottomInset: true
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: common_l_gap,
              ),
              Image.asset('assets/images/insta_text_logo.png'),
              //이메일 입력칸
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
              //비밀번호 입력칸
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
              //비밀번호 확인칸
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
              //Join 버튼
              SizedBox(height: common_s_gap),
              _submitButton(context),
              SizedBox(height: common_s_gap),

              _orDivider(),
              FlatButton.icon(
                  onPressed: () {},
                  textColor: Colors.blue,
                  icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                  label: Text('Login with Facebook'))
            ],
          ),
        ),
      ),
    );
  }

  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
              onPressed: () {
                //_formKey.currentState.validate();
                //form에 있는 각각의 validator들이 전부 null을 반환하면 true가 온다
                //false가 오면 각각의 validator의 else return값을 출력한다
                if (_formKey.currentState.validate()) {
                  print('Validation success!!');
                  //로그인이 성공했을 때 HomePage()로 이동한다
                  //pushReplacement 현재화면을 없애고 이동
                  //push 현재화면을 없애지 않고 뒤로보내고 이동
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
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
            );
  }

  Stack _orDivider() {
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

  InputDecoration _textInputDecor(String hint) {
    return InputDecoration(
        hintText: hint,
        enabledBorder: _activeInputBorder(),
        focusedBorder: _activeInputBorder(),

        //error가 발생해도 폼스타일을 그대로 유지하기위해
        errorBorder: errorInputBorder(),

        //error가 발생한 필드를 클릭하면 보더가 바뀌는데 바뀌는걸 방지하기 위해 같은 스타일을 준다
        focusedErrorBorder: errorInputBorder(),
        filled: true,
        fillColor: Colors.grey[100]);
  }

  OutlineInputBorder errorInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(common_s_gap),
    );
  }

  OutlineInputBorder _activeInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[200],
      ),
      borderRadius: BorderRadius.circular(common_s_gap),
    );
  }
}
