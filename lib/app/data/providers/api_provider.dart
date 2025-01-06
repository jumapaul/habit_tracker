import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/app/common/utils/show_toast.dart';

import '../../routes/app_pages.dart';

class ApiProvider extends GetConnect {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {}

  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar('Success', 'Account created');
      Get.offAllNamed(Routes.SIGN_IN);
      return userCredential.user;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Login successful');
      Get.offAllNamed(Routes.MAIN);
      return userCredential.user;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      showToast('Reset link sent to your email');
    } catch (e) {
      showToast('Reset link sent to your email');
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      Get.snackbar('Success', 'Successfully logged in');
      Get.offAllNamed(Routes.MAIN);
      return userCredential.user;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<void> createHabit(
      String userId, Map<String, dynamic> habitData) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('habits')
          .add(habitData);
      Get.snackbar('Success', 'Habit created successfully!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateHabit(
      String userId, String habitId, Map<String, dynamic> habitData) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('habits')
          .doc(habitId)
          .update(habitData);
      Get.snackbar('Success', 'Habit updated successfully!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteHabit(String userId, String habitId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('habits')
          .doc(habitId)
          .delete();
      Get.snackbar('Success', 'Habit deleted successfully!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getHabits(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('habits')
          .get();

      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return [];
    }
  }
}
