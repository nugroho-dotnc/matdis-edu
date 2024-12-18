import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/data/model/soal_model.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';
import 'package:matdis_edu/app/data/service/soal_service.dart';
import 'package:matdis_edu/app/data/service/video_service.dart';

class SubSoalController extends GetxController{
  late SoalService _soalService;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _soalService = SoalService();
  }
  Stream<List<SoalModel>> getAllSoal() {
    return _soalService.getAllSoal();
  }
}