import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:matdis_edu/app/data/helper/urlDecoder.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';
import 'package:matdis_edu/app/data/service/video_service.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';
import 'package:video_player/video_player.dart';

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
  var isEdit = false.obs;
  Rx<XFile?> thumbnail = Rx<XFile?>(null);
  Rx<XFile?> video = Rx<XFile?>(null);
  var selectedValue = ''.obs;

  // Video Player
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  late Future<void> initializeVideoPlayerFuture;

  VideoService videoService = VideoService();
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
    if (Get.arguments != null) {
      videoModel = Get.arguments as VideoModel;
      isEdit.value = true;
      titleController.text = videoModel.title;
      descriptionController.text = videoModel.description;
      for(int i = 0; i > items.length; i++){
        if(items[i] == videoModel.category){
          selectedValue.value = items[i];
        }
      }
    }
  }

  /// Updates the selected category value
  void updateSelectedValue(String newValue) {
    selectedValue.value = newValue;
  }

  /// Picks a video from the gallery
  Future<void> pickVideo() async {
    if(video.value != null){
      video.value = null;
    }
    if(isEdit.value){
      return;
    }
    try {
      final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile == null) {
        Get.snackbar("Info", "Tidak ada video yang dipilih");
        return;
      }
      final file = File(pickedFile.path);
      final fileSize = file.lengthSync();
      if (fileSize > maxFileSize) {
        Get.snackbar("Error", "Ukuran video melebihi batas 200 MB");
        return;
      }
      video.value = XFile(pickedFile.path);
      videoPlayerController = VideoPlayerController.file(File(video.value!.path));
      initializeVideoPlayerFuture = videoPlayerController.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
      );
      Get.snackbar("Success", "Video berhasil disimpan");
    } catch (e) {
      Get.snackbar("Error", "Gagal memilih video: ${e.toString()}");
    }
  }

  /// Picks a thumbnail image from the gallery
  Future<void> pickThumbnail() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      thumbnail.value = XFile(pickedFile.path);
      Get.snackbar("Success", "Thumbnail berhasil disimpan");
    } catch (e) {
      Get.snackbar("Error", "Gagal memilih thumbnail: ${e.toString()}");
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
      final String title = titleController.text.trim();
      final String description = descriptionController.text.trim();
      if (title.isEmpty || description.isEmpty) {
        Get.snackbar("Error", "Judul dan Deskripsi tidak boleh kosong");
        isLoading.value = false;
        return;
      }

      // Upload Video
      final videoUrl = await videoService.uploadVideo(video.value!);

      // Upload Thumbnail
      String thumbnailUrl;
      if (thumbnail.value != null) {
        thumbnailUrl = await videoService.uploadThumbnail(thumbnail.value!);
      } else {
        thumbnailUrl = ''; // Default if no thumbnail
      }

      // Create new VideoModel instance
      final VideoModel newVideo = VideoModel(
        title: title,
        category: selectedValue.value,
        description: description,
        thumbnailUrl: thumbnailUrl,
        videoUrl: videoUrl,
        id: '',
        uploaded: DateTime.now().toString(),
      );

      // Save video metadata to Firestore
      await videoService.addVideo(newVideo);

      isLoading.value = false;
      Get.snackbar("Success", "Video berhasil diunggah!");
      clearForm();
      Get.offNamed(Routes.ADMIN);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Gagal mengunggah video: ${e.toString()}");
    }
  }

  Future<void> editVideo() async {
    try {
      isLoading.value = true;
      final String title = titleController.text.trim();
      final String description = descriptionController.text.trim();
      if (title.isEmpty || description.isEmpty) {
        Get.snackbar("Error", "Judul dan Deskripsi tidak boleh kosong");
        isLoading.value = false;
        return;
      }
      String thumbnailUrl;
      if (thumbnail.value != null) {
        // Delete old thumbnail if new one is selected
        final ref = FirebaseStorage.instance.refFromURL(videoModel.thumbnailUrl);
        await ref.delete();
        thumbnailUrl = await videoService.uploadThumbnail(thumbnail.value!);
      } else {
        thumbnailUrl = videoModel.thumbnailUrl; // Keep old thumbnail if none selected
      }
      // Create updated VideoModel
      final VideoModel newVideo = VideoModel(
        title: title,
        category: selectedValue.value,
        description: description,
        thumbnailUrl: thumbnailUrl,
        videoUrl: videoModel.videoUrl,
        uploaded: videoModel.uploaded,
        id: videoModel.id,
      );
      // Save updated video metadata to Firestore
      await videoService.updateVideo(videoModel.id, newVideo);
      isLoading.value = false;
      Get.snackbar("Success", "Video berhasil diperbarui!");
      clearForm();
      Get.offNamed(Routes.ADMIN);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
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

  String getDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('d MMMM yyyy', 'id_ID');
    return formatter.format(now);
  }

  @override
  void onClose() {
    super.onClose();
    try {
      videoPlayerController.dispose();
      chewieController.dispose();
    } catch (e) {
      print("Error saat membersihkan resource: ${e.toString()}");
    }
    clearForm();
  }
}
