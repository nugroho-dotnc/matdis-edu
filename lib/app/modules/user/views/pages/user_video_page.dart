import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/component/condition%20page/empty_pages.dart';
import 'package:matdis_edu/app/data/component/condition%20page/error_pages.dart';
import 'package:matdis_edu/app/data/component/home_video_card.dart';
import 'package:matdis_edu/app/data/component/loading_page.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:matdis_edu/app/modules/user/controllers/page%20controller/user_video_controller.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

class UserVideoPage extends GetView<UserVideoController> {
  const UserVideoPage({super.key});

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
          bottom: PreferredSize(preferredSize: Size.fromHeight(2.0),
              child: Container(height: 2, color: Colours.primary500,)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.category.length,
                itemBuilder: (context, index) {
                  String category = controller.category[index];
                  return Obx(() {
                    return InkWell(
                      onTap: ()=>controller.changeCategory(category),
                      child: Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        margin: EdgeInsets.symmetric(
                            horizontal: 2, vertical: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: controller.selectedCategory.value ==
                                controller.category[index]
                                ? Colours.primary500
                                : Colours
                                .primary100,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text(
                          category, style: GoogleFonts.afacad(
                            color: controller.selectedCategory.value ==
                                controller.category[index]
                                ? Colours.primary100
                                : Colours.primary500, fontSize: 16),),
                      ),
                    );
                  });
                },
              ),
            ),
            Expanded(
                child: controller.obx(
                  (state) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: ListView.builder(
                      itemCount: state!.length,
                      itemBuilder: (context, index) {
                        VideoModel _video = state![index];
                        return HomeVideoCard(thumbnailUrl: _video.thumbnailUrl, title: _video.title, onClick: ()=>Get.toNamed(Routes.VIDEO_DETAIL, arguments: _video), category: _video.category);
                      },
                    ),
                  ),
                  onEmpty: EmptyPages(),
                  onError: (error) => ErrorPages(messages: "Terjadi kesalahan: ${error}",),
                  onLoading: LoadingPage()
                ),
            ),
          ],
        )
    );
  }
}
