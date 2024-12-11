import 'package:get/get.dart';
import 'package:matdis_edu/app/data/helper/authDirection.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  var urlProfileImg = "".obs;
  var username = "".obs;
  var email = "".obs;
  final _currentUser = AuthDirection.auth.currentUser;
  @override
  void onInit() {
    super.onInit();
    if(_currentUser != null){
      urlProfileImg.value = _currentUser.photoURL??"";
      username.value = _currentUser.displayName??"change here ...";
      email.value = _currentUser.email??"";
    }
  }

  @override
  void onReady() {
    super.onReady();

  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
