import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/screens/profile_screen.dart';
import 'package:flutter_instagram_two/widgets/sign_in_form.dart';
import 'package:flutter_instagram_two/widgets/sign_up_form.dart';

class FadeStack extends StatefulWidget {
  final int selectedForm;

  const FadeStack({Key key, this.selectedForm}) : super(key: key);

  @override
  _FadeStackState createState() => _FadeStackState();
}

class _FadeStackState extends State<FadeStack>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  List<Widget> forms = [SignUpForm(), SignInForm()];

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: duration);
    _animationController.forward();// 처음에 한번 forward를 해줘야 첫화면이 뜬다 
    super.initState();
  }

  @override //oldWidget과 지금 Widget을 비교하기 위해
  void didUpdateWidget(covariant FadeStack oldWidget) {
    if (widget.selectedForm != oldWidget.selectedForm) {
      _animationController.forward(from: 0.0); // FadeTransition을 실행하라
    }
    super.didUpdateWidget(oldWidget);
  }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: IndexedStack(
        index: widget.selectedForm,
        children: forms,
      ),
    );
  }
}
