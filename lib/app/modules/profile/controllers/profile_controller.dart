import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/app/data/providers/api_provider.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  final ApiProvider apiProvider = ApiProvider();

  void logOut() {
    apiProvider.signOut();
    Get.offAllNamed(Routes.SIGN_IN);
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
