import 'dart:convert';

import 'package:bilibili/log.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class Http {
  late Dio _client;
  static final Http _instance = Http._();

  factory Http() => _instance;

  Http._() {
    _client = Dio(
      BaseOptions(
        connectTimeout: 5000,
        sendTimeout: 5000,
        receiveTimeout: 5000,
      ),
    );
    _client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Log.i({
            "source": 'http',
            "path": options.path,
            "parameters": options.queryParameters,
          });
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode != null) {
            Log.i({
              "source": 'http',
              'statusCode': response.statusCode,
            });
          }
          handler.next(response);
        },
        onError: (DioError e, handler) {
          Log.e({
            "source": 'http',
            'message': e.message,
          });
          return handler.next(e);
        },
      ),
    );
    (_client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) => true;
    };
  }

  Future<void> get(
    String uri,
    Function? success, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (headers != null) {
      _client.options.headers = headers;
    }

    var response = await _client.get(
      uri,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    if (200 == response.statusCode) {
      var responseData = response.data.runtimeType == String
          ? jsonDecode(response.data)
          : response.data;
      if (success != null) {
        success(responseData);
      }
    }
  }

  close() {
    _client.close();
  }
}
