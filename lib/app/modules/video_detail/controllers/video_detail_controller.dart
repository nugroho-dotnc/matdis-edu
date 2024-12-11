import 'dart:async';
import 'package:get/get.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoDetailController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  late VideoModel videoModel;

  final isPlaying = false.obs;
  final showOverlay = false.obs;
  final progress = 0.0.obs;
  final videoDuration = 0.0.obs;

  late Timer progressTimer; // Timer untuk update progress bar
  Timer? overlayTimer; // Timer untuk menyembunyikan overlay

  @override
  void onInit() {
    super.onInit();

    // Ambil video model dari Get.arguments
    videoModel = Get.arguments as VideoModel;

    // Inisialisasi VideoPlayerController
    Uri videoUrl = Uri.parse(videoModel.videoUrl);
    videoPlayerController = VideoPlayerController.networkUrl(videoUrl);

    // Inisialisasi video player
    initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      videoDuration.value = videoPlayerController.value.duration.inSeconds.toDouble();
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
      isPlaying.value = true;

      // Timer untuk update progress bar setiap detik
      progressTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (videoPlayerController.value.isInitialized) {
          progress.value = videoPlayerController.value.position.inSeconds.toDouble() /
              videoPlayerController.value.duration.inSeconds.toDouble();
        }
      });
    });

    // Listener untuk mendeteksi perubahan status video
    videoPlayerController.addListener(() {
      isPlaying.value = videoPlayerController.value.isPlaying;
    });
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    progressTimer.cancel();
    overlayTimer?.cancel();
    super.onClose();
  }

  void togglePlayPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      isPlaying.value = false;
    } else {
      videoPlayerController.play();
      isPlaying.value = true;
      if (showOverlay.value) {
        showOverlayWithTimeout();
      }
    }

    // Tampilkan overlay setiap kali tombol play/pause ditekan
    showOverlayWithTimeout();
  }

  void toggleOverlay() {
    showOverlay.value = !showOverlay.value;
  }

  void showOverlayWithTimeout() {
    showOverlay.value = true;
    overlayTimer?.cancel(); // Hentikan timer sebelumnya jika ada
    overlayTimer = Timer(Duration(seconds: 2), () {
      showOverlay.value = false;
    });
  }

  void seekTo(double newProgress) {
    final position = Duration(seconds: (newProgress * videoPlayerController.value.duration.inSeconds).toInt());
    videoPlayerController.seekTo(position);
  }
}
