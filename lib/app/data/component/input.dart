import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:matdis_edu/app/data/controller/password_controller.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';

class CasualTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String? hint;

  const CasualTextField(
      {super.key, required this.controller, this.icon, this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor:  Colours.font,
      style: GoogleFonts.poppins(fontSize: 16, color:  Colours.font,),
      autofocus: true,
      decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon, color:  Colours.primary500, size: 20,) : null,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colours.font),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          contentPadding: EdgeInsets.all(8.0),
          // Padding inside the text field
          hintText: hint ?? "enter text here",
          hintStyle: GoogleFonts.poppins(fontSize: 16, color:  Colours.font, fontWeight: FontWeight.w300)
      ),
      controller: controller,
    );
  }
}
class CasualTextArea extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String? hint;
  const CasualTextArea({
    super.key, required this.controller, this.icon, this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null, // Membuat TextField otomatis menyesuaikan ukuran berdasarkan teks
      minLines: 3, // Menentukan jumlah baris minimum
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon, color:  Colours.primary500, size: 20,) : null,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colours.font),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          contentPadding: EdgeInsets.all(8.0),
          // Padding inside the text field
          hintText: hint ?? "enter text here",
          hintStyle: GoogleFonts.poppins(fontSize: 16, color:  Colours.font, fontWeight: FontWeight.w300)
      ),
    );
  }
}
class PasswordTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final IconData? icon;
  final String? hint;
  final String? tag;

  PasswordTextField(
      {super.key, this.icon, this.hint, this.tag, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    PasswordController controller = Get.put(
        PasswordController(), tag: tag ?? "pass");

    return Obx(() {
      return TextField(
        cursorColor:  Colours.font,
        obscureText: controller.secure.value,
        autofocus: true,
        style: GoogleFonts.poppins(fontSize: 16, color: Colours.font),
        decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon, color:  Colours.primary500, size: 20,) : null,
            suffixIcon: IconButton(
                onPressed: controller.secure.value
                    ? controller.desecured
                    : controller.secured,
                icon: HeroIcon(
                    controller.secure.value ? HeroIcons.eye : HeroIcons
                        .eyeSlash,
                    size: 20, // Ukuran icon sama dengan prefixIcon
                    color:  Colours.primary500
                )
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:  Colours.font),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            contentPadding: EdgeInsets.all(8.0),
            hintText: hint ?? "enter text here",
            hintStyle: GoogleFonts.poppins(fontSize: 16, color:  Colours.font, fontWeight: FontWeight.w300)
        ),
        controller: textEditingController,
      );
    });
  }
}
