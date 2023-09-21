import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/utils/helpers/input_validation_mixin.dart';
import '../../../../core/constants/images_path.dart';

class PhoneField extends StatelessWidget with InputValidationMixin {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  const PhoneField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.phone,
      maxLength: 14,
      validator: (value) {
        if (!isPhoneValid(value)) {
          return 'phone_validation_error'.tr;
        }
        return null;
      },
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: '',
        hintText: 'phone'.tr,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            imagePhone,
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }
}
