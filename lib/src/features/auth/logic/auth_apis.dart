import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vehicles/src/core/constants/api_urls.dart';
import 'package:vehicles/src/core/utils/managers/http_manager.dart';
import 'package:vehicles/src/features/auth/models/auth_model.dart';

class AuthApis {
  Future<AuthModel> login({
    required String phoneNumber,
    required String password,
  }) async {
    final Response response = await httpManager.request(
      path: pathLogin,
      method: HttpMethods.post,
      params: {
        "phone_number": phoneNumber,
        "password": password,
      },
    );
    return AuthModel.fromJson(json.decode(response.toString()));
  }

  Future<AuthModel> register({
    required String fullName,
    required String phoneNumber,
    required String password,
    required String passwordConfirmation,
    required String image,
  }) async {
    final Response response = await httpManager.request(
      path: pathRegister,
      method: HttpMethods.post,
      isFormData: true,
      params: {
        "fullname": fullName,
        "phone_number": phoneNumber,
        "image": await MultipartFile.fromFile(image),
        "password": password,
        "password_confirmation": passwordConfirmation,
      },
    );
    return AuthModel.fromJson(json.decode(response.toString()));
  }

}
