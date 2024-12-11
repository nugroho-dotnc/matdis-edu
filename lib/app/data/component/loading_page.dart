import 'package:flutter/material.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(30), // Jarak isi di dalam dialog
        decoration: BoxDecoration(
          color: Colors.white, // Background putih
          borderRadius: BorderRadius.circular(10),
        ),
        child: const CircularProgressIndicator(color: Colours.primary500),
      ),
    );
  }
}
