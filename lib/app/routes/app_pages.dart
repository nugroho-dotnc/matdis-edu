import 'package:get/get.dart';

import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/soal_form/bindings/soal_form_binding.dart';
import '../modules/admin/soal_form/views/soal_form_view.dart';
import '../modules/admin/video_form/bindings/video_form_binding.dart';
import '../modules/admin/video_form/views/video_form_view.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/soal_detail/bindings/soal_detail_binding.dart';
import '../modules/soal_detail/views/soal_detail_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';
import '../modules/video_detail/bindings/video_detail_binding.dart';
import '../modules/video_detail/views/video_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => const AdminView(),
      binding: AdminBinding(),
      children: [
        GetPage(
          name: _Paths.VIDEO_FORM,
          page: () => const VideoFormView(),
          binding: VideoFormBinding(),
        ),
        GetPage(
          name: _Paths.SOAL_FORM,
          page: () => const SoalFormView(),
          binding: SoalFormBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.VIDEO_DETAIL,
      page: () => VideoDetailView(),
      binding: VideoDetailBinding(),
    ),
    GetPage(
      name: _Paths.SOAL_DETAIL,
      page: () => const SoalDetailView(),
      binding: SoalDetailBinding(),
    ),
  ];
}
