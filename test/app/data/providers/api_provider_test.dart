import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habit_tracker/app/data/providers/api_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock implements QueryDocumentSnapshot {
  final Map<String, dynamic> _data;
  final String _id;

  MockDocumentSnapshot(this._data, this._id);

  @override
  Map<String, dynamic> data() => _data;

  @override
  String get id => _id;
}

class MockUser extends Mock implements User {
  @override
  String get email => 'test@example.com';

  @override
  String get uid => '12345';
}

class MockUserCredential extends Mock implements UserCredential {
  final User _user;

  MockUserCredential({User? user}) : _user = user ?? MockUser();

  @override
  User get user => _user;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ApiProvider apiProvider;
  late MockFirebaseAuth mockAuth;
  late MockFirestore mockFirestore;
  late MockCollectionReference mockCollectionReference;
  late MockDocumentReference mockDocumentReference;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();

    ApiProvider.auth = mockAuth;
    ApiProvider.firestore = mockFirestore;

    apiProvider = ApiProvider();

    Get.testMode = true;
  });

  group('Firebase Auth Tests', () {
    test('Sign up with email success', () async {
      final userCredential = MockUserCredential(user: MockUser());
      when(mockAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).thenAnswer((_) async => userCredential);

      final user =
          await apiProvider.signUpWithEmail('test@example.com', 'password123');
      expect(user?.email, equals('test@example.com'));
    });

    test('Sign up with email failure', () async {
      final exception = FirebaseAuthException(
        code: 'weak-password',
        message: 'Password is too weak',
      );

      when(mockAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'weak',
      )).thenThrow(exception);

      final user =
          await apiProvider.signUpWithEmail('test@example.com', 'weak');
      expect(user, isNull);
      expect(Get.isSnackbarOpen, isTrue);
    });

    test('Sign in with email success', () async {
      final userCredential = MockUserCredential(user: MockUser());
      when(mockAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).thenAnswer((_) async => userCredential);

      final user =
          await apiProvider.signInWithEmail('test@example.com', 'password123');
      expect(user?.email, equals('test@example.com'));
    });

    test('Sign out success', () async {
      await apiProvider.signOut();
      verify(mockAuth.signOut()).called(1);
    });
  });

  group('Habit Tracker Tests', () {
    const String userId = 'testUserId';

    // test('Create habit success', () async {
    //   final habitData = {
    //     'name': 'Exercise',
    //     'description': 'Daily workout',
    //   };
    //
    //   when(mockFirestore.collection('users'))
    //       .thenReturn(mockCollectionReference);
    //   when(mockCollectionReference.doc(userId).collection('habits'))
    //       .thenReturn(mockCollectionReference);
    //
    //   await apiProvider.createHabit(userId, habitData);
    //
    //   verify(mockCollectionReference
    //           .doc(userId)
    //           .collection('habits')
    //           .add(habitData))
    //       .called(1);
    //
    //   expect(Get.isSnackbarOpen, isTrue);
    // });
    //
    // test('Get habits success', () async {
    //   final mockHabits = [
    //     {'id': 'habit1', 'name': 'Exercise', 'description': 'Daily workout'},
    //     {'id': 'habit2', 'name': 'Reading', 'description': 'Read books'},
    //   ];
    //
    //   final mockDocs = mockHabits
    //       .map((habit) => MockDocumentSnapshot(
    //             Map<String, dynamic>.from(habit)..remove('id'),
    //             habit['id'] as String,
    //           ))
    //       .toList();
    //
    //   final mockQuerySnapshot = MockQuerySnapshot();
    //   when(mockQuerySnapshot.docs).thenReturn(
    //       mockDocs.cast<QueryDocumentSnapshot<Map<String, dynamic>>>());
    //
    //   when(mockFirestore
    //           .collection('users')
    //           .doc(userId)
    //           .collection('habits')
    //           .get())
    //       .thenAnswer((_) async => mockQuerySnapshot);
    //
    //   final habits = await apiProvider.getHabits(userId);
    //
    //   expect(habits.length, equals(2));
    //   expect(habits.first['id'], equals('habit1'));
    //   expect(habits.first['name'], equals('Exercise'));
    // });

    // test('Get habits error', () async {
    //   when(mockFirestore
    //           .collection('users')
    //           .doc(userId)
    //           .collection('habits')
    //           .get())
    //       .thenThrow(Exception('Database error'));
    //
    //   final habits = await apiProvider.getHabits(userId);
    //
    //   expect(habits, isEmpty);
    //   expect(Get.isSnackbarOpen, isTrue);
    // });

    // test('Update habit success', () async {
    //   final habitData = {
    //     'name': 'Updated Exercise',
    //     'description': 'Updated workout routine',
    //   };
    //
    //   when(mockFirestore
    //           .collection('users')
    //           .doc(userId)
    //           .collection('habits')
    //           .doc('habit1'))
    //       .thenReturn(mockDocumentReference);
    //
    //   await apiProvider.updateHabit(userId, 'habit1', habitData);
    //
    //   verify(mockDocumentReference.update(habitData)).called(1);
    //   expect(Get.isSnackbarOpen, isTrue);
    // });

    // test('Delete habit success', () async {
    //   when(mockFirestore
    //           .collection('users')
    //           .doc(userId)
    //           .collection('habits')
    //           .doc('habit1'))
    //       .thenReturn(mockDocumentReference);
    //
    //   await apiProvider.deleteHabit(userId, 'habit1');
    //
    //   verify(mockDocumentReference.delete()).called(1);
    //   expect(Get.isSnackbarOpen, isTrue);
    // });
  });

  tearDown(() {
    Get.reset();
  });
}
