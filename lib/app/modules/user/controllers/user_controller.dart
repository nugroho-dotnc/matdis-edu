import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/modules/user/views/pages/user_profile_page.dart';
import 'package:matdis_edu/app/modules/user/views/pages/user_soal_page.dart';
import 'package:matdis_edu/app/modules/user/views/pages/user_video_page.dart';

class UserController extends GetxController with GetSingleTickerProviderStateMixin{
  //TODO: Implement UserController

  late TabController tabController;
  List<Widget> listPage = [
    UserVideoPage(), UserSoalPage(), UserProfilePage()
  ];
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: listPage.length, vsync: this, initialIndex: 0);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
