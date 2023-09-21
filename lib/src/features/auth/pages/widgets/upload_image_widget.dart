import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:vehicles/src/core/constants/app_colors.dart';
import 'package:vehicles/src/core/utils/helpers/general_methods.dart';

import '../../../../core/constants/images_path.dart';
import '../../logic/auth_controller.dart';

class UploadImageWidget extends StatelessWidget {
  const UploadImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find(tag: 'auth');
    final ImagePicker picker = ImagePicker();

    return Obx(() {
      final image = authController.image.value;
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 64),
          width: 240,
          height: 250,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 240,
                height: 240,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 22,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: image.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.file(
                          File(image),
                          fit: BoxFit.cover,
                        ))
                    : Center(
                        child: Image.asset(
                          imageAddImagePerson,
                          width: 90,
                          height: 110,
                        ),
                      ),
              ),
              Positioned(
                left: 157,
                top: 199,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: AppColors.primary,
                    shape: OvalBorder(),
                    shadows: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 22,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: (authController.isLoading.value == false)
                        ? () async {
                            final file = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (file != null) {
                              final compressed = await compressImage(file.path);
                              authController.image.value = compressed.path;
                            }
                          }
                        : null,
                    child: const Icon(
                      Icons.add_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
