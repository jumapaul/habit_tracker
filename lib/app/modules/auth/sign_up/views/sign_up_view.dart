import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_tracker/app/modules/auth/widgets/social_auth_widget.dart';

import '../../../../common/dimens/dimens.dart';
import '../../../../routes/app_pages.dart';
import '../../../common_widget/outlined_button_widget.dart';
import '../../widgets/outlined_input_text_widget.dart';
import '../../widgets/password_textfield_widget.dart';
import '../../widgets/sign_in_and_up_row.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(mediumSize),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: extraLargeSize),
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/app_icon.png",
                        width: 180,
                        height: 108,
                      ),
                    ),
                    const SizedBox(height: mediumSize),
                    Text(
                      "Sign up",
                      style: AppTextStyles.headerStyle,
                    ),
                    const SizedBox(height: mediumSize),
                    Text(
                      "Create an account to get started",
                      style: AppTextStyles.subHeaderStyle,
                    ),
                    const SizedBox(height: mediumSize),
                    OutlinedInputTextFieldWidget(
                      hintText: "Input Email Address",
                      labelText: "Email address",
                      errorText: controller.emailErrorMessage?.value,
                      editingController: controller.emailAddressController,
                    ),
                    const SizedBox(height: mediumSize),
                    PasswordTextFieldWidget(
                      hintText: "Input Password",
                      labelText: "Password",
                      errorText: controller.passwordErrorMessage?.value,
                      passwordTextEditController: controller.passwordController,
                    ),
                    const SizedBox(height: mediumSize),
                    PasswordTextFieldWidget(
                      hintText: "Confirm Password",
                      labelText: "Confirm password",
                      errorText: controller.confirmErrorMessage?.value,
                      passwordTextEditController:
                          controller.confirmPasswordController,
                    ),
                    const SizedBox(height: mediumSize),
                    SignInAndUpRow(
                      desc: "By signing up you agree to our ",
                      action: "Terms and conditions",
                      onClick: () {
                        // Handle terms and conditions click
                      },
                    ),
                    const SizedBox(height: largeSize),
                    OutlinedButtonWidget(
                      onClick: () {
                        controller.signUpUserWithEmailAndPassword();
                      },
                      name: 'Sign Up',
                      child: controller.isLoading.value
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
                    SocialAuthWidget(onGoogleTap: () {
                      controller.signUpWithGoogle();
                    }),
                    const SizedBox(height: mediumSize),
                    SignInAndUpRow(
                      desc: "Already a member? ",
                      action: "Login",
                      onClick: () {
                        Get.toNamed(Routes.SIGN_IN);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
