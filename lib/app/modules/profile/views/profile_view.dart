import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_tracker/app/common/dimens/dimens.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ProfileController>()) {
      Get.lazyPut(() => ProfileController());
    }

    var user = controller.user;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppTextStyles.largeVerticalSpacing,
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),
                width: 100,
                height: 100,
                child: ClipOval(
                  child: Image.network(
                    user?.photoURL ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                user?.displayName ?? 'John doe',
                style: AppTextStyles.largeSubHeaderStyle,
              ),
              AppTextStyles.mediumVerticalSpacing,
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.grey.shade200)),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(user!.email!),
                ),
              ),
              AppTextStyles.mediumVerticalSpacing,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildProfileItems(Icons.edit, 'Edit Profile'),
                    _buildProfileItems(Icons.settings, 'Settings'),
                    _buildProfileItems(
                        Icons.group_add_outlined, 'Invite friend'),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: GestureDetector(
                        onTap: () => controller.logOut(),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.red.shade500,
                            ),
                            AppTextStyles.smallHorizontalSpacing,
                            Text(
                              "Log out",
                              style: TextStyle(
                                color: Colors.red.shade500,
                                fontSize: normalSize,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildProfileItems(IconData icon, String desc) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Icon(icon),
          AppTextStyles.smallHorizontalSpacing,
          Text(
            desc,
            style: AppTextStyles.subHeaderStyle,
          )
        ],
      ),
    );
  }
}
