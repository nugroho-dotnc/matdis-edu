import 'package:get/get.dart';
import 'package:matdis_edu/app/modules/user/controllers/page%20controller/user_profile_controller.dart';
import 'package:matdis_edu/app/modules/user/controllers/page%20controller/user_soal_controller.dart';
import 'package:matdis_edu/app/modules/user/controllers/page%20controller/user_video_controller.dart';

import '../controllers/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(
      () => UserController(),
    );
    Get.lazyPut<UserVideoController>(
      () => UserVideoController(),
    );
    Get.lazyPut<UserSoalController>(
      () => UserSoalController(),
    );
    Get.lazyPut<UserProfileController>(
      () => UserProfileController(),
    );
  }
}
