import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signup/presentation/list_page.dart';
import 'package:signup/presentation/signup_page.dart';
import 'package:signup/presentation/login_page.dart';
import 'package:signup/presentation/main_screen.dart';
import 'package:signup/presentation/shop_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      path: '/shops',
      builder: (context, state) => ShopPage(),
    ),
    GoRoute(
      path: '/lists',
      builder: (context, state) => GroceryListWidget(),
    ),
  ],
);
