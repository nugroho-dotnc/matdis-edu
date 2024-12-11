import 'package:get/get.dart';

class PasswordController extends GetxController{
  final secure = true.obs;
  void secured() => secure.value = true;
  void desecured() => secure.value = false;
  void toggle(){
    if(secure.value){
      desecured();
    }else{
      secured();
    }
  }
}