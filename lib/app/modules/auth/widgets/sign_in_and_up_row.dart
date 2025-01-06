import 'package:flutter/material.dart';

import '../../../common/dimens/dimens.dart';

class SignInAndUpRow extends StatelessWidget {
  final String desc;
  final String action;
  final VoidCallback onClick;

  const SignInAndUpRow(
      {super.key,
        required this.desc,
        required this.action,
        required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          desc,
          style: AppTextStyles.subHeaderStyle,
        ),
        GestureDetector(
          onTap: onClick,
          child: Text(
            action,
            style: const TextStyle(
                color: Color(0xFF3464B8),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        ),
      ],
    );
  }
}