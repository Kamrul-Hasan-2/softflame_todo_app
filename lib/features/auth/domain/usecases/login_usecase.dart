import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  const LoginUseCase(this.repository);

  Future<UserEntity> call({
    required String phoneNumber,
    required String pin,
  }) async {
    return await repository.login(phoneNumber, pin);
  }
}
