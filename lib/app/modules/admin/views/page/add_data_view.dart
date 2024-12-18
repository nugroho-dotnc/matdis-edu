import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:matdis_edu/app/modules/admin/controllers/add_data_controller.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';
import '../../../../data/component/add_card.dart';
class AddDataView extends GetView<AddDataController> {
  const AddDataView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.primary500,
        title: Text('Tambah Data', style: GoogleFonts.poppins(
          color: Colours.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          ),
        ),
        bottom: PreferredSize(preferredSize: Size.fromHeight(2.0), child: Container(height: 2, color: Colours.primary500, margin: EdgeInsets.symmetric(horizontal: 10),)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: AddCard(imgUrl: "assets/upload_video.svg", title: "Tambah Video", onCLick: () => Get.toNamed(Routes.VIDEO_FORM),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: AddCard(imgUrl: "assets/upload_soal.svg", title: "Tambah Latihan Soal", onCLick: () => Get.toNamed(Routes.SOAL_FORM),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: TabBar(
              labelStyle: GoogleFonts.poppins(color: Colours.primary500, fontSize: 16),
              labelColor: Colours.primary500,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colours.primary500,
              controller: controller.tabController,
                tabs: [
                  Tab(text: "Video",),
                  Tab(text: "Soal",),
                ]
            )
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TabBarView(
                  controller: controller.tabController,
                    children: controller.listPage
                ),
              )
          )
        ],
      )
    );
  }
}


