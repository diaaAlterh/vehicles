import 'package:flutter/material.dart';

import '../../../../core/constants/images_path.dart';

class ScaffoldBackgroundImage extends StatelessWidget {
  const ScaffoldBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: (MediaQuery.of(context).size.width < 500)
          ? Image.asset(
              imageBackground,
              fit: BoxFit.fill,
            )
          : null,
    );
  }
}
