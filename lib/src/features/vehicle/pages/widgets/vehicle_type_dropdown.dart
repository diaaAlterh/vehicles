import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/utils/helpers/input_validation_mixin.dart';
import 'package:vehicles/src/features/vehicle/models/vehicle_type_model.dart';

import '../../../../core/constants/images_path.dart';

class VehicleTypeDropdown extends StatelessWidget with InputValidationMixin {
  final int? selectedVehicleTypeId;
  final List<VehicleType> vehicleTypes;
  final Function(int?) onChanged;

  const VehicleTypeDropdown(
      {super.key,
      required this.selectedVehicleTypeId,
      required this.vehicleTypes,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
        value: selectedVehicleTypeId,
        validator: (value) {
          if ((value??0)==0) {
            return 'type_validation_error'.tr;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'vehicle_type'.tr,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              imageVehicleType,
              height: 20,
              width: 20,
            ),
          ),
        ),
        items: vehicleTypes
            .map((element) => DropdownMenuItem(
                  value: element.id,
                  child: Text(element.name ?? ''),
                ))
            .toList(),
        onChanged: onChanged);
  }
}
