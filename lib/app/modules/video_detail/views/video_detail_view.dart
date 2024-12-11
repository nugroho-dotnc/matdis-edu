import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/component/video_card.dart';
import 'package:matdis_edu/app/data/global_data.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:matdis_edu/app/data/component/loading_page.dart';
import 'package:matdis_edu/app/data/component/VideoProgressBar.dart';
import 'package:video_player/video_player.dart';

import '../controllers/video_detail_controller.dart';

class VideoDetailView extends GetView<VideoDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // VIDEO PLAYER
          VideoCard(path: controller.videoModel.videoUrl, uploadOption: UploadOption.url),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              controller.videoModel.title,
              style: GoogleFonts.poppins(color: Colours.font, fontWeight: FontWeight.w500, fontSize: 18),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Divider(
            height: 2, color: Colours.primary500, thickness: 1,
          ),),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Text(
              controller.videoModel.description,
              style: GoogleFonts.poppins(color: Colours.font, fontWeight: FontWeight.w500, fontSize: 12),
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
