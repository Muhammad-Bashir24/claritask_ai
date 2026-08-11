class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    if (!regex.hasMatch(value.trim())) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    // Minimum 8 characters (alphanumeric + symbols)
    final hasMinLength = value.length >= 8;
    // At least one uppercase letter
    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    // At least one lowercase letter
    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    // At least one number
    final hasDigit = value.contains(RegExp(r'[0-9]'));
    // At least one special character
    final hasSpecialChar = value.contains(RegExp(r'[^A-Za-z0-9]'));

    if (!hasMinLength) {
      return "Password must be at least 8 characters";
    }
    if (!hasUppercase) {
      return "Password must contain at least one uppercase letter";
    }
    if (!hasLowercase) {
      return "Password must contain at least one lowercase letter";
    }
    if (!hasDigit) {
      return "Password must contain at least one number";
    }
    if (!hasSpecialChar) {
      return "Password must contain at least one special character";
    }

    return null;
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (password != confirmPassword) {
      return "Passwords do not match";
    }

    return null;
  }
}
