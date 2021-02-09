import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/common_size.dart';

InputDecoration textInputDecor(String hint) {
  return InputDecoration(
      hintText: hint,
      enabledBorder: activeInputBorder(),
      focusedBorder: activeInputBorder(),

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

OutlineInputBorder activeInputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey[200],
    ),
    borderRadius: BorderRadius.circular(common_s_gap),
  );
}
