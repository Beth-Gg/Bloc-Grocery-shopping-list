import 'package:flutter/material.dart';
import '../api_service.dart';

abstract class AuthRepository {
  Future<String?> getToken();
  Future<String?> getID();
  Future<bool> setToken(String value);
  Future<bool> setID(String value);
  Future<void> logout();
  Future<Map<String, dynamic>> login(String username, String password);
  Future<void> signUp(String username, String password, String role, BuildContext context);
}

class ConcreteAuthRepository implements AuthRepository {
  final ApiService authApiService;

  ConcreteAuthRepository(this.authApiService);

  @override
  Future<String?> getToken() async {
    
    throw UnimplementedError();
  }

  @override
  Future<String?> getID() async {
    
    throw UnimplementedError();
  }

  @override
  Future<bool> setToken(String value) async {
   
    throw UnimplementedError();
  }

  @override
  Future<bool> setID(String value) async {
    // Implement setID method
   
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
   
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(String username, String password, String role, BuildContext context) async {
   
    throw UnimplementedError();
  }
}