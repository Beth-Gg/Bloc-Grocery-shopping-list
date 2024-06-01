import 'package:flutter/material.dart';

class User {
  final String? username;
  final String? location;
  final List ?items;

  User({required this.username, required this.location, required this.items});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      location: json['location'],
      items: json['items'],
    );
  }
}