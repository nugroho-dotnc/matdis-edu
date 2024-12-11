import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/data/helper/authDirection.dart';
import 'package:matdis_edu/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final FlipCardController flipCardController = FlipCardController();

  Rxn<User?> currentUser = Rxn<User?>();
  final pageState = 0.obs;

  @override
  void onInit() {
    super.onInit();
    currentUser.bindStream(auth.userChanges());
    ever(currentUser, AuthDirection.initialScreen);
  }

  void register() async {
    isLoading.value = true;
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final passwordConfirmation = passwordConfirmationController.text.trim();
      final username = usernameController.text.trim();

      if (email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty || username.isEmpty) {
        Get.snackbar("Error", "Please fill all fields");
        isLoading.value = false;
        return;
      }

      if (password != passwordConfirmation) {
        Get.snackbar("Error", "Passwords do not match");
        isLoading.value = false;
        return;
      }

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firestore.collection("users").doc(userCredential.user!.uid).set({
        "email": email,
        "role": "user",
        "username": username,
      });

      await userCredential.user!.updateProfile(displayName: username);

      Get.snackbar("Success", "Registration successful");
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      Get.snackbar("Registration Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void login() async {
    isLoading.value = true;
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        Get.snackbar("Error", "Email and password must not be empty");
        isLoading.value = false;
        return;
      }

      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Login successful");
    } catch (e) {
      Get.snackbar("Login Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void flipCard() {
    flipCardController.toggleCard();
    pageState.value = (pageState.value == 0) ? 1 : 0;
  }
}