import 'dart:ffi';

import 'package:get/get.dart';

class AddCardController extends GetxController{
  var isHover = false.obs;
  void setHover(bool value) => isHover.value =  value;
}