import 'dart:async';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/component/button.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';
import 'package:matdis_edu/app/data/service/video_service.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/quickalert.dart';
import 'package:video_player/video_player.dart';

class VideoDetailController extends GetxController {
  late final VideoModel videoModel;
  late final VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  late Future<void> initializeVideoPlayerFuture;
  final VideoService videoService = VideoService();
  @override
  void onInit() async {
    super.onInit();
    videoModel = Get.arguments as VideoModel;
    Uri videoUrl = Uri.parse(videoModel.videoUrl);
    videoPlayerController = VideoPlayerController.networkUrl(videoUrl);
    initializeVideoPlayerFuture = videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  void deleteVideo() async {
    try {
      await videoService.deleteVideo(videoModel);
      Get.snackbar("Success", "Video Berhasil Dihapus");
      Get.offAllNamed(Routes.ADMIN);
    } catch (e) {
      Get.snackbar("error", e.toString());
    }
  }
  void openBottomSheet(){
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colours.neutral500,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
                width: double.infinity,
                child: CustomButton(
                    onClick: ()=>Get.toNamed(Routes.VIDEO_FORM, arguments: videoModel), text: "Edit Video")
            ),
            const SizedBox(height: 10),
            SizedBox(
                width: double.infinity,
                child: CustomButton(
                    onClick: ()=>QuickAlert.show(
                        context: Get.context!,
                        type: QuickAlertType.warning,
                        text: 'Yakin Ingin Menghapus Video ini?',
                        showCancelBtn: true,
                        showConfirmBtn: true,
                        confirmBtnText: 'Yes',
                        cancelBtnText: 'No',
                        confirmBtnColor: Colors.red,
                        onConfirmBtnTap: ()=>deleteVideo(),
                        onCancelBtnTap: ()=>Get.back()
                    ),
                    text: "Delete Video")
            )
          ],
        ),
      ),
      isDismissible: true, // Bisa ditutup dengan tap di luar
      enableDrag: true,    // Bisa di-drag untuk ditutup
    );
  }
  @override
  void onClose() {
    super.onClose();
    if (initializeVideoPlayerFuture != null) {
      initializeVideoPlayerFuture.then((_) {
        videoPlayerController.dispose();
        chewieController.dispose();
      }).catchError((error) {
        print("Error disposing video resources: $error");
      });
    }
  }
}