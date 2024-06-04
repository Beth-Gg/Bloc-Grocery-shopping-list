import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:signup/Infrastructure/models/user.dart';
abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String username;
  final String password;
  final String role;

  SignUpEvent({required this.username, required this.password, required this.role});
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});
}
 class LoadingEvent extends AuthEvent {}

  class LoggedInEvent extends AuthEvent {
    final User user;

    LoggedInEvent({required this.user});

    @override
    List<Object?> get props => [user];
  }

  class LoginFailedEvent extends AuthEvent {
    final String error;

    LoginFailedEvent({required this.error});

    @override
    List<Object?> get props => [error];
  }

// RoleEvent
abstract class RoleEvent {}

class ToggleAdminEvent extends RoleEvent {}
class NavigateToNextPage extends AuthEvent {}

