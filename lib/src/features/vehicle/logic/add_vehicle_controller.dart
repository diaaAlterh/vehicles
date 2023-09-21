import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/utils/helpers/general_methods.dart';
import 'package:vehicles/src/core/utils/managers/shared_preferences_manager.dart';
import 'package:vehicles/src/features/auth/logic/auth_apis.dart';
import 'package:vehicles/src/features/auth/models/auth_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicles/src/features/vehicle/logic/vehicle_apis.dart';
import 'package:vehicles/src/features/vehicle/models/vehicle_type_model.dart';
import 'package:vehicles/src/features/vehicle/models/vehicles_model.dart';

class AddVehicleController extends GetxController {
  final VehicleApis _apis = VehicleApis();
  RxList<VehicleType> vehicleTypes = <VehicleType>[].obs;
  RxList<String> images = <String>[].obs;
  RxInt selectedVehicleTypeId = 0.obs;
  RxString selectedVehicleColor = ''.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  List<String> colors = [
    'أسود',
    'أبيض',
    'أزرق',
    'أحمر',
  ];

  getVehiclesTypes() async {
    isLoading(true);
    errorMessage.value = '';
    try {
      VehicleTypeModel vehicleTypeModel = await _apis.vehiclesTypes();
      vehicleTypes.value = vehicleTypeModel.data ?? [];
      isLoading.value = false;
    } on DioException catch (error) {
      isLoading.value = false;
      errorMessage.value = errorParser(error);
    }
  }

  Future addVehicle({
    required String model,
    required String plateNumber,
  }) async {
    isLoading(true);
    errorMessage.value = '';
    try {
      await _apis.addVehicle(
          vehicleTypeId: selectedVehicleTypeId.value,
          boardNumber: plateNumber,
          model: model,
          color: selectedVehicleColor.value,
          images: images);
      isLoading.value = false;
    } on DioException catch (error) {
      isLoading.value = false;
      errorMessage.value = errorParser(error);
    }
  }

  selectVehicleType({required int id}) {
    selectedVehicleTypeId(id);
  }

  selectVehicleColor({required String color}) {
    selectedVehicleColor(color);
  }
}
