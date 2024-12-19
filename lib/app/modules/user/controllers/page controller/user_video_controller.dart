import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/data/global_data.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';
import 'package:matdis_edu/app/data/service/video_service.dart';

class UserVideoController extends GetxController with StateMixin<List<VideoModel>>{
  late List<VideoModel> videoModel;
  List<String> category = GlobalData.Category;
  var selectedCategory = "semua".obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    try{
      change(null, status: RxStatus.loading());
      videoModel  = await VideoService().getVideo();
      if(videoModel.isEmpty){
        change(null, status: RxStatus.empty());
      }else{
        change(videoModel, status: RxStatus.success());
      }
    }catch(e){
      change(null, status: RxStatus.error(e.toString()));
      Get.snackbar("error", e.toString());
    }
  }
  Future<void> changeCategory(String category) async{
    selectedCategory.value = category;
    try{
      if(selectedCategory.value ==  "semua"){
        videoModel = await VideoService().getVideo();
      }else{
        videoModel = await VideoService().getVideoByCategories(category);
      }
      if(videoModel.isEmpty){
        change(null, status: RxStatus.empty());
      }else{
        change(videoModel, status: RxStatus.success());
      }
    }catch(e){
      Get.snackbar("error", e.toString());
      change(null, status: RxStatus.error(e.toString()));
    }
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}