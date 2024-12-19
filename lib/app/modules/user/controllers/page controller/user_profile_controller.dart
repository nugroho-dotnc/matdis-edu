import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/data/helper/authDirection.dart';

class UserProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  var urlProfileImg = "assets/blank_profile.png".obs;
  var username = "Anonymus".obs;
  var email = "-".obs;
  final _currentUser = AuthDirection.auth.currentUser;
  final TextEditingController usernameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
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
