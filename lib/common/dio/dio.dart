import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>(
  (ref) {
    final dio = Dio();

    dio.interceptors.add(
      CustomInterceptor(),
    );

    return dio;
  },
);

class CustomInterceptor extends Interceptor {
  CustomInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    print('[REQ]\n'
        'method: ${options.method}\n'
        'uri: ${options.uri}\n'
        'headers: ${options.headers}\n');

    return super.onRequest(options, handler); // 요청 보내는 함수.
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    print('[RES]\n'
        'method: ${response.requestOptions.method}\n'
        'uri: ${response.requestOptions.uri}\n'
        'headers: ${response.requestOptions.headers}\n');
    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // 401 에러가 났을 때 (status code)
    // 토큰을 재발급 받는 시도를하고 토큰이 재발급 되면
    // 다시 새로운 토큰으로 요청을 한다.
    print('[ERR]\n'
        'method: ${err.requestOptions.method}\n'
        'uri: ${err.requestOptions.uri}\n'
        'headers: ${err.requestOptions.headers}\n'
        'err.response: ${err.response?.statusCode}');

    super.onError(err, handler);
  }
}
