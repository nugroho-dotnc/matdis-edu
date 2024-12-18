import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

class ChewieVideoCard extends StatelessWidget {
  final ChewieController controller;
  final Future<void> onFuture;
  ChewieVideoCard({
    super.key,
    required this.controller,
    required this.onFuture,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: FutureBuilder<void>(
        future: onFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading video',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Chewie(controller: controller);
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}
