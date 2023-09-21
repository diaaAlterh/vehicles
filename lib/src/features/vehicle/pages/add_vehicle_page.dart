import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/common/widgets/app_bar_widget.dart';
import 'package:vehicles/src/features/vehicle/logic/add_vehicle_controller.dart';
import 'package:vehicles/src/features/vehicle/pages/widgets/plate_number_field.dart';
import 'package:vehicles/src/features/vehicle/pages/widgets/vehicle_color_dropdown.dart';
import 'package:vehicles/src/features/vehicle/pages/widgets/vehicle_images_upload_widget.dart';
import 'package:vehicles/src/features/vehicle/pages/widgets/vehicle_type_dropdown.dart';

import '../../../core/common/widgets/loading_widget.dart';
import '../logic/vehicle_controller.dart';
import 'widgets/vehicle_model_field.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final AddVehicleController addVehicleController =
      Get.put(AddVehicleController(), tag: 'add_vehicle');
  final VehicleController vehicleController = Get.find(tag: 'vehicle');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerModel = TextEditingController();
  TextEditingController controllerPlate = TextEditingController();

  @override
  void initState() {
    addVehicleController.getVehiclesTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'add_vehicle'.tr,
      ),
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(20),
        child: Obx(() => addVehicleController.isLoading.value
            ? const SizedBox.shrink()
            : ElevatedButton(
                onPressed: addVehicle,
                child: Text('add_vehicle'.tr),
              )),
      ),
      body: Obx(() {
        final isLoading = addVehicleController.isLoading.value;
        final vehicleTypes = addVehicleController.vehicleTypes;
        int? selectedVehicleTypeId =
            addVehicleController.selectedVehicleTypeId.value;
        String? selectedVehicleColor =
            addVehicleController.selectedVehicleColor.value;
        if (selectedVehicleTypeId == 0) {
          selectedVehicleTypeId = null;
        }
        if (selectedVehicleColor.isEmpty) {
          selectedVehicleColor = null;
        }
        if (isLoading) {
          return const LoadingWidget();
        } else {
          return Form(
            key: formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(20),
              children: [
                VehicleTypeDropdown(
                    selectedVehicleTypeId: selectedVehicleTypeId,
                    vehicleTypes: vehicleTypes,
                    onChanged: (value) =>
                        addVehicleController.selectVehicleType(id: value ?? 0)),
                const SizedBox(height: 20),
                VehicleModelField(
                  controller: controllerModel,
                ),
                const SizedBox(height: 20),
                VehicleColorDropdown(
                  selectedVehicleColor: selectedVehicleColor,
                  vehicleColors: addVehicleController.colors,
                  onChanged: (value) => addVehicleController.selectVehicleColor(
                      color: value ?? ''),
                ),
                const SizedBox(height: 20),
                PlateNumberField(
                  controller: controllerPlate,
                ),
                const SizedBox(height: 20),
                Text(
                  'vehicle_images'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  'mechanic_image'.tr,
                ),
                Text(
                  'vehicle_image'.tr,
                ),
                Text(
                  'plate_image'.tr,
                ),
                Text(
                  'id_image'.tr,
                ),
                Text(
                  'wakala_image'.tr,
                ),
                const SizedBox(height: 20),
                const VehicleImagesUploadWidget(),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
          );
        }
      }),
    );
  }

  addVehicle() async {
    if ((formKey.currentState?.validate() ?? false) &&
        (addVehicleController.images.length >= 5)) {
      await addVehicleController
          .addVehicle(
              model: controllerModel.text, plateNumber: controllerPlate.text)
          .then((value) {
        if (addVehicleController.errorMessage.value.isEmpty) {
          vehicleController.myVehicles();
          Get.back();
          Get.showSnackbar(GetSnackBar(
            message: 'request_progress'.tr,
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ));
        } else {
          Get.showSnackbar(GetSnackBar(
            message: addVehicleController.errorMessage.value,
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ));
        }
      });
    } else {
      if ((addVehicleController.images.length < 5)) {
        Get.showSnackbar(GetSnackBar(
          message: 'images_validation_error'.tr,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ));
      }
      HapticFeedback.vibrate();
    }
  }

  @override
  void dispose() {
    addVehicleController.dispose();
    super.dispose();
  }
}
