import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:matdis_edu/app/data/component/condition%20page/empty_pages.dart';
import 'package:matdis_edu/app/data/component/condition%20page/error_pages.dart';
import 'package:matdis_edu/app/data/model/soal_model.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:matdis_edu/app/modules/admin/controllers/sub_soal_controller.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

class SubSoalPage extends GetView<SubSoalController> {
  const SubSoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SoalModel>>(
      stream: controller.getAllSoal(),
      builder: (context, snapshot) {
        // Handle waiting or no connection state
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
          return const EmptyPages();
        }
        // Handle error state
        if (snapshot.hasError) {
          print(snapshot.error); // Debugging error
          return const Center(child: ErrorPages());
        }
        // Handle successful data retrieval
        if (snapshot.hasData) {
          final soals = snapshot.data ?? [];
          if (soals.isEmpty) {
            return const EmptyPages(); // No data available
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: soals.length,
            itemBuilder: (context, index) {
              final soal = soals[index];
              return SoalCard(
                title: soal.title,
                category: soal.category,
                onTap: () => Get.toNamed(Routes.SOAL_DETAIL, arguments: soal),
              );
            },
          );
        }

        // Default state if none of the above is met
        return const EmptyPages();
      },
    );
  }
}

class SoalCard extends StatelessWidget {
  final String title;
  final String category;
  final VoidCallback onTap;
  const SoalCard({
    super.key, required this.title, required this.category, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colours.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset('assets/document.svg', fit: BoxFit.contain, height: 100, width: 100,),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${title}", style: GoogleFonts.afacad(fontSize: 20, color: Colours.primary500, fontWeight: FontWeight.w500),),
                      Text("Kategori: ${category}", style: GoogleFonts.afacad(fontSize: 16, color: Colours.primary500, fontWeight: FontWeight.w300),),
                    ],
                  ),
                ),
                Container(
                  width: 30,
                  height: 100,
                  child: HeroIcon(HeroIcons.chevronRight, color: Colours.primary500, size: 32,),
                )
              ],
            )
          ),
        ),
    );
  }
}
