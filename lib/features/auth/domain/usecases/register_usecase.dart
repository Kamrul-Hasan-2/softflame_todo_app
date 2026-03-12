import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  const RegisterUseCase(this.repository);

  Future<UserEntity> call({
    required String phoneNumber,
    required String pin,
    String? name,
    String? email,
  }) async {
    return await repository.register(
      phoneNumber: phoneNumber,
      pin: pin,
      name: name,
      email: email,
    );
  }
}
