import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:matdis_edu/app/data/component/condition%20page/empty_pages.dart';
import 'package:matdis_edu/app/data/component/condition%20page/error_pages.dart';
import 'package:matdis_edu/app/data/component/soal_card.dart';
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
          return const Center(child: ErrorPages(messages: "Terjadi Kesalahan",));
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


