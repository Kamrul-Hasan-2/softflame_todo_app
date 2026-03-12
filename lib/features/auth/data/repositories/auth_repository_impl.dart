import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  const AuthRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<UserEntity> login(String phoneNumber, String pin) async {
    try {
      final userModel = await localDataSource.login(phoneNumber, pin);
      return userModel.toEntity();
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity> register({
    required String phoneNumber,
    required String pin,
    String? name,
    String? email,
  }) async {
    try {
      final userModel = await localDataSource.register(
        phoneNumber: phoneNumber,
        pin: pin,
        name: name,
        email: email,
      );
      return userModel.toEntity();
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await localDataSource.logout();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getCurrentUser();
      return userModel?.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      return await localDataSource.isLoggedIn();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> resetPin(String phoneNumber) async {
    try {
      await localDataSource.resetPin(phoneNumber);
    } catch (e) {
      throw Exception('Reset PIN failed: ${e.toString()}');
    }
  }
}
