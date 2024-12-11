import 'package:flutter/material.dart';

class VideoProgressBar extends StatelessWidget {
  final double progress;  // Nilai progress bar (0 to 1)
  final double duration;  // Durasi video dalam detik

  const VideoProgressBar({
    Key? key,
    required this.progress,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider sebagai progress bar
        Slider(
          value: progress,
          min: 0.0,
          max: 1.0,
          onChanged: (newProgress) {
            // Slider tidak bisa diubah langsung, karena kita hanya menampilkan progress
            // Anda bisa menambahkan logika di sini jika ingin memberikan kontrol kepada pengguna
          },
        ),
        // Menampilkan durasi video dalam format menit:detik
        Text(
          '${formatDuration(Duration(seconds: (progress * duration).toInt()))} / ${formatDuration(Duration(seconds: duration.toInt()))}',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  // Fungsi untuk memformat durasi dalam format MM:SS
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
