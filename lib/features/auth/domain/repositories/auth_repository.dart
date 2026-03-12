import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Login user with phone number and PIN
  Future<UserEntity> login(String phoneNumber, String pin);

  /// Register new user
  Future<UserEntity> register({
    required String phoneNumber,
    required String pin,
    String? name,
    String? email,
  });

  /// Logout current user
  Future<void> logout();

  /// Get current logged in user
  Future<UserEntity?> getCurrentUser();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Reset PIN
  Future<void> resetPin(String phoneNumber);
}
