import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/app/common/utils/show_toast.dart';
import 'package:habit_tracker/app/common/utils/validations.dart';
import 'package:habit_tracker/app/data/providers/api_provider.dart';
import 'package:habit_tracker/app/routes/app_pages.dart';

class SignInController extends GetxController {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController resetEmailController = TextEditingController();

  Rxn<String>? emailErrorMessage = Rxn();
  Rxn<String>? resetEmailErrorMessage = Rxn();
  Rxn<String>? confirmErrorMessage = Rxn();
  Rxn<String>? passwordErrorMessage = Rxn();
  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  final ApiProvider apiProvider = ApiProvider();

  RxStatus get status => _status.value;

  Future<User?> signIn() async {
    bool passwordValid = Validations.isPasswordValid(
        passwordController.text, passwordErrorMessage);
    bool emailValid =
        Validations.validEmail(emailAddressController.text, emailErrorMessage);

    if (emailValid && passwordValid) {
      final user = apiProvider.signInWithEmail(
          emailAddressController.text, passwordController.text);
      return user;
    }
    return null;
  }

  Future<void> resetPasswordEmail() async {
    bool emailIsValid = Validations.validEmail(
        resetEmailController.text, resetEmailErrorMessage);

    if (emailIsValid) {
      await apiProvider.resetPassword(resetEmailController.text);
      Get.back();
    } else {
      showToast(resetEmailErrorMessage!.value!);
    }
    return;
  }

  Future<User?> signInWithGoogle() async {
    final user = await apiProvider.signInWithGoogle();

    return user;
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
