import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/modules/admin/views/page/account_view.dart';
import 'package:matdis_edu/app/modules/admin/views/page/add_data_view.dart';
import 'package:matdis_edu/app/modules/admin/views/page/home_view.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

class AdminController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement AdminController

  final count = 0.obs;
  late TabController tabController;
  final List<Widget> tabPage = [
    HomeView(), AddDataView(), AccountView()
  ];
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabPage.length, vsync: this, initialIndex: 0);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  void logout() async {
    try{
      await auth.signOut().then((value) => Get.offAllNamed(Routes.AUTH,));
      Get.snackbar("success", "Logout Berhasil");
    }catch(e){
      Get.snackbar("error", e.toString());
    }
  }
}
