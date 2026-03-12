import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';

class AuthLocalDataSource {
  static const String _keyCurrentUser = 'current_user';
  static const String _keyUsers = 'users';
  static const String _keyIsLoggedIn = 'is_logged_in';

  final SharedPreferences _preferences;

  AuthLocalDataSource(this._preferences);

  /// Login user with phone number and PIN
  Future<UserModel> login(String phoneNumber, String pin) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Get all registered users
    final users = await _getAllUsers();

    // Find user with matching phone number and PIN
    final user = users.firstWhere(
      (u) => u.phoneNumber == phoneNumber && _verifyPin(u.id, pin),
      orElse: () => throw Exception('Invalid phone number or PIN'),
    );

    // Save current user and login status
    await _saveCurrentUser(user);
    await _preferences.setBool(_keyIsLoggedIn, true);

    return user;
  }

  /// Register new user
  Future<UserModel> register({
    required String phoneNumber,
    required String pin,
    String? name,
    String? email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Check if phone number already exists
    final users = await _getAllUsers();
    final exists = users.any((u) => u.phoneNumber == phoneNumber);

    if (exists) {
      throw Exception('Phone number already registered');
    }

    // Create new user
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      phoneNumber: phoneNumber,
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );

    // Save PIN separately (in real app, should be hashed)
    await _savePin(newUser.id, pin);

    // Add to users list
    users.add(newUser);
    await _saveAllUsers(users);

    // Set as current user
    await _saveCurrentUser(newUser);
    await _preferences.setBool(_keyIsLoggedIn, true);

    return newUser;
  }

  /// Logout current user
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 100));
    await _preferences.remove(_keyCurrentUser);
    await _preferences.setBool(_keyIsLoggedIn, false);
  }

  /// Get current logged in user
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final userJson = _preferences.getString(_keyCurrentUser);

    if (userJson == null) return null;

    try {
      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _preferences.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Reset PIN (placeholder implementation)
  Future<void> resetPin(String phoneNumber) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // In real app, would send OTP/email verification
    throw UnimplementedError('Reset PIN functionality not yet implemented');
  }

  // Helper methods
  Future<List<UserModel>> _getAllUsers() async {
    final usersJson = _preferences.getString(_keyUsers);
    if (usersJson == null) return [];

    try {
      final List<dynamic> usersList = json.decode(usersJson);
      return usersList
          .map((u) => UserModel.fromJson(u as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveAllUsers(List<UserModel> users) async {
    final usersJson = json.encode(users.map((u) => u.toJson()).toList());
    await _preferences.setString(_keyUsers, usersJson);
  }

  Future<void> _saveCurrentUser(UserModel user) async {
    final userJson = json.encode(user.toJson());
    await _preferences.setString(_keyCurrentUser, userJson);
  }

  Future<void> _savePin(String userId, String pin) async {
    // In real app, should hash the PIN
    await _preferences.setString('pin_$userId', pin);
  }

  bool _verifyPin(String userId, String pin) {
    final storedPin = _preferences.getString('pin_$userId');
    return storedPin == pin;
  }
}
