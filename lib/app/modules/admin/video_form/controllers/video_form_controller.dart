import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

class VideoFormController extends GetxController {
  // Firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Form Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late VideoModel videoModel;
  // Image & Video Picker
  final ImagePicker _picker = ImagePicker();

  // Observables
  var isLoading = false.obs;
  Rx<XFile?> thumbnail = Rx<XFile?>(null);
  Rx<XFile?> video = Rx<XFile?>(null);
  var selectedValue = ''.obs;

  // Categories
  final List<String> items = [
    'Logika',
    'Himpunan',
    'Matriks, relasi, fungsi',
    'Induksi Matematik',
  ];

  // Max file size (200 MB)
  final int maxFileSize = 200 * 1024 * 1024;

  @override
  void onInit() {
    super.onInit();
    selectedValue.value = items[0]; // Set default category
    if(Get.arguments != null){
      videoModel = Get.arguments  as VideoModel;
      titleController.text = videoModel.title;
      descriptionController.text = videoModel.description;
    }
  }

  /// Updates the selected category value
  void updateSelectedValue(String newValue) {
    selectedValue.value = newValue;
  }

  /// Picks a video from the gallery
  Future<String> pickVideo() async {
    try {
      final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile == null) {
        return "null"; // No video selected
      }

      final file = File(pickedFile.path);
      final fileSize = file.lengthSync();

      if (fileSize > maxFileSize) {
        Get.snackbar("Error", "Ukuran video melebihi batas 200 MB");
        return "null";
      }

      video.value = XFile(pickedFile.path);
      Get.snackbar("Success", "Video berhasil disimpan");
      return pickedFile.path;
    } catch (e) {
      Get.snackbar("Error", "Gagal memilih video: $e");
      return "null";
    }
  }

  /// Picks a thumbnail image from the gallery
  Future<void> pickThumbnail() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return; // No image selected

      thumbnail.value = XFile(pickedFile.path);
      Get.snackbar("Success", "Thumbnail berhasil disimpan");
    } catch (e) {
      Get.snackbar("Error", "Gagal memilih thumbnail: $e");
    }
  }

  /// Uploads video and thumbnail to Firebase Storage and saves metadata to Firestore
  Future<void> uploadVideo() async {
    if (video.value == null || thumbnail.value == null) {
      Get.snackbar("Error", "Video atau Thumbnail belum dipilih");
      return;
    }

    try {
      isLoading.value = true;

      final String title = titleController.text;
      final String description = descriptionController.text;

      if (title.isEmpty || description.isEmpty) {
        Get.snackbar("Error", "Judul dan Deskripsi tidak boleh kosong");
        isLoading.value = false;
        return;
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload video
      final videoRef = FirebaseStorage.instance.ref().child('videos/$timestamp.mp4');
      final videoUploadTask = videoRef.putFile(File(video.value!.path));
      final videoSnapshot = await videoUploadTask;
      final videoUrl = await videoSnapshot.ref.getDownloadURL();

      // Upload thumbnail
      final thumbnailRef = FirebaseStorage.instance.ref().child('thumbnails/$timestamp.jpg');
      final thumbnailUploadTask = thumbnailRef.putFile(File(thumbnail.value!.path));
      final thumbnailSnapshot = await thumbnailUploadTask;
      final thumbnailUrl = await thumbnailSnapshot.ref.getDownloadURL();

      // Create video model
      final VideoModel newVideo = VideoModel(
        title: title,
        category: selectedValue.value,
        description: description,
        thumbnailUrl: thumbnailUrl,
        videoUrl: videoUrl,
      );

      // Save video metadata to Firestore
      await _firestore.collection('videos').add(newVideo.toMap());

      isLoading.value = false;
      Get.snackbar("Success", "Video berhasil diunggah!");
      clearForm();
      Get.offNamed(Routes.ADMIN);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Gagal mengunggah video: $e");
    }
  }

  /// Clears the form data
  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    thumbnail.value = null;
    video.value = null;
    selectedValue.value = items[0];
  }
}
