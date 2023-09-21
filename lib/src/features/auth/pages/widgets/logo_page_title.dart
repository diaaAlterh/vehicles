import 'package:flutter/material.dart';

import '../../../../core/constants/images_path.dart';

class LogoPageTitle extends StatelessWidget {
  final String title;

  const LogoPageTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'logo',
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Image.asset(
              imageLogo,
              height: 60,
              width: 123,
            ),
          ),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
