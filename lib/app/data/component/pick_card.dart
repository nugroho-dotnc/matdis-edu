import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';

class PickCard extends StatelessWidget {
  const PickCard({
    super.key,
    required this.text,
    required this.onClick,
  });

  final String text;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 200,
        padding: EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colours.primary100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              color: Colours.primary500,
              size: 40,
            ),
            SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colours.primary500),
            ),
          ],
        ),
      ),
    );
  }
}