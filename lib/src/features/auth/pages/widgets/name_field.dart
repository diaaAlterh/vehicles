import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/utils/helpers/input_validation_mixin.dart';
import '../../../../core/constants/images_path.dart';

class NameField extends StatelessWidget with InputValidationMixin {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  const NameField({
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
      keyboardType: TextInputType.name,
      maxLength: 14,
      validator: (value) {
        if (!isNameValid(value)) {
          return 'name_validation_error'.tr;
        }
        return null;
      },
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: '',
        hintText: 'name'.tr,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            imagePerson,
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }
}
