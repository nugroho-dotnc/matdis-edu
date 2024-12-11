import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';

class CustomLoading {
  static bool isLoading = false;
  static void show() {
    isLoading = true;
    showDialog(
      context: Get.context!,
      barrierDismissible: false, // Supaya tidak bisa ditutup dengan klik di luar dialog
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(20), // Jarak isi di dalam dialog
            decoration: BoxDecoration(
              color: Colors.white, // Background putih
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min, // Supaya ukuran dialog menyesuaikan isi
              children: [
                CircularProgressIndicator(color: Colours.primary500,), // Loading spinner
              ],
            ),
          ),
        );
      },
    );
  }

  static void dismiss() {
    if(isLoading == true){
      Get.back();
    }
  }
}
