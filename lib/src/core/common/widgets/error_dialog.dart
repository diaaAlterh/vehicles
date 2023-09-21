import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialog extends StatelessWidget {
  final String error;

  const ErrorDialog({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('error'.tr),
      content: Text(error),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('ok'.tr),
        ),
      ],
    );
  }
}
