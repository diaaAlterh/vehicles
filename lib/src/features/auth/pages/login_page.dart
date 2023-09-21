import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/common/widgets/error_dialog.dart';
import 'package:vehicles/src/core/common/widgets/loading_widget.dart';

import 'package:vehicles/src/core/utils/helpers/input_validation_mixin.dart';
import 'package:vehicles/src/features/auth/logic/auth_controller.dart';
import 'package:vehicles/src/features/auth/pages/register_page.dart';
import 'package:vehicles/src/features/auth/pages/widgets/auth_question.dart';

import 'widgets/forgot_password_button.dart';
import 'widgets/logo_page_title.dart';
import 'widgets/password_field.dart';
import 'widgets/phone_field.dart';
import 'widgets/scaffold_background_image.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with InputValidationMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  FocusNode focusNodePhoneNumber = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  bool isPressed = false;
  final AuthController authController = Get.put(AuthController(),tag: 'auth');

  @override
  void initState() {
    listenToChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ScaffoldBackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(20),
              children: [
                LogoPageTitle(title: 'login'.tr),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      PhoneField(
                        controller: controllerPhoneNumber,
                        focusNode: focusNodePhoneNumber,
                        onFieldSubmitted: (value) {
                          focusNodePassword.requestFocus();
                        },
                        onChanged: (value) {
                          if (isPressed) {
                            formKey.currentState?.validate();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      PasswordField(
                        controller: controllerPassword,
                        focusNode: focusNodePassword,
                        onChanged: (value) {
                          if (isPressed) {
                            formKey.currentState?.validate();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      const ForgotPasswordButton(),
                      const SizedBox(height: 20),
                      Obx(() => authController.isLoading.value
                          ? const LoadingWidget()
                          : Column(
                              children: [
                                ElevatedButton(
                                  onPressed: login,
                                  child: Text('login'.tr),
                                ),
                                const SizedBox(height: 20),
                                AuthQuestion(
                                  question: 'no_account'.tr,
                                  button: 'create_account'.tr,
                                  onPressed: () =>
                                      Get.to(() => const RegisterPage()),
                                )
                              ],
                            )),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  login() {
    isPressed = true;
    if (formKey.currentState?.validate() ?? false) {
      authController.login(
        phoneNumber: controllerPhoneNumber.text,
        password: controllerPassword.text,
      );
    } else {
      HapticFeedback.vibrate();
    }
  }

  listenToChanges() {
    authController.errorMessage.listen((value) {
      if (value.isNotEmpty) {
        showDialog(
            context: context, builder: (context) => ErrorDialog(error: value));
      }
    });
  }
}
