import '../firebase_store/fire_base_auth.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'E-mail address is required.';

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Invalid E-mail Address format.';

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required.';

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return '''
      Password must be at least 8 characters,
      include an uppercase letter, number and symbol.
      ''';

    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Password is required.';
  }
}
