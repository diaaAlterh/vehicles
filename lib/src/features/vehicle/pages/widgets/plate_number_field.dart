import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/utils/helpers/input_validation_mixin.dart';
import '../../../../core/constants/images_path.dart';

class PlateNumberField extends StatelessWidget with InputValidationMixin {
  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  const PlateNumberField({
    super.key,
    required this.controller,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 10,
      validator: (value) {
        if (!isNameValid(value, length: 6)) {
          return 'plate_validation_error'.tr;
        }
        return null;
      },
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: '',
        hintText: 'plate_number'.tr,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            imagePlateNumber,
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }
}
