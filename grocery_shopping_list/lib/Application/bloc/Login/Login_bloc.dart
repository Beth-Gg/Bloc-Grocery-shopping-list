import 'dart:async';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'Login_event.dart';
import 'Login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../../../Infrastructure/repositories/Auth_repository.dart';
import '../../../Application/Usecase/login_usecase.dart';
import 'package:http/http.dart' as http;
import '../../../Infrastructure/api_service.dart';
import 'package:signup/Infrastructure/models/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService _apiService;

  AuthBloc({required ApiService apiService})
      : _apiService = apiService,
        super(AuthState()) {
    on<LoginEvent>(_onLoginEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<NavigateToNextPage>(_onNavigateToNextPage);
  }
Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
  emit(AuthState(isLoading: true));
  try {
    final response = await _apiService.login(event.username, event.password);
    debugPrint('Login response status code: ${response.statusCode}');
    debugPrint('Login response body: ${response.body}');

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      debugPrint('Parsed response body: $responseBody');
      if (responseBody != null && responseBody is Map<String, dynamic>) {
        final user = User.fromJson(responseBody);
        emit(AuthState(isLoggedIn: true, user: user));
      } else {
        emit(AuthState(error: 'Invalid response format'));
      }
    } else {
      final responseBody = jsonDecode(response.body);
      debugPrint('Error response body: $responseBody');
      emit(AuthState(error: 'Login failed: ${responseBody['message']}'));
    }
  } catch (e) {
    debugPrint('Login error: $e');
    emit(AuthState(error: 'Login failed: $e'));
  }
}

  Future<void> _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthState(isLoading: true));
    try {
      final response = await _apiService.signUp(event.username, event.password, event.role);
      if (response.statusCode == 201) {
        final user = User.fromJson(jsonDecode(response.body));
        emit(AuthState(isLoggedIn: true, user: user));
      } else {
        emit(AuthState(error: 'Sign up failed'));
      }
    } catch (e) {
      emit(AuthState(error: 'Sign up failed'));
    }
  }

  void _onNavigateToNextPage(NavigateToNextPage event, Emitter<AuthState> emit) {
    emit(state.copyWith(isLoggedIn: true));
  }
}

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(RoleState(isAdmin: false)) {
    on<ToggleAdminEvent>(_onToggleAdminEvent);
  }

  void _onToggleAdminEvent(ToggleAdminEvent event, Emitter<RoleState> emit) {
    emit(RoleState(isAdmin: !state.isAdmin));
  }
}
