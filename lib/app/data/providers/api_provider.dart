import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/app/common/utils/show_toast.dart';
import 'package:habit_tracker/app/data/models/habit_activity.dart';
import '../../routes/app_pages.dart';
import '../models/habit.dart';

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
      Get.offAllNamed(Routes.SELECT_HABITS);
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
      Get.offAllNamed(Routes.SELECT_HABITS);
      return userCredential.user;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<List<HabitTypes>?> getDefaultHabits() async {
    try {
      final snapShot =
          await FirebaseFirestore.instance.collection('habits').get();

      print('Number of docs --------->${snapShot.docs.length}');
      return snapShot.docs
          .map((doc) => HabitTypes.fromJson(doc.data(), docId: doc.id))
          .toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print('----------> the error is ${e.toString()}');
      return null;
    }
  }

  Future<void> uploadSelectedHabits(List<HabitTypes> selectedHabits) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      final habitsRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('selected_habits');

      final batch = FirebaseFirestore.instance.batch();

      for (var habit in selectedHabits) {
        final newHabit = habit.copyWith(id: userId);
        final docRef = habitsRef.doc();
        batch.set(docRef, newHabit.toJson());
      }

      await batch.commit();
      Get.offAllNamed(Routes.MAIN);
    } catch (error) {
      Get.snackbar('error', error.toString());
    }
  }

  Future<List<HabitTypes>?> getSelectedHabits() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final selectedHabitsRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('selected_habits');

      final selectedHabitsSnapshot = await selectedHabitsRef.get();

      return selectedHabitsSnapshot.docs
          .map((doc) => HabitTypes.fromJson(doc.data(), docId: doc.id))
          .toList();
    } catch (e) {
      Get.snackbar('error', e.toString());
      return null;
    }
  }

  Future<void> createActivity(String userId, HabitActivity activity) async {
    try {
      DocumentReference docRef = await firestore
          .collection('activities')
          .doc(userId)
          .collection('daily_activities')
          .add(activity.toJson());

      activity.docId = docRef.id;
      await docRef.update({'doc_id': activity.docId});
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateActivity(String userId, String docId, bool isComplete,
      String activityTitle) async {
    try {
      await firestore
          .collection('activities')
          .doc(userId)
          .collection('daily_activities')
          .doc(docId)
          .update({'is_completed': isComplete});
      if (isComplete) {
        Get.snackbar('Success', 'Congratulation on completing $activityTitle');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<List<HabitActivity>?> getActivitiesByDate(
      String userId, DateTime date) async {
    try {
      final localMidnight =
          DateTime(date.year, date.month, date.day, 0, 0, 0, 0).toLocal();

      String formattedDate = "${localMidnight.year}-"
          "${localMidnight.month.toString().padLeft(2, '0')}-"
          "${localMidnight.day.toString().padLeft(2, '0')}";

      QuerySnapshot querySnapshot = await firestore
          .collection('activities')
          .doc(userId)
          .collection('daily_activities')
          .where('activity_date', isEqualTo: formattedDate)
          .get();

      List<HabitActivity> activities = querySnapshot.docs
          .map((doc) =>
              HabitActivity.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return activities;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  Future<List<HabitActivity>?> getActivityByWeek(
      String userId, DateTime weekEnd) async {
    try {
      final weekStart = weekEnd.subtract(Duration(days: 6));

      String endDate = "${weekEnd.year}-"
          "${weekEnd.month.toString().padLeft(2, '0')}-"
          "${weekEnd.day.toString().padLeft(2, '0')}";

      String startDate = "${weekStart.year}-"
          "${weekStart.month.toString().padLeft(2, '0')}-"
          "${weekStart.day.toString().padLeft(2, '0')}";

      QuerySnapshot querySnapshot = await firestore
          .collection('activities')
          .doc(userId)
          .collection('daily_activities')
          .where('activity_date', isGreaterThanOrEqualTo: startDate)
          .where('activity_date', isLessThanOrEqualTo: endDate)
          .get();

      List<HabitActivity> activities = querySnapshot.docs
          .map((doc) =>
              HabitActivity.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return activities;
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return null;
    }
  }

  Future<List<HabitActivity>?> getActivityByMonth(
      String userId, DateTime currentDate) async {
    try {
      final firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
      final lastDayOfMonth = DateTime(
          currentDate.year, currentDate.month + 1, 0);

      String startDate = "${firstDayOfMonth.year}-"
          "${firstDayOfMonth.month.toString().padLeft(2, '0')}-"
          "${firstDayOfMonth.day.toString().padLeft(2, '0')}";

      String endDate = "${lastDayOfMonth.year}-"
          "${lastDayOfMonth.month.toString().padLeft(2, '0')}-"
          "${lastDayOfMonth.day.toString().padLeft(2, '0')}";

      QuerySnapshot querySnapshot = await firestore
          .collection('activities')
          .doc(userId)
          .collection('daily_activities')
          .where('activity_date', isGreaterThanOrEqualTo: startDate)
          .where('activity_date', isLessThanOrEqualTo: endDate)
          .get();

      List<HabitActivity> activities = querySnapshot.docs
          .map((doc) =>
          HabitActivity.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return activities;
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return null;
    }
  }

}
