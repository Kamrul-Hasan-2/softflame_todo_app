import '../../domain/entities/user_entity.dart';

class AuthState {
  final UserEntity? user;
  final bool isLoading;
  final bool isAuthenticated;
  final String? errorMessage;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.isAuthenticated = false,
    this.errorMessage,
  });

  AuthState copyWith({
    UserEntity? user,
    bool? isLoading,
    bool? isAuthenticated,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage,
    );
  }

  factory AuthState.initial() {
    return const AuthState();
  }

  AuthState setLoading() {
    return copyWith(isLoading: true, errorMessage: null);
  }

  AuthState setAuthenticated(UserEntity user) {
    return copyWith(
      user: user,
      isAuthenticated: true,
      isLoading: false,
      errorMessage: null,
    );
  }

  AuthState setUnauthenticated() {
    return const AuthState(
      user: null,
      isAuthenticated: false,
      isLoading: false,
      errorMessage: null,
    );
  }

  AuthState setError(String message) {
    return copyWith(
      isLoading: false,
      errorMessage: message,
    );
  }
}
