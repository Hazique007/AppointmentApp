import 'package:appointmentapp/utils/themes/customTheme/app_bar_theme.dart';
import 'package:flutter/material.dart';

import 'customTheme/elevated_btn_theme.dart';

class AppTheme{
  AppTheme._();//to make it private

static ThemeData LightTheme =ThemeData(
  useMaterial3: true,
  fontFamily: 'Montserrat',
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: MyElevatedBtnTheme.LightElevatedButtonTheme,
  appBarTheme: MyAppBarTheme.LightAppBarTheme,





);


  static ThemeData DarkTheme =ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: MyElevatedBtnTheme.LightElevatedButtonTheme,
    appBarTheme: MyAppBarTheme.DarkAppBarTheme





  );





}