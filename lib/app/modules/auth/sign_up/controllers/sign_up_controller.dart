import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/app/common/utils/validations.dart';
import 'package:habit_tracker/app/data/providers/api_provider.dart';

import '../../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rxn<String>? emailErrorMessage = Rxn();
  Rxn<String>? confirmErrorMessage = Rxn();
  Rxn<String>? passwordErrorMessage = Rxn();

  final ApiProvider apiProvider = ApiProvider();

  var isLoading = false.obs;

  signUpUserWithEmailAndPassword() async {
    bool isEmailValid =
        Validations.validEmail(emailAddressController.text, emailErrorMessage);
    bool passwordValid = Validations.isPasswordValid(passwordController.text, passwordErrorMessage);
    bool passwordSame = confirmPassword(
        passwordController.text, confirmPasswordController.text);

    if (isEmailValid && passwordValid && passwordSame) {
      apiProvider.signUpWithEmail(
          emailAddressController.text, passwordController.text);
    } else {
      return;
    }
  }

  Future<User?> signUpWithGoogle() async {
    final user = await apiProvider.signInWithGoogle();

    return user;
  }
  bool confirmPassword(String password, String confirmPassword) {
    bool isSame = password == confirmPassword;

    if (password.isNotEmpty && confirmPassword.isNotEmpty && !isSame) {
      confirmErrorMessage?.value = "Confirm password not same as password";
      return false;
    }
    return true;
  }

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
