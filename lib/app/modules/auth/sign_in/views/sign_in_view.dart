import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_tracker/app/common/utils/show_toast.dart';
import 'package:habit_tracker/app/modules/auth/widgets/social_auth_widget.dart';

import '../../../../common/dimens/dimens.dart';
import '../../../../routes/app_pages.dart';
import '../../../common_widget/outlined_button_widget.dart';
import '../../widgets/sign_in_and_up_row.dart';
import '../../widgets/outlined_input_text_widget.dart';
import '../../widgets/password_textfield_widget.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var buttonState = controller.status;
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(mediumSize),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: extraLargeSize),
                  Image.asset('assets/images/app_icon.png'),
                  const SizedBox(height: mediumSize),
                  const Text(
                    "Welcome!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: largeSize),
                  ),
                  const SizedBox(height: extraLargeSize),
                  InputTextFieldWidget(
                    hintText: 'Email Address',
                    labelText: "Email address",
                    errorText: controller.emailErrorMessage?.value,
                    editingController: controller.emailAddressController,
                  ),
                  const SizedBox(height: mediumSize),
                  PasswordTextFieldWidget(
                    hintText: "Password",
                    labelText: "Password",
                    errorText: controller.passwordErrorMessage?.value,
                    passwordTextEditController: controller.passwordController,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          _buildDialog();
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12),
                        ),
                      )),
                  OutlinedButtonWidget(
                    onClick: () {
                      controller.signIn();
                    },
                    name: buttonState.isLoading ? null : "Continue",
                    child: buttonState.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(height: mediumSize),
                  SocialAuthWidget(
                    onGoogleTap: () {
                      controller.signInWithGoogle();
                    },
                  ),
                  const SizedBox(height: mediumSize),
                  SignInAndUpRow(
                    desc: 'Not a member? ',
                    action: "Sign Up",
                    onClick: () {
                      Get.toNamed(Routes.SIGN_UP);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  _buildDialog() {
    return Get.dialog(Dialog(
      insetPadding: EdgeInsets.all(10),
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter reset email'),
              AppTextStyles.mediumVerticalSpacing,
              InputTextFieldWidget(
                hintText: 'Enter email',
                labelText: 'Email address',
                editingController: controller.resetEmailController,
              ),
              AppTextStyles.mediumVerticalSpacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.resetEmailController.clear();
                        controller.emailErrorMessage?.value = null;
                        Get.back();
                      },
                      child: Text(
                        'Cancel',
                      )),
                  OutlinedButton(
                      onPressed: () {
                        controller.resetPasswordEmail();
                        controller.resetEmailController.clear();
                        Get.back();
                      },
                      child: Text('Reset'))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
