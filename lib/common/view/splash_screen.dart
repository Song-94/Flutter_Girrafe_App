import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_giraffe_app/common/colors/colors.dart';
import 'package:flutter_giraffe_app/common/layout/default_layout.dart';
import 'package:flutter_giraffe_app/user/view/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  static String get routeName => 'splash';

  SplashScreen({
    Key? key,
  }) : super(key: key) {
    print('Make SplashScreen');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: const Color(GREEN_BASE),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/common/splash_screen.svg',
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 3,
            ),
            const SizedBox(height: 48.0),
            SizedBox(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Loading...',
                    textStyle: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                    cursor: '',
                  ),
                ],
                onTap: () {},
                repeatForever: true,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(GREEN_ACCENT),
              ),
              onPressed: () {
                context.pushNamed(LoginScreen.routeName);
              },
              child: const Text('Go Login'),
            ),
          ],
        ),
      ),
    );
  }
}
