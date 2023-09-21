import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vehicles/src/core/constants/api_urls.dart';
import 'package:vehicles/src/core/utils/managers/http_manager.dart';
import 'package:vehicles/src/features/auth/models/auth_model.dart';
import 'package:vehicles/src/features/vehicle/models/vehicle_type_model.dart';
import 'package:vehicles/src/features/vehicle/models/vehicles_model.dart';

class VehicleApis {
  Future<VehiclesModel> myVehicles() async {
    final Response response = await httpManager.request(
      path: pathVehicle,
      method: HttpMethods.get,
    );
    return VehiclesModel.fromJson(json.decode(response.toString()));
  }

  Future<VehicleTypeModel> vehiclesTypes() async {
    final Response response = await httpManager.request(
      path: pathVehicleType,
      method: HttpMethods.get,
    );
    return VehicleTypeModel.fromJson(json.decode(response.toString()));
  }

  Future<AuthModel> addVehicle({
    required int vehicleTypeId,
    required String boardNumber,
    required String model,
    required String color,
    required List<String> images,
  }) async {
    final Response response = await httpManager.request(
      path: pathVehicle,
      method: HttpMethods.post,
      isFormData: true,
      params: {
        "vehicle_type_id": vehicleTypeId,
        "board_number": boardNumber,
        "model": model,
        "color": color,
        "vehicle_image": await MultipartFile.fromFile(images[0]),
        "board_image": await MultipartFile.fromFile(images[1]),
        "id_image": await MultipartFile.fromFile(images[1]),
        "mechanic_image": await MultipartFile.fromFile(images[1]),
        "delegate_image": await MultipartFile.fromFile(images[1]),
      },
    );
    return AuthModel.fromJson(json.decode(response.toString()));
  }
}
