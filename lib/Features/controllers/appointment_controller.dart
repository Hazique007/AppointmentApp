import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppointmentController extends GetxController{

  // A reactive list of upcoming appointments
  var upcomingAppointments = <DateTime>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadAppointments(); // Load appointments when the controller is initialized
  }

  // Load appointments from SharedPreferences
  Future<void> _loadAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('appointments');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      upcomingAppointments.value = jsonList
          .map((item) => DateTime.parse(item as String)) // Convert to DateTime
          .toList();
    }
  }

  // Save appointments to SharedPreferences
  Future<void> _saveAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
    upcomingAppointments.map((appointment) => appointment.toIso8601String()).toList();
    await prefs.setString('appointments', jsonEncode(jsonList));
  }

  // Add a new appointment
  void addAppointment(DateTime dateTime) {
    upcomingAppointments.add(dateTime);
    _saveAppointments();
  }

  // Reschedule an existing appointment
  void rescheduleAppointment(int index, DateTime newDateTime) {
    upcomingAppointments[index] = newDateTime;
    _saveAppointments();
  }



}