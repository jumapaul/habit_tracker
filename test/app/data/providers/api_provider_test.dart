import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/app/routes/app_pages.dart';
import 'package:mockito/mockito.dart';
import 'package:habit_tracker/app/data/providers/api_provider.dart';

// Mock classes
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {
  @override
  String get uid => 'test-uid';

  @override
  String? get email => 'test@example.com';
}

class MockUserCredential extends Mock implements UserCredential {
  final User? mockUser;

  MockUserCredential({this.mockUser});

  @override
  User? get user => mockUser;
}

class MockApiProvider extends ApiProvider {
  MockApiProvider({
    required FirebaseAuth mockAuth,
  }) {
    ApiProvider.auth = mockAuth;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFirebaseAuth mockAuth;
  late ApiProvider apiProvider;

  setUp(() {
    // Initialize mocks and objects
    mockAuth = MockFirebaseAuth();
    apiProvider = MockApiProvider(mockAuth: mockAuth);

    // Stub default behavior for FirebaseAuth methods
    when(mockAuth.authStateChanges()).thenAnswer((_) => const Stream.empty());

    // Setup GetX test environment
    Get.testMode = true;
    Get.reset();
  });

  tearDown(() {
    // Cleanup after each test
    Get.reset();
  });

  group('signUpWithEmail', () {
    const email = 'test@example.com';
    const password = 'password123';

    test('should sign up successfully', () async {
      // Arrange
      final mockUser = MockUser();
      final mockUserCredential = MockUserCredential(mockUser: mockUser);

      // Mock `createUserWithEmailAndPassword` behavior
      when(mockAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).thenAnswer((_) async => mockUserCredential);

      // Act
      final result = await apiProvider.signUpWithEmail(email, password);

      // Assert
      expect(result, isA<User>());
      verify(mockAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).called(1);

      // Verify snackbar and navigation
      expect(Get.isSnackbarOpen, true);
      expect(Get.currentRoute, Routes.SIGN_IN); // Replace with actual route
    });

    test('should handle signup failure', () async {
      // Arrange
      when(mockAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).thenThrow(FirebaseAuthException(
        code: 'email-already-in-use',
        message: 'The email is already registered',
      ));

      // Act
      final result = await apiProvider.signUpWithEmail(email, password);

      // Assert
      expect(result, null);
      verify(mockAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).called(1);

      expect(Get.isSnackbarOpen, true);
    });

    group('should handle various Firebase exceptions', () {
      final testCases = [
        {
          'code': 'weak-password',
          'message': 'The password is too weak',
        },
        {
          'code': 'invalid-email',
          'message': 'The email address is invalid',
        },
        {
          'code': 'operation-not-allowed',
          'message': 'Email/password accounts are not enabled',
        },
      ];

      for (final testCase in testCases) {
        test('handles ${testCase['code']} error', () async {
          // Arrange
          when(mockAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(FirebaseAuthException(
            code: testCase['code']!,
            message: testCase['message'],
          ));

          // Act
          final result = await apiProvider.signUpWithEmail(email, password);

          // Assert
          expect(result, null);
          verify(mockAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )).called(1);

          expect(Get.isSnackbarOpen, true);
        });
      }
    });
  });
}
