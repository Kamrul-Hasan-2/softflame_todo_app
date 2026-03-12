class Validators {
  // Email validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    
    return null;
  }

  // Password validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    return null;
  }

  // Phone number validator
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegex = RegExp(r'^[0-9]{10,15}$');
    
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  
  // Confirm password validator
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  // PIN validator (customizable length)
  static String? validatePin(String? value, {int length = 4}) {
    if (value == null || value.isEmpty) {
      return 'PIN is required';
    }
    
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'PIN must contain only numbers';
    }
    
    if (value.length != length) {
      return 'PIN must be $length digits';
    }
    
    return null;
  }

  // 4-digit PIN validator
  static String? validate4DigitPin(String? value) {
    return validatePin(value, length: 4);
  }

  // 6-digit PIN validator
  static String? validate6DigitPin(String? value) {
    return validatePin(value, length: 6);
  }

  // Confirm PIN validator
  static String? validateConfirmPin(String? value, String pin, {int length = 4}) {
    if (value == null || value.isEmpty) {
      return 'Confirm PIN is required';
    }
    
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'PIN must contain only numbers';
    }
    
    if (value.length != length) {
      return 'PIN must be $length digits';
    }
    
    if (value != pin) {
      return 'PINs do not match';
    }
    
    return null;
  }
}