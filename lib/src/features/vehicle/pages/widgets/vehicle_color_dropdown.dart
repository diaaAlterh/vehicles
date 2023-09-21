import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/utils/helpers/input_validation_mixin.dart';
import '../../../../core/constants/images_path.dart';

class VehicleColorDropdown extends StatelessWidget with InputValidationMixin {
  final String? selectedVehicleColor;
  final List<String> vehicleColors;
  final Function(String?) onChanged;

  const VehicleColorDropdown(
      {super.key,
      required this.selectedVehicleColor,
      required this.vehicleColors,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        value: selectedVehicleColor,

        decoration: InputDecoration(
          hintText: 'vehicle_color'.tr,

          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              imageVehicleColor,
              height: 20,
              width: 20,
            ),
          ),
        ),
        validator: (value) {
          if ((value??'').isEmpty) {
            return 'color_validation_error'.tr;
          }
          return null;
        },

        items: vehicleColors
            .map((element) => DropdownMenuItem(
                  value: element,
                  child: Text(element),
                ))
            .toList(),
        onChanged: onChanged);
  }
}
