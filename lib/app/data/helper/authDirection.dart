
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

class AuthDirection {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final user = auth.currentUser;
  static initialScreen(User? user) async {
    if (user != null) {
      String role = await getRole(user.uid);
      if(role == "admin"){
        Get.offNamed(Routes.ADMIN);
      }else{
        Get.offNamed(Routes.USER);
      }

    }
  }
  static Future<String> getRole(String userId) async {
    try {
      DocumentSnapshot userDoc = await firestore.collection("users").doc(userId).get();
      return userDoc["role"] ?? "user";
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user role");
      return "user";
    }
  }
  static logout() async {
    try{
      await auth.signOut().then((value) => Get.offAllNamed(Routes.AUTH,));
    }catch(e){
      Get.snackbar("error", e.toString());
    }
  }
}