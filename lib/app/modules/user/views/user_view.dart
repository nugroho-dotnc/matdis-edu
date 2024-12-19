import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:matdis_edu/app/data/helper/authDirection.dart';

import '../../../data/theme/colours.dart';
import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(controller: controller.tabController,children: controller.listPage, physics: const NeverScrollableScrollPhysics(),),
        bottomNavigationBar: PreferredSize(preferredSize: const Size.fromHeight(100), child: Container(
          height: 60,
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(
                  color: Colours.primary100,
                  width: 1
              ))
          ),
          child: TabBar(
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              labelColor: Colours.font,
              unselectedLabelColor: Colours.primary500,
              indicator: BoxDecoration(
                color: Colours.primary100,
                borderRadius: BorderRadius.circular(5),
              ),
              controller: controller.tabController,
              tabs: [
                Tab(
                  icon: HeroIcon(HeroIcons.home),
                ),
                Tab(
                  icon: HeroIcon(HeroIcons.academicCap),
                ),Tab(
                  icon: HeroIcon(HeroIcons.user),
                ),
              ]),
        )
        )
    );
  }
}
