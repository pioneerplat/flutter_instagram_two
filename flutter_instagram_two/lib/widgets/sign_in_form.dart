import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/auth_input_decor.dart';
import 'package:flutter_instagram_two/constants/common_size.dart';
import 'package:flutter_instagram_two/home_page.dart';
import 'package:flutter_instagram_two/widgets/or_divider.dart';
import 'package:flutter_instagram_two/widgets/sign_up_form.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
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
                decoration: textInputDecor('Email'),
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
                decoration: textInputDecor('Password'),
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

              //Join 버튼
              SizedBox(height: common_s_gap),
              _submitButton(context),
              SizedBox(height: common_s_gap),
              OrDivider(),
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
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
