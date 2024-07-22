class Validation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (value.length < 6 || value.length > 30) {
      return 'Email should be between 6 and 30 characters';
    }
    final emailRegEx = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]{1,30}@[a-zA-Z0-9-]{1,10}(?:\.[a-zA-Z0-9-]{2,10})+$");
    if (!emailRegEx.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6 || value.length > 10) {
      return 'Password should be between 6 and 10 characters';
    }
    final passwordRegEx = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).+$');
    if (!passwordRegEx.hasMatch(value)) {
      return 'Password must contain uppercase, lowercase letters and a digit';
    }
    return null;
  }
}
