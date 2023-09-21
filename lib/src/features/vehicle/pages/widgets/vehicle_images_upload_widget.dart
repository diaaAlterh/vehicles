import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicles/src/core/utils/helpers/general_methods.dart';
import 'package:vehicles/src/features/vehicle/logic/add_vehicle_controller.dart';

import '../../../../core/constants/app_colors.dart';

class VehicleImagesUploadWidget extends StatefulWidget {
  const VehicleImagesUploadWidget({super.key});

  @override
  State<VehicleImagesUploadWidget> createState() =>
      _VehicleImagesUploadWidgetState();
}

class _VehicleImagesUploadWidgetState extends State<VehicleImagesUploadWidget> {
  final AddVehicleController addVehicleController =
      Get.find(tag: 'add_vehicle');

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    border:
                        Border.all(width: 2, color: const Color(0xFFDADADA))),
                child: TextButton(
                  onPressed: uploadImages,
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18))),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFF8F8F8),
                        shape: OvalBorder(),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  addVehicleController.images.length,
                  (index) => Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsetsDirectional.only(start: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              File(addVehicleController.images[index]),
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(
                        height: 25,
                        width: 30,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xAD272739),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                addVehicleController.images.removeAt(index);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  uploadImages() async {
    final selectedFiles = await ImagePicker().pickMultiImage();
    List<XFile> compressedFiles = [];
    for (var element in selectedFiles) {
      final compressedFile = await compressImage(element.path);
      compressedFiles.add(compressedFile);
    }
    addVehicleController.images(compressedFiles.map((e) => e.path).toList());
  }
}
