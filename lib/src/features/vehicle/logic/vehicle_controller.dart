import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/utils/helpers/general_methods.dart';
import 'package:vehicles/src/core/utils/managers/shared_preferences_manager.dart';
import 'package:vehicles/src/features/auth/logic/auth_apis.dart';
import 'package:vehicles/src/features/auth/models/auth_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicles/src/features/vehicle/logic/vehicle_apis.dart';
import 'package:vehicles/src/features/vehicle/models/vehicle_type_model.dart';
import 'package:vehicles/src/features/vehicle/models/vehicles_model.dart';

class VehicleController extends GetxController {
  final VehicleApis _apis = VehicleApis();
  RxList<Vehicle> vehicles = <Vehicle>[].obs;
  RxList<VehicleType> vehicleTypes = <VehicleType>[].obs;
  RxInt selectedVehicleId = 1.obs;
  RxInt selectedVehicleTypeId = 0.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  myVehicles() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      VehiclesModel vehiclesModel = await _apis.myVehicles();
      vehicles.value = vehiclesModel.data ?? [];
      isLoading.value = false;
    } on DioException catch (error) {
      isLoading.value = false;
      errorMessage.value = errorParser(error);
    }
  }

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

  selectVehicle({required int id}) {
    selectedVehicleId(id);
    HapticFeedback.lightImpact();
  }

  selectVehicleType({required int id}) {
    selectedVehicleTypeId(id);
  }
}
