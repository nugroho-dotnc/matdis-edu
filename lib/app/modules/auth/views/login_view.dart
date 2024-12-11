import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:matdis_edu/app/data/component/button.dart';
import 'package:matdis_edu/app/data/component/input.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/modules/auth/controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only( left: 16, right: 16, top: 50),
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: 200,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: SvgPicture.asset('assets/login.svg')),
                    Text("Login here!", style: GoogleFonts.poppins(
                      color: Colours.font,
                      fontWeight: FontWeight.bold,
                      fontSize: 32
                    ),),
                    const SizedBox(
                      height: 10,
                    ),
                    CasualTextField(controller: controller.emailController, icon: Icons.alternate_email, hint: "Email",),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordTextField(textEditingController: controller.passwordController, icon: Icons.lock, hint: "Password",),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(child: CustomButton(onClick: controller.login, text: "Login")),
                      ],
                    )
              ],
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 20),
            //     child: Obx(() {
            //       return ElevatedButton(
            //           onPressed: () {
            //             controller.flipCard();
            //           },
            //           style: ElevatedButton.styleFrom(
            //               backgroundColor: Colors.white
            //           ),
            //           child: Text(controller.pageState.value == 0
            //               ? "Don't Have Account?"
            //               : "Already have an account?", style: GoogleFonts.poppins(
            //               color: Colours.font
            //           ),));
            //     }),
            //   ),
            // )
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return Container(
          margin: const EdgeInsets.only(bottom: 20, left: 60, right: 60),
          child: ElevatedButton(
              onPressed: () {
                controller.flipCard();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white
              ),
              child: Text(controller.pageState.value == 0
                  ? "Don't Have Account?"
                  : "Already have an account?", style: GoogleFonts.poppins(
                  color: Colours.font
              ),)),
        );
      }),
    );
  }
}
