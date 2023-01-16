import 'package:flutter/material.dart';
import 'package:flutter_giraffe_app/common/colors/colors.dart';

InputDecorationTheme inputDecorationTheme() {
  return const InputDecorationTheme(
    // 에러 발생시
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    // 위젯이 활성화 되었을 때
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(GREEN_ACCENT),
      ),
    ),
    // 위젯이 활성화 & 에러
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    ),
  );
}

ElevatedButtonThemeData elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(GREEN_MAIN),
    )
  );
}