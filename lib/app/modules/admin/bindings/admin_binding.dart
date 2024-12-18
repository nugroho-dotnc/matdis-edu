import 'package:get/get.dart';

import 'package:matdis_edu/app/data/controller/add_card_controller.dart';
import 'package:matdis_edu/app/modules/admin/controllers/add_data_controller.dart';
import 'package:matdis_edu/app/modules/admin/controllers/home_controller.dart';
import 'package:matdis_edu/app/modules/admin/controllers/profile_controller.dart';
import 'package:matdis_edu/app/modules/admin/controllers/sub_soal_controller.dart';

import '../controllers/admin_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AdminController>(
      () => AdminController(),
    );
    Get.lazyPut<AddDataController>(
          () => AddDataController(),
    );
    Get.lazyPut<SubSoalController>(
          () => SubSoalController(),
    );
  }
}
