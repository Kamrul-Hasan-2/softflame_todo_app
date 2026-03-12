import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthNotifier({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AuthState.initial()) {
    _checkAuthStatus();
  }

  /// Check if user is already logged in
  Future<void> _checkAuthStatus() async {
    try {
      final user = await getCurrentUserUseCase();
      if (user != null) {
        state = state.setAuthenticated(user);
      }
    } catch (e) {
      state = state.setUnauthenticated();
    }
  }

  /// Login with phone number and PIN
  Future<void> login({
    required String phoneNumber,
    required String pin,
  }) async {
    state = state.setLoading();

    try {
      final user = await loginUseCase(
        phoneNumber: phoneNumber,
        pin: pin,
      );

      state = state.setAuthenticated(user);
    } catch (e) {
      state = state.setError(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Register new user
  Future<void> register({
    required String phoneNumber,
    required String pin,
    String? name,
    String? email,
  }) async {
    state = state.setLoading();

    try {
      final user = await registerUseCase(
        phoneNumber: phoneNumber,
        pin: pin,
        name: name,
        email: email,
      );

      state = state.setAuthenticated(user);
    } catch (e) {
      state = state.setError(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Logout current user
  Future<void> logout() async {
    state = state.setLoading();

    try {
      await logoutUseCase();
      state = state.setUnauthenticated();
    } catch (e) {
      state = state.setError(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
