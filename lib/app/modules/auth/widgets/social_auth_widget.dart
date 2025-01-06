import 'package:flutter/material.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: onGoogleTap,
              child: _buildSocialAuth('Google', 'assets/images/google.png'),
            ),
            _buildSocialAuth('Facebook', 'assets/images/facebook.png')
          ],
        ),
      ],
    );
  }

  _buildSocialAuth(String title, String path) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: Image.asset(path),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: AppTextStyles.subHeaderStyle,
        )
      ],
    );
  }
}
