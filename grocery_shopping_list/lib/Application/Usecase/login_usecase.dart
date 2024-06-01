import 'package:flutter/material.dart';
import '../../Infrastructure/repositories/Auth_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Map<String, dynamic>> call(String username, String password) async {
    return repository.login(username, password);
  }

  String? _token;

  Future<void> setToken(String token) async {
    _token = token;
  }

  Future<String> get token async {
    return _token ?? '';
  }

  Future<void> setID(String id) async {
    await repository.setID(id);
  }
}


abstract class LogoutUseCase {
  Future<void> call();
}


class SignUpUseCase {
  Future<void> call(String username, String password, String role, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:6036/user/signup'), // Replace with your API endpoint
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'role': role,
        }),
      );

      if (response.statusCode == 201) {
        // User created successfully
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      print('Error signing up: $e'); // Print the error
      throw Exception('Failed to create user');
    }
  }
}
class LogoutUseCaseImpl implements LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCaseImpl(this._authRepository);

  @override
  Future<void> call() async {
    // Implement the logout logic here
    await _authRepository.logout();
  }
}