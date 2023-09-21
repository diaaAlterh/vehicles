import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/constants/images_path.dart';
import 'package:vehicles/src/features/vehicle/models/vehicles_model.dart';

import '../../../../core/constants/app_colors.dart';

class VehicleWidget extends StatefulWidget {
  final Vehicle vehicle;
  final bool isSelected;
  final Function() onPressed;

  const VehicleWidget(
      {super.key,
      required this.vehicle,
      required this.isSelected,
      required this.onPressed});

  @override
  State<VehicleWidget> createState() => _VehicleWidgetState();
}

class _VehicleWidgetState extends State<VehicleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              width: 4,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: widget.isSelected ? AppColors.primary : Colors.transparent,
            )),
        child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.vehicle.model ?? ''} ${widget.vehicle.boardNumber ?? ''}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: widget.isSelected
                            ? AppColors.primary
                            : Colors.black),
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFEFF1F0),
                      shape: OvalBorder(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(imageCar),
                    ),
                  )
                ],
              ),
              detailRow(
                  title: 'type'.tr, value: widget.vehicle.type?.name ?? ''),
              detailRow(title: 'color'.tr, value: widget.vehicle.color ?? '')
            ],
          ),
        ),
      ),
    );
  }

  Widget detailRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: widget.isSelected ? AppColors.primary : Colors.black),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: widget.isSelected ? AppColors.primary : Colors.black),
          ),
        ],
      ),
    );
  }
}
