import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../data/providers/api_provider.dart';
import '../data/providers/shared_preference.dart';
import '../modules/auth/sign_in/bindings/sign_in_binding.dart';
import '../modules/auth/sign_in/views/sign_in_view.dart';
import '../modules/auth/sign_up/bindings/sign_up_binding.dart';
import '../modules/auth/sign_up/views/sign_up_view.dart';
import '../modules/edit/bindings/edit_category_binding.dart';
import '../modules/edit/views/edit_category_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/select_habits/bindings/select_habits_binding.dart';
import '../modules/select_habits/views/select_habits_view.dart';
import '../modules/stats/bindings/stats_binding.dart';
import '../modules/stats/views/stats_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const signIn = Routes.SIGN_IN;
  static const main = Routes.MAIN;

  static Future<String> getInitialRoute() async {
    await Firebase.initializeApp();
    final user = await ApiProvider.auth.currentUser;

    return user != null ? main : signIn;
  }

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SCREEN,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
        name: _Paths.STATS,
        page: () => const StatsView(),
        binding: StatsBinding()),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_HABITS,
      page: () => const SelectHabitsView(),
      binding: SelectHabitsBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_CATEGORY,
      page: () => const EditCategoryView(),
      binding: EditCategoryBinding(),
    ),
  ];
}
