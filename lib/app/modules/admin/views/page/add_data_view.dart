import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

import '../../../../data/component/add_card.dart';

class AddDataView extends GetView {
  const AddDataView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data', style: GoogleFonts.poppins(
          color: Colours.primary500,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          ),
        ),
        bottom: PreferredSize(preferredSize: Size.fromHeight(2.0), child: Container(height: 2, color: Colours.primary500, margin: EdgeInsets.symmetric(horizontal: 10),)),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: AddCard(imgUrl: "assets/upload_video.svg", title: "Tambah Video", onCLick: () => Get.toNamed(Routes.VIDEO_FORM),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: AddCard(imgUrl: "assets/upload_soal.svg", title: "Tambah Latihan Soal",),
          ),
        ],
      )
    );
  }
}


