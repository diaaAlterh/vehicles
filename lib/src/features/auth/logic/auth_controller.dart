import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/utils/helpers/general_methods.dart';
import 'package:vehicles/src/core/utils/managers/shared_preferences_manager.dart';
import 'package:vehicles/src/features/auth/logic/auth_apis.dart';
import 'package:vehicles/src/features/auth/models/auth_model.dart';
import 'package:vehicles/src/features/vehicle/pages/my_vehicles_page.dart';

class AuthController extends GetxController {
  final AuthApis _apis = AuthApis();
  Rx<User> user = User().obs;
  RxString image = ''.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  login({
    required String phoneNumber,
    required String password,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      AuthModel authModelResponse = await _apis.login(
        phoneNumber: phoneNumber,
        password: password,
      );
      SharedPreferencesManager.save(
          SharedPreferencesKeys.token, authModelResponse.data?.token ?? '');
      isLoading.value = false;
      Get.off(() => const MyVehiclesPage());
    } on DioException catch (error) {
      isLoading.value = false;
      errorMessage.value = errorParser(error);
    }
  }

  register() async {
    final userData = user.value;
    isLoading.value = true;
    errorMessage.value = '';
    try {
      AuthModel authModelResponse = await _apis.register(
        fullName: userData.fullname ?? '',
        phoneNumber: userData.phoneNumber ?? '',
        image: image.value,
        password: userData.password ?? '',
        passwordConfirmation: userData.passwordConfirmation ?? '',
      );
      SharedPreferencesManager.save(
          SharedPreferencesKeys.token, authModelResponse.data?.token ?? '');
      isLoading.value = false;
    } on DioException catch (error) {
      isLoading.value = false;
      errorMessage.value = errorParser(error);
    }
  }

  fillRegisterInfo({
    required String fullName,
    required String phoneNumber,
    required String password,
    required String passwordConfirmation,
  }) async {
    user(User(
        fullname: fullName,
        phoneNumber: phoneNumber,
        password: password,
        passwordConfirmation: passwordConfirmation));
  }
}
