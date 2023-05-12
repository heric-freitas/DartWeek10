import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

import '../env/env.dart';
import '../storage/storage.dart';
import 'interceptor/auth_interceptor.dart';

class CustomDio extends DioForBrowser {
  late AuthInterceptor _authInterceptor;
  CustomDio(Storage storage)
      : super(
          BaseOptions(
            baseUrl: Env.instance.get('backend_base_url'),
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(minutes: 1),
          ),
        ) {
    interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    _authInterceptor = AuthInterceptor(storage);
  }

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  CustomDio unauth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}