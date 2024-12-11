import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/component/condition%20page/empty_pages.dart';
import 'package:matdis_edu/app/data/component/condition%20page/error_pages.dart';
import 'package:matdis_edu/app/data/component/home_video_card.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:matdis_edu/app/modules/admin/controllers/home_controller.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Home', style: GoogleFonts.poppins(
            color: Colours.primary500,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          ),
        ),
        bottom: PreferredSize(preferredSize: Size.fromHeight(2.0), child: Container(height: 2, color: Colours.primary500,)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: StreamBuilder<List<VideoModel>>(
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
                    title: video.title,
                    onClick: ()=>Get.toNamed(Routes.VIDEO_DETAIL, arguments: video),
                    onDelete: () {

                    },
                    onEdit: () =>Get.toNamed(Routes.VIDEO_DETAIL, arguments: video),
                    onOptionsPressed: () {},
                  );
                },
              );
            } else {
              return const EmptyPages();
            }
          },
        ),
      ),
    );
  }
}
