import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicles/src/core/utils/helpers/messages.dart';
import 'package:vehicles/src/core/utils/managers/shared_preferences_manager.dart';
import 'package:vehicles/src/features/auth/pages/login_page.dart';
import 'package:vehicles/src/features/vehicle/pages/my_vehicles_page.dart';

import 'src/core/constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token =
      await SharedPreferencesManager.get(SharedPreferencesKeys.token);
  runApp(MyApp(
    isAuthenticated: (token ?? '').isNotEmpty,
  ));
}

class MyApp extends StatelessWidget {
  final bool isAuthenticated;

  const MyApp({super.key, required this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.cupertino,
      title: 'Vehicles',
      debugShowCheckedModeBanner: false,
      translations: Messages(),
      locale: const Locale('ar', 'SY'),
      fallbackLocale: const Locale('ar', 'SY'),
      theme: ThemeData(
        colorScheme: const ColorScheme.highContrastLight(
            primary: AppColors.primary, surfaceTint: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.tajawalTextTheme(),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          iconColor: AppColors.primary,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: AppColors.primary),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.grey)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: Colors.white,
            textStyle:
                GoogleFonts.tajawal(fontSize: 20, fontWeight: FontWeight.bold),
            fixedSize: Size(MediaQuery.of(context).size.width, 55),
          ),
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: AppColors.secondary),
        dialogBackgroundColor: Colors.white,
        dialogTheme: const DialogTheme(
            backgroundColor: Colors.white, surfaceTintColor: Colors.white),
        appBarTheme: const AppBarTheme(
            elevation: 0, centerTitle: true, backgroundColor: Colors.white),
        useMaterial3: true,
      ),
      home: isAuthenticated ? const MyVehiclesPage() : const LoginPage(),
    );
  }
}
