import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/app/modules/main/models/nav_item.dart';

class MainController extends GetxController {
  var selectedTab = 0.obs;

  var navItems = [
    NavItem('Home', Icons.home),
    NavItem('Analytics', Icons.stacked_bar_chart),
    NavItem('Profile', Icons.person_2_outlined),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
