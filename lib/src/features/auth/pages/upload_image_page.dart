import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/common/widgets/loading_widget.dart';
import 'package:vehicles/src/features/auth/logic/auth_controller.dart';
import 'package:vehicles/src/features/auth/pages/widgets/upload_image_widget.dart';
import 'widgets/logo_page_title.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  final AuthController authController = Get.find(tag: 'auth');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.all(20),
          child: Obx(() => authController.isLoading.value
              ? const LoadingWidget()
              : ElevatedButton(
                  onPressed: authController.register,
                  child: Text('next'.tr),
                )),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            LogoPageTitle(title: 'add_personal_image'.tr),
            const SizedBox(height: 8),
            Text(
              'make_image_clear'.tr,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const UploadImageWidget(),
            const SizedBox(
              height: 64,
            )
          ],
        ));
  }
}
