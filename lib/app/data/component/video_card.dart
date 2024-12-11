import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/component/loading_page.dart';
import 'package:matdis_edu/app/data/controller/video_controller.dart';
import 'package:video_player/video_player.dart';
import '../global_data.dart';
import '../theme/colours.dart';


class VideoCard extends StatelessWidget {
  final String path;
  final String? tag;
  final UploadOption uploadOption;

  VideoCard({
    Key? key,
    required this.path,
    this.tag,
    required this.uploadOption,
  }) : super(key: key);
  final VideoController controller = Get.put(VideoController());
  @override
  Widget build(BuildContext context) {
    controller.initializeVideoPlayer(path, uploadOption);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Stack(
          children: [
            GestureDetector(
              onTap: controller.toggleOverlay,
              child: FutureBuilder(
                future: controller.initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return VideoPlayer(controller.videoPlayerController);
                  } else {
                    return const Center(child: LoadingPage());
                  }
                },
              ),
            ),
            Obx(() {
              if (controller.showOverlay.value) {
                return _buildOverlay(context);
              } else {
                return SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: controller.toggleOverlay,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.4),
          ),
          child: IconButton(
            onPressed: controller.togglePlayPause,
            icon: Icon(
              controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
              color: Colours.primary500,
              size: 36,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Obx(() {
            final progress = controller.progress.value;
            final duration = controller.videoDuration.value;
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${formatDuration(Duration(seconds: (progress * duration).toInt()))} / ${formatDuration(Duration(seconds: duration.toInt()))}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.fullscreen, color: Colors.white),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 2.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                    activeTrackColor: Colours.primary500,
                    inactiveTrackColor: Colors.white,
                    thumbColor: Colours.primary500,
                  ),
                  child: Slider(
                    value: progress,
                    min: 0.0,
                    max: 1.0,
                    onChanged: controller.seekTo,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
