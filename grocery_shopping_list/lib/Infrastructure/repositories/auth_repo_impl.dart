import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'package:flutter/material.dart';
import '../api_service.dart'; 

import 'Auth_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SharedPreferences _prefs;
  final ApiService _apiService;

  AuthRepositoryImpl(this._prefs, this._apiService); // Constructor


  @override
  Future<void> signUp(String username, String password, String role,
      BuildContext context) async {
    await _apiService.signUp(username, password, role);
  }

  @override
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('access_token', value);
  }

  @override
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  @override
  Future<bool> setID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('id', value);
  }

  @override
  Future<String?> getID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  @override
  Future<void> logout() async {
    await _prefs.clear();
  }

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.182:6036/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody);
        final token = responseBody['access_token'];
        print(token);
        final userId = responseBody['id'];

        await setToken(token);
        await setID(userId);
        // print(token);

        final role = _decodeRoleFromToken(token);
        print(token);
        return (token);
        // _navigateToRolePage(role, context);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      // print('Error: $e');
      throw Exception('Network error: Failed to login');
    }
  }

  String _decodeRoleFromToken(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken['role'];
    } catch (e) {
      throw Exception('Failed to decode token');
    }
  }

}
