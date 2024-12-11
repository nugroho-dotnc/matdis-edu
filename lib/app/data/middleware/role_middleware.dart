import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/data/helper/authDirection.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

class RoleMiddleware extends GetMiddleware {
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  int? priority = 1;
  RoleMiddleware({required this.priority});
  @override
  RouteSettings? redirect(String? route) {
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, (callback) async {
      String role = await AuthDirection.getRole(callback!.uid);
      if(role == "admin"){
        return const RouteSettings(name: Routes.ADMIN);
      }else{
        return const RouteSettings(name: Routes.USER);
      }
    },);

    bool isLoggedIn = false;
    if (!isLoggedIn) {
      return const RouteSettings(name: '/login');
    }
    return null; // Tetap di halaman yang diminta
  }
}
