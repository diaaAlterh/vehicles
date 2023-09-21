import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/utils/helpers/input_validation_mixin.dart';
import 'package:vehicles/src/features/auth/logic/auth_controller.dart';
import 'package:vehicles/src/features/auth/pages/upload_image_page.dart';
import 'package:vehicles/src/features/auth/pages/widgets/auth_question.dart';
import 'package:vehicles/src/features/auth/pages/widgets/name_field.dart';
import 'widgets/logo_page_title.dart';
import 'widgets/password_field.dart';
import 'widgets/phone_field.dart';
import 'widgets/scaffold_background_image.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with InputValidationMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPasswordConfirmation =
      TextEditingController();
  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodePhoneNumber = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodePasswordConfirmation = FocusNode();
  bool isPressed = false;
  final AuthController authController = Get.find(tag: 'auth');

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
                LogoPageTitle(title: 'create_account'.tr),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      NameField(
                        controller: controllerName,
                        focusNode: focusNodeName,
                        onFieldSubmitted: (value) {
                          focusNodePhoneNumber.requestFocus();
                        },
                        onChanged: (value) {
                          if (isPressed) {
                            formKey.currentState?.validate();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
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
                        onFieldSubmitted: (value) {
                          focusNodePasswordConfirmation.requestFocus();
                        },
                        onChanged: (value) {
                          if (isPressed) {
                            formKey.currentState?.validate();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      PasswordField(
                        controller: controllerPasswordConfirmation,
                        focusNode: focusNodePasswordConfirmation,
                        isForConfirmation: true,
                        onChanged: (value) {
                          if (isPressed) {
                            formKey.currentState?.validate();
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: register,
                        child: Text('create_account'.tr),
                      ),
                      const SizedBox(height: 20),
                      AuthQuestion(
                        question: 'have_account'.tr,
                        button: 'login'.tr,
                        onPressed: () => Get.back(),
                      )
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

  register() {
    isPressed = true;
    if (formKey.currentState?.validate() ?? false) {
      authController.fillRegisterInfo(
          fullName: controllerName.text,
          phoneNumber: controllerPhoneNumber.text,
          password: controllerPassword.text,
          passwordConfirmation: controllerPasswordConfirmation.text);
      Get.to(() => const UploadImagePage());
    } else {
      HapticFeedback.vibrate();
    }
  }
}
