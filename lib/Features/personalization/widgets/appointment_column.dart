import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Colors/my_colors.dart';
import '../../../utils/Constants/size.dart';


class AppointmentColumn extends StatelessWidget {
  const AppointmentColumn({
    super.key,
    required this.selectedDate, required this.title, required this.hintText,
  });
  final String title,hintText;

  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500),),
        SizedBox(height: MySize.spaceBtwItems,),
        Container(
          width: 230,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MySize.cardRadiusLg),
              color: MyColors.grey
          ),
          child:  Center(
              child:Text(hintText,style: GoogleFonts.montserrat(color: Colors.black),)
          ) ,
        ),
      ],
    );
  }
}