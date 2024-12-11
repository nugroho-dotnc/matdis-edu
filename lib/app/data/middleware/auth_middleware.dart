import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/data/helper/authDirection.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  int? priority = 1;
  AuthMiddleware({required this.priority});
  @override
  RouteSettings? redirect(String? route) {
    final user = auth.currentUser;
    if(user == null){
      return const RouteSettings(name: Routes.AUTH);
    }
    return null; // Tetap di halaman yang diminta
  }
}
