import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/utils/helpers/input_validation_mixin.dart';

import '../../../../core/constants/images_path.dart';
import '../../logic/auth_controller.dart';

class PasswordField extends StatelessWidget with InputValidationMixin {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isForConfirmation;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  const PasswordField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.isForConfirmation = false,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find(tag: 'auth');

    return Obx(() {
      bool isPasswordVisible = (isForConfirmation)
          ? authController.isConfirmPasswordVisible.value
          : authController.isPasswordVisible.value;
      return TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.visiblePassword,
        obscureText: !isPasswordVisible,
        validator: (value) {
          if (!isPasswordValid(value)) {
            return 'password_validation_error'.tr;
          }
          return null;
        },
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        decoration: InputDecoration(
          counterText: '',
          hintText: isForConfirmation ? 'confirm_password'.tr : 'password'.tr,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              imagePassword,
              height: 20,
              width: 20,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              if (isForConfirmation) {
                authController.isConfirmPasswordVisible.value =
                    !isPasswordVisible;
              } else {
                authController.isPasswordVisible.value = !isPasswordVisible;
              }
            },
            icon: Icon(!isPasswordVisible
                ? CupertinoIcons.eye
                : CupertinoIcons.eye_slash),
          ),
        ),
      );
    });
  }
}
