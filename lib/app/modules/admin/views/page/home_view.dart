import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:matdis_edu/app/data/component/condition%20page/empty_pages.dart';
import 'package:matdis_edu/app/data/component/condition%20page/error_pages.dart';
import 'package:matdis_edu/app/data/component/home_video_card.dart';
import 'package:matdis_edu/app/data/helper/authDirection.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:matdis_edu/app/modules/admin/controllers/home_controller.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colours.primary500,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Home', style: GoogleFonts.poppins(
            color: Colours.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          ),
        ),
        bottom: PreferredSize(preferredSize: Size.fromHeight(2.0), child: Container(height: 2, color: Colours.primary500,)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Card(
                color: Colours.primary500,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colours.primary100,
                          ),
                          child: HeroIcon(HeroIcons.checkBadge, color: Colours.primary500, size: 24,),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text("Welcome to Admin Page", style: GoogleFonts.afacad(color: Colours.primary100, fontSize: 24),)
                        )
                      ],
                    ),
                ),
              ),
            ),
            Expanded(
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
                          category: video.category,
                          onClick: ()=>Get.toNamed(Routes.VIDEO_DETAIL, arguments: video),
                        );
                      },
                    );
                  } else {
                    return const EmptyPages();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
