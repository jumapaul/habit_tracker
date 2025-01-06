import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Validations{
  static bool validEmail(String email, Rxn<String>? errorMessage) {
    bool isValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);

    if (email.isEmpty) {
      errorMessage?.value = "Email cannot be empty"; // Update the Rxn value
      return false;
    } else if (!isValid) {
      errorMessage?.value = "Invalid email format"; // Update the Rxn value
      return false;
    }

    errorMessage?.value = null; // Clear any previous error

    print('============>error message ${errorMessage?.value}');
    return true;
  }

  static bool isPasswordValid(String password, Rxn<String>? errorMessage) {
    if (password.isEmpty) {
      errorMessage?.value = "Password cannot be empty";
      return false;
    } else if (password.length < 6) {
      errorMessage?.value = "Password cannot be less than 6 characters";
      return false;
    }
    return true;
  }
}