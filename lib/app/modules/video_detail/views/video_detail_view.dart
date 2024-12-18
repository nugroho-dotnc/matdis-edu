import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:matdis_edu/app/data/component/chewie_video_card.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';

import '../controllers/video_detail_controller.dart';

class VideoDetailView extends GetView<VideoDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Detail Video',
            style: GoogleFonts.poppins(
              color: Colours.font,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              height: 2,
              color: Colours.primary500,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          // VIDEO PLAYER
          ChewieVideoCard(
            controller: controller.chewieController,
            onFuture: controller.initializeVideoPlayerFuture,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              controller.videoModel.title,
              style: GoogleFonts.poppins(
                color: Colours.font,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Divider(
              height: 4,
              color: Colours.primary500,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Text(
              controller.videoModel.description,
              style: GoogleFonts.poppins(
                color: Colours.font,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: controller.openBottomSheet,
        backgroundColor: Colours.primary500,
        child: const HeroIcon(HeroIcons.bars3, color: Colors.white),
      ),
    );
  }
}
