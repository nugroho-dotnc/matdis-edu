import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:matdis_edu/app/data/component/button.dart';
import 'package:matdis_edu/app/data/helper/authDirection.dart';
import 'package:matdis_edu/app/modules/admin/controllers/profile_controller.dart';
import 'package:matdis_edu/app/modules/user/controllers/page%20controller/user_profile_controller.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/theme/colours.dart';

class UserProfilePage extends GetView<UserProfileController> {
  const UserProfilePage({super.key});
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
      body: ListView(
        children: [
          Column(
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
          ClipRRect(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Credits",
                      style: GoogleFonts.afacad(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colours.font
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                        height: 2,
                        color: Colours.primary500,
                      ),
                    ),
                    const CreditsCard(path: "assets/pexels.jpg", title: "Pexels", description: "Situs yang saya gunakan untuk mencari gambar", url: 'https://undraw.co/search',),
                    const CreditsCard(path: "assets/undraw.png", title: "Undraw", description: "Situs yang saya gunakan untuk mencari Illustrasi", url: 'https://www.pexels.com/',),
                    const CreditsCard(path: "assets/heroicons.png", title: "Hero Icons", description: "Situs yang saya gunakan untuk mencari icon", url: 'https://fonts.google.com/',),
                    const CreditsCard(path: "assets/google-fonts.jpg", title: "Google Fonts", description: "Package yang saya gunakan untuk mengatur font", url: 'https://heroicons.com/',),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomButton(onClick:()=>QuickAlert.show(
                            context: Get.context!,
                            type: QuickAlertType.warning,
                            text: 'Yakin mau logout sekarang?',
                            showCancelBtn: true,
                            showConfirmBtn: true,
                            confirmBtnText: 'Yes',
                            cancelBtnText: 'No',
                            confirmBtnColor: Colors.red,
                            onConfirmBtnTap: AuthDirection.logout,
                            onCancelBtnTap: ()=>Get.back()
                        ), text: "Logout"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CreditsCard extends StatelessWidget {
  final String url;
  final String path;
  final String title;
  final String description;
  const CreditsCard({
    super.key, required this.path, required this.title, required this.description, required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>launchUrl(Uri.parse(url)),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Card(
            color: Colours.primary100,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(path, fit: BoxFit.cover, height: 100, width: 100, ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${title}", style: GoogleFonts.afacad(fontSize: 20, color: Colours.primary500, fontWeight: FontWeight.w500),),
                      Text("${description}", style: GoogleFonts.afacad(fontSize: 14, color: Colours.primary500, fontWeight: FontWeight.w300),),
                    ],
                  ),
                ),
                Container(
                  width: 30,
                  height: 100,
                  child: HeroIcon(HeroIcons.chevronRight, color: Colours.primary500, size: 32,),
                )
              ],
            )
        ),
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
