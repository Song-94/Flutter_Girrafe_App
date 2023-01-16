import 'package:flutter/material.dart';
import 'package:flutter_giraffe_app/common/layout/default_layout.dart';

class HomeScreen extends StatelessWidget {
  static String get routeName => 'home';

  HomeScreen({
    Key? key,
  }) : super(key: key) {
    print('Make HomeScreen');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Container(
        color: Colors.blue,
        child: const Text('Home Screen'),
      ),
    );
  }
}
