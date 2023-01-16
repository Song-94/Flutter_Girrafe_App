import 'package:flutter/material.dart';
import 'package:flutter_giraffe_app/common/colors/theme.dart';
import 'package:flutter_giraffe_app/common/provider/router_provider.dart';
import 'package:flutter_giraffe_app/user/provider/auth_provider.dart';
import 'package:flutter_giraffe_app/user/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'NotoSans',
        inputDecorationTheme: inputDecorationTheme(),
        elevatedButtonTheme: elevatedButtonThemeData()
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: provider.routerDelegate,
      routeInformationParser: provider.routeInformationParser,
      routeInformationProvider: provider.routeInformationProvider,
    );
  }
}
