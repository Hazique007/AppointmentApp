import 'package:appointmentapp/Features/personalization/Screens/appointment_screen.dart';
import 'package:appointmentapp/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,


      theme:AppTheme.LightTheme ,
      home: AppointmentScreen(),
    );
  }
}

