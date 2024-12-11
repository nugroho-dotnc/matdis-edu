import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';

class CustomButton extends StatelessWidget {
  final Function() onClick;
  final String text;
  const CustomButton({super.key, required this.onClick, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClick,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colours.primary500,
      ),
        child: Text(text, style: GoogleFonts.poppins(fontSize: 16,color: Colors.white, fontWeight: FontWeight.w500),),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Function() onClick;
  final IconData icons;
  const CustomIconButton({super.key, required this.onClick, required this.icons});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colours.primary500,
      ),
      child: Icon(icons, color: Colours.primary500),
    );
  }
}
