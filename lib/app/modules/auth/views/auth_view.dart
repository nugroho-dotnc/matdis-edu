import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/component/loading_page.dart';
import 'package:matdis_edu/app/data/theme/colours.dart';
import 'package:matdis_edu/app/modules/auth/views/login_view.dart';
import 'package:matdis_edu/app/modules/auth/views/register_view.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            child: FlipCard(
                controller: controller.flipCardController,
                flipOnTouch: false,
                fill: Fill.fillBack,
                // Fill the back side of the card to make in the same size as the front.
                direction: FlipDirection.HORIZONTAL,
                // default
                side: CardSide.FRONT,
                // The side to initially display.
                front: const LoginView(),
                back: const RegisterView()
            )
        ),
        Obx(() {
          return Visibility(
            visible: controller.isLoading.value,
              child: Align(
                alignment: Alignment.center,
                child: LoadingPage(),
              ));
        })
      ],
    );
  }
}
