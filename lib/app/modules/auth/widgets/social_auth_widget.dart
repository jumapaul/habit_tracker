import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/app/common/dimens/dimens.dart';

class SocialAuthWidget extends StatelessWidget {
  final VoidCallback onGoogleTap;

  const SocialAuthWidget({super.key, required this.onGoogleTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Or continue with',
          style: AppTextStyles.subHeaderStyle,
        ),
        SizedBox(
          height: mediumSize,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialAuth('assets/images/google.png', onGoogleTap),
            AppTextStyles.mediumHorizontalSpacing,
            AppTextStyles.mediumHorizontalSpacing,
            _buildSocialAuth('assets/images/facebook.png', () {})
          ],
        ),
      ],
    );
  }

  _buildSocialAuth(String path, clicked()) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Get.theme.colorScheme.surface,
      child: IconButton(onPressed: clicked, icon: Image.asset(path)),
    );
  }
}
