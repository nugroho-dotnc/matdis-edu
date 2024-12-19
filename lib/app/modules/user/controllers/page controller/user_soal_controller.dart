import 'package:get/get.dart';
import 'package:matdis_edu/app/data/global_data.dart';
import 'package:matdis_edu/app/data/model/soal_model.dart';
import 'package:matdis_edu/app/data/service/soal_service.dart';

class UserSoalController extends GetxController with StateMixin<List<SoalModel>>{
  late List<SoalModel> soalModel;
  List<String> category = GlobalData.Category;
  var selectedCategory = "semua".obs;
  List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/trip-planner-apps.appspot.com/o/carousel%2F4.jpg?alt=media&token=4c4d2397-8857-4893-adcc-ab298170fb23",
    "https://firebasestorage.googleapis.com/v0/b/trip-planner-apps.appspot.com/o/carousel%2F3.jpg?alt=media&token=5ca3ef48-6d3a-41d1-9d2d-7cbed4a47512",
    "https://firebasestorage.googleapis.com/v0/b/trip-planner-apps.appspot.com/o/carousel%2F2.jpg?alt=media&token=78159274-e941-46b9-9681-39f7aa7dc595"
  ];
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    try{
      change(null, status: RxStatus.loading());
      soalModel = await SoalService().getSoal();
      if(soalModel.isEmpty){
        change(null, status: RxStatus.empty());
      }else{
        change(soalModel, status: RxStatus.success());
      }
    }catch(e){
      Get.snackbar("Error", e.toString());
      change(null, status: RxStatus.error(e.toString()));
    }
  }
  Future<void> changeCategory(String category) async{
    selectedCategory.value = category;
    try{
      if(selectedCategory.value ==  "semua"){
        soalModel = await SoalService().getSoal();
      }else{
        soalModel = await SoalService().getSoalByCategories(category);
      }
      if(soalModel.isEmpty){
        change(null, status: RxStatus.empty());
      }else{
        change(soalModel, status: RxStatus.success());
      }
    }catch(e){
      Get.snackbar("error", e.toString());
      change(null, status: RxStatus.error(e.toString()));
    }
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}