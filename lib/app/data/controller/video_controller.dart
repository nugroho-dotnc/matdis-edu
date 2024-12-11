import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matdis_edu/app/data/global_data.dart';
import 'package:matdis_edu/app/modules/admin/video_form/controllers/video_form_controller.dart';
import 'package:video_player/video_player.dart';

import '../model/video_model.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;

  final isPlaying = false.obs;
  final showOverlay = false.obs;
  final progress = 0.0.obs;
  final videoDuration = 0.0.obs;

  Timer? progressTimer;
  Timer? overlayTimer;

  void initializeVideoPlayer(String pathUrl, UploadOption uploadOption) {
    if (uploadOption == UploadOption.file) {
      videoPlayerController = VideoPlayerController.file(File(pathUrl));
    } else {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(pathUrl));
    }

    initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      videoDuration.value = videoPlayerController.value.duration.inSeconds.toDouble();
      videoPlayerController.setLooping(true);
      playVideo();

      progressTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (videoPlayerController.value.isInitialized) {
          progress.value = videoPlayerController.value.position.inSeconds.toDouble() /
              videoPlayerController.value.duration.inSeconds.toDouble();
        }
      });
    });

    videoPlayerController.addListener(() {
      isPlaying.value = videoPlayerController.value.isPlaying;
    });
  }

  void playVideo() {
    videoPlayerController.play();
    isPlaying.value = true;
  }

  void pauseVideo() {
    videoPlayerController.pause();
    isPlaying.value = false;
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      pauseVideo();
    } else {
      playVideo();
    }
    showOverlayWithTimeout();
  }

  void toggleOverlay() {
    showOverlay.value = !showOverlay.value;
    if (showOverlay.value) {
      showOverlayWithTimeout();
    }
  }

  void showOverlayWithTimeout() {
    showOverlay.value = true;
    overlayTimer?.cancel();
    overlayTimer = Timer(Duration(seconds: 2), () {
      showOverlay.value = false;
    });
  }

  void seekTo(double newProgress) {
    final position = Duration(
      seconds: (newProgress * videoPlayerController.value.duration.inSeconds).toInt(),
    );
    videoPlayerController.seekTo(position);
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    progressTimer?.cancel();
    overlayTimer?.cancel();
    super.onClose();
  }
}
