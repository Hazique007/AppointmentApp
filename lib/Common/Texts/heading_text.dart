import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.buttonTitle='view all',
    this.showActionButton=true,
    this.textcolor,
    this.onPressed,
  });

  final String title,buttonTitle;
  final bool showActionButton;
  final Color? textcolor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.bold)
              .apply(color: textcolor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        if(showActionButton)  TextButton(onPressed: onPressed, child: Text(buttonTitle))



      ],
    );
  }
}