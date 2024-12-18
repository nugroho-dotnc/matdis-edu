import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/modules/admin/views/page/sub-page/sub_soal_page.dart';
import 'package:matdis_edu/app/modules/admin/views/page/sub-page/sub_video_page.dart';

class AddDataController extends GetxController with GetSingleTickerProviderStateMixin{
  late TabController tabController;
  List<Widget> listPage = [
    SubVideoPage(), SubSoalPage()
  ];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: listPage.length, vsync: this, initialIndex: 0);
  }
}