import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/component/condition%20page/empty_pages.dart';
import 'package:matdis_edu/app/data/component/condition%20page/error_pages.dart';
import 'package:matdis_edu/app/data/component/loading_page.dart';
import 'package:matdis_edu/app/data/component/soal_card.dart';
import 'package:matdis_edu/app/data/model/soal_model.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:matdis_edu/app/modules/user/controllers/page%20controller/user_soal_controller.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

class UserSoalPage extends GetView<UserSoalController>{
  const UserSoalPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colours.primary500,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Soal', style: GoogleFonts.poppins(
              color: Colours.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            ),
          ),
          bottom: PreferredSize(preferredSize: Size.fromHeight(2.0), child: Container(height: 2, color: Colours.primary500,)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            CarouselSlider(
              items: controller.imageList.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 6),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
            ),
            SizedBox(height: 10,),
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
                      (state) => ListView.builder(
                    itemCount: state!.length,
                    itemBuilder: (context, index) {
                      SoalModel _soal = state![index];
                      return SoalCard(title: _soal.title, category: _soal.category, onTap: ()=>Get.toNamed(Routes.SOAL_DETAIL, arguments: _soal));
                    },
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
