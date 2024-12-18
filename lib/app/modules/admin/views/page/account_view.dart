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
        backgroundColor: Colors.transparent,
        title: Text('Account', style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        ),
        bottom: PreferredSize(preferredSize: Size.fromHeight(2.0), child: Container(height: 2, color: Colours.primary500, margin: EdgeInsets.symmetric(horizontal: 10),)),
      ),
      backgroundColor: Colours.primary500,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AuthDirection.user?.photoURL != null
                          ? NetworkImage(AuthDirection.user!.photoURL!)
                          : Image.asset("assets/blank_profile.png").image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colours.white, // Warna latar belakang
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                    ),
                    alignment: Alignment.center, // Center the text
                    child: Text(
                      "Edit Profile",
                      style: GoogleFonts.poppins(
                        color: Colours.primary500, // Warna teks
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0), // Ganti dengan radius yang diinginkan
                topRight: Radius.circular(16.0), // Ganti dengan radius yang diinginkan
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
              child: Card(
                color: Colors.white,
                elevation: 2,
                shadowColor: Colours.primary500,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                margin: EdgeInsets.zero,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  height: 600,
                  child: Column(
                    children: [
                      ProfileTextField(
                          initialValue: controller.username.value,
                          textEditingController: controller.usernameTextEditingController,
                          enabled: false,
                      ),
                      ProfileTextField(
                          initialValue: controller.email.value,
                          textEditingController: controller.usernameTextEditingController,
                          enabled: false,
                      ),
                      Expanded(
                          child:
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: double.infinity,
                              child: CustomButton(onClick: AuthDirection.logout, text: "Logout"),
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}
class ProfileTextField extends StatelessWidget {
  final String initialValue;
  final bool enabled;
  final TextEditingController textEditingController;

  const ProfileTextField({
    Key? key,
    required this.initialValue,
    this.enabled = true,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: TextField(
          enabled: enabled,
          controller: TextEditingController(text: initialValue),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.all(16),
            suffixIcon: enabled
                ? Icon(Icons.check, color: Colours.primary500)
                : null,
            hintStyle: TextStyle(color: Colours.primary200),
          ),
          style: GoogleFonts.poppins(
            color: Colours.font,
            fontSize: 16
          ),
        ),
      ),
    );
  }
}
