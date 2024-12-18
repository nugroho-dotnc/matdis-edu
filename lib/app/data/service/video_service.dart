import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';


class VideoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<VideoModel>> getUsers() async {
    List<VideoModel> video = [];
    QuerySnapshot snapshot = await _firestore.collection('videos').get();
    video.addAll(snapshot.docs.map((doc) {
      return VideoModel.fromMap(doc.data() as Map<String, dynamic>);
    }));
    return video;
  }

  Future<void> addVideo(VideoModel videoModel) async{
    try{
      DocumentReference docRef = await _firestore.collection('videos').add(videoModel.toMap());
      videoModel.id = docRef.id;
      await docRef.update({'id': videoModel.id});
    }catch(e){
      Get.snackbar("Error", e.toString());
    }
  }
  Future<void> deleteVideo(VideoModel video) async {
    try {
      final videoRef = FirebaseStorage.instance.refFromURL(video.thumbnailUrl);
      final thumbnailRef = FirebaseStorage.instance.refFromURL(video.thumbnailUrl);
      await videoRef.delete();
      await thumbnailRef.delete();
      await FirebaseFirestore.instance.collection('videos').doc(video.id).delete();
    } catch (e) {
      Get.snackbar("error", e.toString());
    }
  }
  Future<void> updateVideo(String id, VideoModel updatedVideo) async {
    try {
      await _firestore.collection('videos').doc(id).update(updatedVideo.toMap());
      Get.snackbar("Success", "Soal berhasil diperbarui");
    } catch (e) {
      Get.snackbar("Error", "Gagal memperbarui soal: $e");
    }
  }
  Future<String> uploadVideo(XFile video) async{
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    // Upload video
    final videoRef = FirebaseStorage.instance.ref().child('videos/$timestamp.mp4');
    final videoUploadTask = videoRef.putFile(File(video.path));
    final videoSnapshot = await videoUploadTask;
    final videoUrl = await videoSnapshot.ref.getDownloadURL();
    return videoUrl;
  }
  Future<String> uploadThumbnail(XFile thumbnail) async{
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final thumbnailRef = FirebaseStorage.instance.ref().child('thumbnails/$timestamp.jpg');
    final thumbnailUploadTask = thumbnailRef.putFile(File(thumbnail.path));
    final thumbnailSnapshot = await thumbnailUploadTask;
    final thumbnailUrl = await thumbnailSnapshot.ref.getDownloadURL();
    return thumbnailUrl;
  }

}
