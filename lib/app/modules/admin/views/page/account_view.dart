import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/component/button.dart';
import 'package:matdis_edu/app/data/helper/authDirection.dart';
import 'package:matdis_edu/app/modules/admin/controllers/profile_controller.dart';

import '../../../../data/theme/colours.dart';

class AccountView extends GetView<ProfileController> {
  const AccountView({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Account', style: GoogleFonts.poppins(
          color: Colours.primary500,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        ),
        bottom: PreferredSize(preferredSize: Size.fromHeight(2.0), child: Container(height: 2, color: Colours.primary500, margin: EdgeInsets.symmetric(horizontal: 10),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Membuat lingkaran
                  ),
                  child: CircleAvatar(
                    child:  controller.urlProfileImg.value != ""
                        ? Image.network(
                      controller.urlProfileImg.value,
                      fit: BoxFit.cover, // Pastikan gambar mengisi lingkaran
                    )
                        : Image.asset(
                      "assets/blank_profile.png",
                      fit: BoxFit.cover, // Pastikan gambar mengisi lingkaran
                    ),
                  )
                )
              ],
            ),
            Text(controller.username.value, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: CustomButton(onClick: AuthDirection.logout, text: "Logout"),
      ),
    );
  }
}
