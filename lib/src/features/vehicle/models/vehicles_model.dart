class VehiclesModel {
  VehiclesModel({
    this.status,
    this.data,
  });

  VehiclesModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Vehicle.fromJson(v));
      });
    }
  }

  String? status;
  List<Vehicle>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Vehicle {
  Vehicle({
    this.id,
    this.vehicleTypeId,
    this.userId,
    this.model,
    this.color,
    this.boardNumber,
    this.vehicleImage,
    this.mechanicImage,
    this.boardImage,
    this.idImage,
    this.delegateImage,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  Vehicle.fromJson(dynamic json) {
    id = json['id'];
    vehicleTypeId = json['vehicle_type_id'];
    userId = json['user_id'];
    model = json['model'];
    color = json['color'];
    boardNumber = json['board_number'];
    vehicleImage = json['vehicle_image'];
    mechanicImage = json['mechanic_image'];
    boardImage = json['board_image'];
    idImage = json['id_image'];
    delegateImage = json['delegate_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
  }

  int? id;
  int? vehicleTypeId;
  int? userId;
  String? model;
  String? color;
  int? boardNumber;
  String? vehicleImage;
  String? mechanicImage;
  String? boardImage;
  String? idImage;
  String? delegateImage;
  String? createdAt;
  String? updatedAt;
  Type? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['vehicle_type_id'] = vehicleTypeId;
    map['user_id'] = userId;
    map['model'] = model;
    map['color'] = color;
    map['board_number'] = boardNumber;
    map['vehicle_image'] = vehicleImage;
    map['mechanic_image'] = mechanicImage;
    map['board_image'] = boardImage;
    map['id_image'] = idImage;
    map['delegate_image'] = delegateImage;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (type != null) {
      map['type'] = type?.toJson();
    }
    return map;
  }
}

class Type {
  Type({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  Type.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
