import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_giraffe_app/user/model/user_model.dart';
import 'package:flutter_giraffe_app/user/provider/user_provider.dart';

final authProvider = ChangeNotifierProvider<AuthChangeNotifier>(
  (ref) {
    return AuthChangeNotifier(
      ref: ref,
    );
  },
);

class AuthChangeNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;

  AuthChangeNotifier({
    required this.ref,
  }) {
    ref.watch(userProvider);
  }

  void logout() {
    ref.read(userProvider.notifier).logout();
  }

  String? redirectLogic(BuildContext context, GoRouterState state) {
    print('execute redirectLogic');

    return null;

    if (state.location == '/splash') {
      return null;
    }

    if (state.location == '/login') {
      return null;
    }

    final UserModelBase? user = ref.read(userProvider);
    final logginIn = state.location == '/login';

    // 유저 정보가 없는데
    // => null
    // 로그인 중 이면 그대로 로그인 페이지에 두고
    // 만약에 로그인 중이 아니라면 로그인 페이지로 이동.
    if (user == null) {
      return logginIn ? null : '/login';
    }

    // 1. user 가 null 이 아님
    // => UserModel
    // 사용자 정보가 있는 상태면
    // 로그인 중이거나 현재 위치가 SplashScreen 이면
    // 홈으로 이동
    if (user is UserModel) {
      return (logginIn || (state.location == '/splash')) ? '/' : null;
    }

    // UserModelError
    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    return null;
  }
}
