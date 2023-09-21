import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vehicles/src/core/constants/api_urls.dart';
import 'package:vehicles/src/core/utils/managers/shared_preferences_manager.dart';

class HttpManager {
  late final Dio _dio;

  HttpManager() {
    initHttpManager();
  }

  Future<void> initHttpManager() async {
    _dio = Dio();

    _dio.interceptors.addAll([
      _setBaseUrlInterceptor(),
      _logInterceptor(),
    ]);
  }

  Future<Response> request({
    required String path,
    required HttpMethods method,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    headers ??= {
      'Accept': 'application/json',
      'Authorization':
      'Bearer ${await SharedPreferencesManager.get(
          SharedPreferencesKeys.token)}',
    };

    _dio.options.headers.addAll(headers);

    switch (method) {
      case HttpMethods.get:
        return _dio.get(path);
      case HttpMethods.post:
        return _dio.post(path,
            data: isFormData ? FormData.fromMap(params!) : params);
      case HttpMethods.put:
        return _dio.put(path,
            data: isFormData ? FormData.fromMap(params!) : params);
      case HttpMethods.delete:
        return _dio.delete(path, data: params);
      case HttpMethods.patch:
        return _dio.patch(
          path,
          data: isFormData ? FormData.fromMap(params!) : params,
          options: Options(
            headers: headers,
          ),
        );
    }
  }
}

extension HttpManagerImplHelpers on HttpManager {
  InterceptorsWrapper _setBaseUrlInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.baseUrl = baseUrl;

        debugPrint(
          'Call: => BASE: ${options.baseUrl}',
        );

        return handler.next(options);
      },
      onError: (DioException err, handler) async {
        debugPrint(
          'ERROR[${err.response?.statusCode ?? 0}] => PATH: ${err.requestOptions
              .path}',
        );

        return handler.next(err);
      },
    );
  }

  InterceptorsWrapper _logInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        debugPrint(
          'Call: => PATH: ${options.path}',
        );
        debugPrint(
          'Call: => data: ${options.data.toString()}',
        );
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions
              .path}',
        );
        log(
          'RESPONSE[${response.statusCode}] => data: ${response.data
              .toString()}',
        );
        return handler.next(response);
      },
      onError: (DioException err, handler) async {
        debugPrint(
          'ERROR[${err.response?.statusCode ?? 0}] => PATH: ${err.requestOptions
              .path}',
        );
        debugPrint(
          'ERROR[${err.response?.statusMessage ?? 0}] => PATH: ${err
              .requestOptions.path}',
        );

        return handler.next(err);
      },
    );
  }
}

enum HttpMethods { get, post, put, delete, patch }

HttpManager httpManager = HttpManager();
