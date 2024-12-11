import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';

class EmptyPages extends StatelessWidget {
  const EmptyPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 200,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SvgPicture.asset('assets/empty_pages.svg', fit: BoxFit.contain,)),
        Text("video tidak tersedia", style: GoogleFonts.poppins(
            color: Colours.font,
            fontWeight: FontWeight.bold,
            fontSize: 24
        ),
        textAlign: TextAlign.center,),
      ],
    );
  }
}
