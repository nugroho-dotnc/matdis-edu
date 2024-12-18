import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matdis_edu/app/data/helper/authDirection.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ElevatedButton(
        onPressed: AuthDirection.logout,
        child: Text(
          'UserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
