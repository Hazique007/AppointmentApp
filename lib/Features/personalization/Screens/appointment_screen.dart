import 'package:appointmentapp/Common/Texts/heading_text.dart';
import 'package:appointmentapp/Common/appbar.dart';
import 'package:appointmentapp/Features/personalization/Screens/success_screen.dart';
import 'package:appointmentapp/utils/Colors/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../Common/containers/my_rounded_container.dart';
import '../../../utils/Constants/size.dart';
import '../../controllers/appointment_controller.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final AppointmentController appointmentController = Get.put(AppointmentController());


  void _rescheduleAppointment(BuildContext context, int index) async {
    DateTime originalAppointment = appointmentController.upcomingAppointments[index];

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
      initialTime: TimeOfDay(hour: originalAppointment.hour, minute: originalAppointment.minute),
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

    // Update the appointment
    appointmentController.rescheduleAppointment(index, newDateTime);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Appointment rescheduled to ${DateFormat('yyyy-MM-dd HH:mm').format(newDateTime)}")));
  }

  // Helper method to check if rescheduling is allowed
  bool _canReschedule(DateTime appointmentTime) {
    final DateTime now = DateTime.now();
    final Duration difference = appointmentTime.difference(now);
    return difference.inHours >= 2;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Appointment Section'),
        actions: [
          Icon(Iconsax.notification),

        ],
      ),
      body: Padding(padding: EdgeInsets.all(MySize.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyRoundedContainer(
                    title: 'Online Consultation',
                    subtitle: 'Starting from \$12',
                    cardcolor: MyColors.myBlue,
                    btntext: 'Find Tailor',
                    btntextcolor: Colors.black,
                    titlecolor: Colors.black,
                  ),
          
                  MyRoundedContainer(
                      onTap: ()=> Get.to(()=>SuccessScreen()),
                      title: 'Visit a Tailor Offilne',
                      subtitle: 'Starting from \$20',
                      btntext: 'Appointment',
                      cardcolor: MyColors.myYellow,
                      titlecolor: Colors.black,
                      btntextcolor: Colors.black)
          
          
          
                ],
              ),
              SizedBox(height: MySize.spaceBtwSections,),
              
              //Book appointment
              
              SectionHeading(title: 'Book Your Appointment',showActionButton: false,),
              SizedBox(height: MySize.spaceBtwItems,),
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MySize.cardRadiusSm),color: MyColors.mylightblue
                ),
                child:
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Book Appointment',style: GoogleFonts.montserrat(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(height: 8,),
                      Text('Get a personalised\nTailoring Experience.',style: GoogleFonts.montserrat(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w500),maxLines: 2,),
                      SizedBox(height: MySize.spaceBtwItems,),
                      InkWell(
                        onTap:()=> Get.to(()=>SuccessScreen()),
                        child: Container(
                          width: 200,
                          height: 40,
                          child: Center(child: Text('Book Appointment',style: GoogleFonts.montserrat(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 12),)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(MySize.cardRadiusSm,),color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.spaceBtwSections,),
              
              //Upcoming Appointments

              SectionHeading(title: 'Upcoming Appointments',showActionButton: false,),

              SizedBox(height: MySize.spaceBtwItems,),
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(MySize.borderRadiusLg),color: MyColors.mylightblue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Schedule-',style: GoogleFonts.montserrat(color: Colors.black,fontWeight: FontWeight.bold),),


                    ),
                    //warning
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Iconsax.warning_2,color: Colors.redAccent,),
                        Text('You can update your appointment upto\n 2 hours before the schedule ',style: GoogleFonts.montserrat(fontSize: 10),)
                      ],
                    ),
                    SizedBox(height: 10,),

                    Expanded(
                      child: Obx(()=> ListView.builder(

                            itemCount: appointmentController.upcomingAppointments.length,
                            itemBuilder: (context,index){
                              DateTime appointment = appointmentController.upcomingAppointments[index];
                              bool canReschedule = _canReschedule(appointment);
                              return
                                Card(
                                  child: ListTile(
                                    title: Text(DateFormat('yyyy-MM-dd HH:mm').format(appointment)),
                                    trailing: TextButton(onPressed:
                                        canReschedule? ()=>_rescheduleAppointment(context,index):null
                                        , child: Text('Reschedule',style: GoogleFonts.montserrat(color: canReschedule? Colors.blue : MyColors.black),)),
                                    subtitle: canReschedule? null : Text('Rescheduling unavailable',style: GoogleFonts.montserrat(fontSize: 8,color: Colors.redAccent),),

                                  ),
                                );


                            }),
                      ),
                    ),
                    SizedBox(height: 10,),


                  ],
                ),
              )
              
              

             
          
          
            ],
          ),
        ),

      ),
    );
  }
}


