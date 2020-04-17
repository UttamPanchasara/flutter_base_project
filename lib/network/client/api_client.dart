import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutterbase/session/model/session.dart';
import 'package:flutterbase/session/session_manager.dart';

import '../rest_constants.dart';

class ApiClient {
  static final ApiClient _converter = ApiClient._internal();

  static const String REQUIRES_HEADER = "header";
  static const String AUTHORIZATION = "Authorization";

  factory ApiClient() {
    return _converter;
  }

  ApiClient._internal();

  Dio dio() {
    var dio = Dio(
      BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 5000,
        baseUrl: RestConstants.BASE_URL,
      ),
    );

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    dio.interceptors.addAll(
      [
        LogInterceptor(
          error: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
        ),
        InterceptorsWrapper(
          onRequest: (RequestOptions options) async {
            if (options.headers[REQUIRES_HEADER]) {
              //Adding the token to authenticate the request
              Session session = await SessionManager().getSessionPref();
              options.headers
                  .addAll({AUTHORIZATION: 'Bearer ${session.token}'});
            }
            //remove the auxiliary header
            options.headers?.remove(REQUIRES_HEADER);
            return options;
          },
        ),
      ],
    );

    return dio;
  }
}
