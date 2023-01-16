import 'package:flutter_giraffe_app/common/view/home_screen.dart';
import 'package:flutter_giraffe_app/common/view/splash_screen.dart';
import 'package:flutter_giraffe_app/user/view/address_screen.dart';
import 'package:flutter_giraffe_app/user/view/intro_screen.dart';
import 'package:flutter_giraffe_app/user/view/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routeProvider = Provider<List<GoRoute>>(
  (ref) {
    return <GoRoute>[
      GoRoute(
        path: '/',
        name: HomeScreen.routeName,
        builder: (_, __) => HomeScreen(),
      ),
      GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (_, __) => SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        builder: (_, __) => LoginScreen(),
      ),
      GoRoute(
        path: '/intro',
        name: IntroScreen.routeName,
        builder: (_, __) => IntroScreen(),
      ),
      GoRoute(
        path: '/address',
        name: AddressScreen.routeName,
        builder: (_, __) => AddressScreen(),
      ),
    ];
  },
);
