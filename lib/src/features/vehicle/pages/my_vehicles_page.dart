import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicles/src/core/common/widgets/app_bar_widget.dart';
import 'package:vehicles/src/core/common/widgets/loading_widget.dart';
import 'package:vehicles/src/features/vehicle/logic/vehicle_controller.dart';
import 'package:vehicles/src/features/vehicle/pages/add_vehicle_page.dart';
import 'package:vehicles/src/features/vehicle/pages/widgets/vehicle_widget.dart';

class MyVehiclesPage extends StatefulWidget {
  const MyVehiclesPage({super.key});

  @override
  State<MyVehiclesPage> createState() => _MyVehiclesPageState();
}

class _MyVehiclesPageState extends State<MyVehiclesPage> {
  final VehicleController vehicleController =
      Get.put(VehicleController(), tag: 'vehicle');

  @override
  void initState() {
    vehicleController.myVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'my_vehicles'.tr,
        hasBackButton: false,
      ),
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () => Get.to(() => const AddVehiclePage()),
          child: Text('add_vehicle'.tr),
        ),
      ),
      body: Obx(() {
        final isLoading = vehicleController.isLoading.value;
        final vehicles = vehicleController.vehicles;
        final selectedVehicleId = vehicleController.selectedVehicleId.value;
        if (isLoading) {
          return const LoadingWidget();
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    final vehicle = vehicles[index];
                    return VehicleWidget(
                      key: Key(vehicle.id.toString()),
                      vehicle: vehicle,
                      isSelected: vehicle.id == selectedVehicleId,
                      onPressed: () =>
                          vehicleController.selectVehicle(id: vehicle.id ?? 1),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                  itemCount: vehicles.length,
                ),
              ),
              const SizedBox(height: 80),
            ],
          );
        }
      }),
    );
  }
}
