import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_tracker/app/modules/home/views/home_view.dart';
import 'package:habit_tracker/app/modules/profile/views/profile_view.dart';
import 'package:habit_tracker/app/modules/stats/views/stats_view.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: [
          HomeView(),
          StatsView(),
          ProfileView()
        ][controller.selectedTab.value],
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          elevation: 0,
          height: 63,
          backgroundColor: Colors.transparent,
          notchSmoothness: NotchSmoothness.softEdge,
          itemCount: 3,
          activeIndex: controller.selectedTab.value,
          gapWidth: 10,
          splashRadius: 0,
          scaleFactor: 0,
          onTap: (index) => controller.selectedTab.value = index,
          tabBuilder: (int index, bool isActive) {
            var item = controller.navItems[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  decoration: BoxDecoration(
                    color:
                        isActive ? Get.theme.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(item.icon,
                      size: 24,
                      color: isActive ? Colors.white : Colors.grey[600]),
                ),
                SizedBox(height: 3),
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: isActive ? Get.theme.primaryColor : Colors.grey[600],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
