import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';
import 'package:matdis_edu/app/data/service/video_service.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class HomeController extends GetxController{
  //TODO: Implement HomeController

  final count = 0.obs;
  RxList<VideoModel> videoModel = <VideoModel>[].obs;
  var isEmpty = false.obs;
  var isLoading = false.obs;
  late VideoService _videoService;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  // void _listenToVideoChanges() {
  //   FirebaseFirestore.instance.collection('videos').snapshots().listen((snapshot) {
  //     // Map data dari Firestore ke model
  //     var videos = snapshot.docs.map((doc) {
  //       return VideoModel.fromMap(doc.data() as Map<String, dynamic>);
  //     }).toList();
  //     if(videos.isEmpty){
  //       isEmpty.value = true;
  //     }else{
  //       isEmpty.value = false;
  //     }
  //     // Update list video
  //     videoModel.value = videos;
  //   });
  // }
  Stream<List<VideoModel>> getAllVideos() {
    return FirebaseFirestore.instance.collection('videos').snapshots().map(
            (snapshot) => snapshot.docs
            .map<VideoModel>((doc) => VideoModel.fromMap(doc.data()))
            .toList());
  }
  // void fetchVideo() async{
  //   isLoading.value = true;
  //   try{
  //     List<VideoModel> allVideos = await _videoService.getUsers();
  //     if(allVideos.isEmpty){
  //       isEmpty.value = true;
  //       isLoading.value  = false;
  //     }
  //     videoModel.value = allVideos;
  //     isLoading.value = false;
  //   }catch(e){
  //     isLoading.value = false;
  //     Get.snackbar("error", e.toString());
  //   }
  // }

  void increment() => count.value++;
}
