import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_pages.dart';
import '../theme/colours.dart';
import '../../data/controller/add_card_controller.dart';

class AddCard extends StatelessWidget {
  final String? imgUrl;
  final String title;
  final double? height;
  final String? tag;
  final Function()? onCLick;

  AddCard({
    super.key, this.imgUrl, required this.title, this.onCLick, this.height, this.tag,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddCardController(), tag: tag??"card");
    return Obx(() {
      return InkWell(
        onTap: onCLick,
        onHover: (value) => controller.isHover.value = value,
        child: Container(
          height: height ?? 100,
          child: Card(
            color: controller.isHover.value ? Colours.primary100 : Colors.white,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  if (imgUrl != null)
                    Container(
                      width: 130,
                      height: 150,
                      padding: EdgeInsets.all(10),
                      color: Colours.primary100,
                      child: SvgPicture.asset(
                        imgUrl!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colours.font,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.add,
                      color: Colours.font,
                      size: 32,
                    ),
                    decoration:  BoxDecoration(
                      color: controller.isHover.value?Colors.white:Colours.primary100,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colours.primary300,
                          blurRadius: 3.0,
                          blurStyle: BlurStyle.inner,
                          offset: Offset(3, 3),
                          spreadRadius: 1,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
