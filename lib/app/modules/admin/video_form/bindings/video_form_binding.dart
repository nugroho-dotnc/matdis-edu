import 'package:get/get.dart';

import '../controllers/video_form_controller.dart';

class VideoFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoFormController>(
      () => VideoFormController(),
    );
  }
}
