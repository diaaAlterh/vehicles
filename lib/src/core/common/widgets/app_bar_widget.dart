import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;

  const AppBarWidget({super.key, this.title = '', this.hasBackButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:hasBackButton? Center(
        child: Container(
          margin: const EdgeInsetsDirectional.only(start: 8),
          height: 40,
          width: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 2,
                backgroundColor: Colors.white,
                padding: const EdgeInsetsDirectional.only(start: 8),
                foregroundColor: AppColors.primary),
            onPressed: () =>Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ):null,
      title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
