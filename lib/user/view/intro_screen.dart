import 'package:flutter/material.dart';
import 'package:flutter_giraffe_app/common/colors/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_giraffe_app/common/layout/default_layout.dart';
import 'package:flutter_giraffe_app/user/view/address_screen.dart';

class IntroScreen extends StatefulWidget {
  static String get routeName => 'intro';

  IntroScreen({
    Key? key,
  }) : super(key: key) {
    print('Make IntroScreen');
  }

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    final layoutSize = MediaQuery.of(context).size;
    final bgHeight = layoutSize.height / 3;

    final giraffeWidth = layoutSize.width / 4;
    final giraffeHeight = layoutSize.height / 6;
    final giraffeTop = giraffeHeight - (giraffeHeight / 10);

    final giraffeMoveStart = layoutSize.width / giraffeWidth;
    final giraffeMoveEnd = layoutSize.width - giraffeWidth;

    // print('layout Size'
    //     ' width:${layoutSize.width}'
    //     ' height:${layoutSize.height}');
    //
    // print('giraffe Size'
    //     ' width:$giraffeWidth'
    //     ' height:$giraffeHeight');

    return DefaultLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                '기린 마켓',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(GREEN_ACCENT),
                ),
              ),
              SizedBox(width: 8.0),
              Icon(Icons.insert_emoticon_sharp),
            ],
          ),
          Stack(
            children: [
              SvgPicture.asset(
                'assets/common/intro_screen.svg',
                width: layoutSize.width,
                height: bgHeight,
                fit: BoxFit.fill,
              ),
              StreamBuilder<double>(
                stream: movingPeriodicStream(
                  start: giraffeMoveStart,
                  end: giraffeMoveEnd,
                  move: giraffeMoveEnd / 60,
                ),
                builder: (context, snapshot) {
                  return Positioned(
                    width: giraffeWidth,
                    height: giraffeHeight,
                    left: snapshot.data,
                    top: giraffeTop,
                    child: SvgPicture.asset(
                      'assets/common/intro_giraffe.svg',
                      fit: BoxFit.fill,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            '안녕하세요.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          const Text(
            '우리는 이웃 사촌과 함께 해요. \n내 이웃 사촌은 누구일까요?!',
            style: TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: TextButton(
                onPressed: () {
                  context.pushNamed(AddressScreen.routeName);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(GREEN_ACCENT),
                ),
                child: const Text(
                  '내 동네 설정하고 시작하기',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stream<double> movingPeriodicStream(
      {required double start,
      required double end,
      required double move}) async* {
    double drawPos = start;

    while (true) {
      await Future.delayed(
        const Duration(milliseconds: 300),
      );
      drawPos = drawPos > end ? start : drawPos + move;

      yield drawPos;
    }
  }
}
