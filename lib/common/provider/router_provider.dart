import 'package:flutter_giraffe_app/common/provider/route_provider.dart';
import 'package:flutter_giraffe_app/user/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    // watch - 값이 변경 될 때마다 다시 빌드
    // read - 최초 한번만 빌드.

    // redirect : navigation 하는 순간 함수 실행
    // refreshListenable : navigation 하지 않아도 화면 전환이 필요한 경우가 있기 때문에.

    return GoRouter(
      routes: ref.read(routeProvider),
      initialLocation: '/splash',
      refreshListenable: ref.read(authProvider),
      // redirect: ref.read(authProvider).redirectLogic,
    );
  },
);
