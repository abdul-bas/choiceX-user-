

abstract class EditProfileLogic {
  
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'Username cannot be empty';
    if (value.trim().length < 3) return 'Username must be at least 3 characters';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email cannot be empty';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

 
  static String avatarInitial(String name) =>
      name.isNotEmpty ? name[0].toUpperCase() : '?';

      
}