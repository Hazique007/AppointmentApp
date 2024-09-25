import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/Constants/size.dart';

class MyRoundedContainer extends StatelessWidget {
   MyRoundedContainer({
    super.key,
     required this.title,
    required this.subtitle,
    required this.btntext,
    required this.cardcolor,
    required this.titlecolor,
    required this.btntextcolor,
     this.onTap,


  });

  final String title,subtitle,btntext;
  final Color cardcolor,titlecolor,btntextcolor;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MySize.cardRadiusLg,),
          color:cardcolor
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: GoogleFonts.montserrat(color: titlecolor,fontWeight: FontWeight.bold),),
            SizedBox(height: MySize.spaceBtwItems/2,),
            Text(subtitle,style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.w500),),
            SizedBox(height: MySize.spaceBtwItems,),

            InkWell(
              onTap:onTap ,
              child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text(btntext,style: GoogleFonts.montserrat(color:btntextcolor,fontWeight: FontWeight.bold,fontSize: 12),)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MySize.cardRadiusSm,),color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}