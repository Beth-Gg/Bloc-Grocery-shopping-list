import 'package:equatable/equatable.dart';
import'../../../Infrastructure/models/user.dart';
class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final User? user;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    User? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading?? this.isLoading,
      isLoggedIn: isLoggedIn?? this.isLoggedIn,
      user: user?? this.user,
      error: error?? this.error,
    );
  }
}
// RoleState
class RoleState {
  final bool isAdmin;

  RoleState({required this.isAdmin});
}