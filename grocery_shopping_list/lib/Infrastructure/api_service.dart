import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ApiService {
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('access_token', value);
  }

  Future<bool> setID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('id', value);
  }

  Future<http.Response> signUp(
      String? username, String? password, String? role) async {
    if (username == null || password == null || role == null) {
      throw Exception('Username, password, and role are required');
    }
    final url = 'http://localhost:6036/user/signup';
    final body = {
      'username': username,
      'password': password,
      'role': role,
    };
    final response = await http.post(Uri.parse(url), body: body);
    return response;
  }

  Future<http.Response> login(String? username, String? password) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:6036/auth/login'),
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

        // final role = _decodeRoleFromToken(token);
        print(token);
        return (response);
        // _navigateToRolePage(role, context);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      // print('Error: $e');
      throw Exception('Network error: Failed to login');
    }
  }
}
