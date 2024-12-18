import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/data/component/condition%20page/empty_pages.dart';
import 'package:matdis_edu/app/data/component/condition%20page/error_pages.dart';
import 'package:matdis_edu/app/data/component/home_video_card.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';
import 'package:matdis_edu/app/modules/admin/controllers/home_controller.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

class SubVideoPage extends StatelessWidget {
  SubVideoPage({super.key});
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<VideoModel>>(
      stream: controller.getAllVideos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
          return const EmptyPages();
        } else if (snapshot.hasError) {
          print(snapshot.error); // Hanya untuk debugging
          return const Center(
            child: ErrorPages(),
          );
        } else if (snapshot.hasData) {
          final videos = snapshot.data ?? [];
          if (videos.isEmpty) {
            return const EmptyPages(); // Jika tidak ada video
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return HomeVideoCard(
                thumbnailUrl: video.thumbnailUrl,
                category: video.category,
                title: video.title,
                onClick: ()=>Get.toNamed(Routes.VIDEO_DETAIL, arguments: video),
              );
            },
          );
        } else {
          return const EmptyPages();
        }
      },
    );
  }
}
