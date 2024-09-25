import 'package:appointmentapp/Common/Texts/heading_text.dart';
import 'package:appointmentapp/Common/appbar.dart';
import 'package:appointmentapp/utils/Colors/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../utils/Constants/size.dart';
import '../../controllers/appointment_controller.dart';
import '../widgets/appointment_column.dart';


class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {

  final AppointmentController appointmentController = Get.put(AppointmentController());

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isAvailable = true;

  List<DateTime> upcomingAppointments =[];// to store confirm appointments


  // Mock staff availability (Simulate an unavailable slot)
  Future<bool> checkStaffAvailability(DateTime date, TimeOfDay time) async {
    // Simulate backend check with a delay
    await Future.delayed(Duration(seconds: 1));

    // For example, make 2 PM unavailable
    if (time.hour == 14) {
      return false;
    }
    return true;
  }


  Future<void>_selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }


  void _confirmAppointment() async {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select both date and time")));
      return;

    }

    DateTime selectedDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );


    bool available = await checkStaffAvailability(selectedDate!, selectedTime!);

    if (available) {

      //Add confirmed to List
      appointmentController.addAppointment(selectedDateTime);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Appointment Confirmed on ${DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime)}")));
      setState(() {
        selectedDate = null;
        selectedTime = null;
      });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected time unavailable, please pick another slot")));
    }
  }

  void _rescheduleAppointment(int index) async {
    DateTime originalAppointment = upcomingAppointments[index];

    // Select new date
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: originalAppointment,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (newDate == null) return; // If no new date selected, return

    // Select new time
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: originalAppointment.hour, minute: originalAppointment.minute),
    );

    if (newTime == null) return; // If no new time selected, return

    // Combine new date and time
    DateTime newDateTime = DateTime(
      newDate.year,
      newDate.month,
      newDate.day,
      newTime.hour,
      newTime.minute,
    );

    bool available = await checkStaffAvailability(newDate, newTime);

    if (available) {
      // Update the specific appointment with the new date and time
      setState(() {
        upcomingAppointments[index] = newDateTime;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
              "Appointment Rescheduled to ${DateFormat('yyyy-MM-dd HH:mm')
                  .format(newDateTime)}")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
              "Selected time unavailable, please pick another slot")));
    }



  }




    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Book Appointment'),showbackArrow: true,
      ),
      body: Padding(padding: EdgeInsets.all(MySize.defaultSpace),
      child: SingleChildScrollView(
        child:
        Column(
          children: [
            //Container

            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MySize.cardRadiusLg),color: MyColors.myYellow
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:

                        AppointmentColumn(selectedDate: selectedDate, title: 'Select Date',
                        hintText:  selectedDate == null
                            ? "No Date Selected"
                            : " ${DateFormat('yyyy-MM-dd').format(selectedDate!)}"


                        ),
                      ),
                      //IconButton
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: IconButton(onPressed: ()=>_selectDate(context), icon: Icon(Iconsax.calendar,size: 30,)),
                      )
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:
                        AppointmentColumn(selectedDate: selectedDate, title: 'Select Time',
                            hintText:  selectedTime == null
                                ? "No Time Selected"
                                : " ${selectedTime!.format(context)}",


                        )
                      ),
                      //IconButton

                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: IconButton(onPressed: ()=>_selectTime(context), icon: Icon(Iconsax.clock,size: 30,)),
                      )
                    ],
                  ),

                  SizedBox(height: MySize.spaceBtwItems,),

                  //Elevated btn

                  SizedBox(
                      width: 280,
                      child: ElevatedButton(onPressed: _confirmAppointment, child: Text('Confirm')))




                ],
              ),
            ),










          ],
        ),
      ),
      ),

    );

  }
}






