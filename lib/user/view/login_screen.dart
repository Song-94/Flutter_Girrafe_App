import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_giraffe_app/common/layout/default_layout.dart';
import 'package:flutter_giraffe_app/user/component/login_form.dart';
import 'package:flutter_giraffe_app/user/function/phone_number_formatter.dart';
import 'package:flutter_giraffe_app/user/view/intro_screen.dart';
import 'package:flutter_giraffe_app/common/view/splash_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  static String get routeName => 'login';

  LoginScreen({
    Key? key,
  }) : super(key: key) {
    print('Make LoginScreen');
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbarIcon: const Icon(Icons.face_retouching_natural_sharp),
      title: '로그인 하기',
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      'assets/common/login_security.svg',
                      width: MediaQuery.of(context).size.width / 8,
                      height: MediaQuery.of(context).size.height / 8,
                      fit: BoxFit.fill,
                    ),
                    const Flexible(
                      child: Text('전화번호로 가입합니다.\n'
                          '개인정보는 안전히 보관하며 \n'
                          '외부에 노출되지 않습니다.'),
                    ),
                  ],
                ),
              ),
              const LoginForm(),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(SplashScreen.routeName);
                },
                child: Text('Go Splash'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(IntroScreen.routeName);
                },
                child: Text('Go Intro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
