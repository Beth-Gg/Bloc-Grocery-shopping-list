import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../lib/Application/bloc/Login/Login_bloc.dart';
import '../lib/Application/bloc/Login/Login_event.dart';
import '../lib/Application/bloc/Login/Login_state.dart';

import '../lib/Infrastructure/api_service.dart';
import 'package:signup/Infrastructure/models/user.dart';



class MockApiService extends Mock implements ApiService {
 
  @override
  Future<http.Response> login(String ?username, String ?password) async {
    return Future.value(http.Response(jsonEncode({'username': 'username', 'password': 'test_password'}), 201));
  }
}

void main() {
  group('AuthBloc', () {
    late MockApiService apiService;
    late AuthBloc authBloc;

    setUp(() {
      apiService = MockApiService();
      authBloc = AuthBloc(apiService: apiService);
    });

    test('initial state is AuthState', () {
      expect(authBloc.state, AuthState());
    });

   blocTest<AuthBloc, AuthState>(
  'emits AuthState with isLoading true when LoginEvent is added',
  build: () => authBloc,
  act: (bloc) => bloc.add(LoginEvent(username: 'username', password: 'password')),
  expect: () => [
    AuthState(isLoading: true),
    AuthState(isLoading: false, isLoggedIn: true, user: User.fromJson({'username': 'username', 'password': 'test_password'})),
  ],
);

    
blocTest<AuthBloc, AuthState>(
  'emits AuthState with isLoggedIn true when login is successful',
  build: () => authBloc,
  setUp: () {
    when(apiService.login('username', 'password')).thenAnswer((_) async =>
        http.Response(
          jsonEncode({'username': 'username', 'password': 'test_password'}),
          200,
        ));
  },
  act: (bloc) => bloc.add(LoginEvent(username: 'username', password: 'password')),
  expect: () => [
    AuthState(isLoading: true),
    AuthState(isLoggedIn: true, user: User.fromJson({'username': 'username', 'password': 'test_password'})),
  ],
  verify: (_) {
    // Verify that login method was called exactly once
    verify(apiService.login('username', 'password')).called(1);
  },
);

    // Test SignUpEvent, NavigateToNextPage, and other events similarly
  });

  group('RoleBloc', () {
    late RoleBloc roleBloc;

    setUp(() {
      roleBloc = RoleBloc();
    });

    test('initial state is RoleState with isAdmin false', () {
      expect(roleBloc.state, RoleState(isAdmin: false));
    });

    blocTest<RoleBloc, RoleState>(
      'emits RoleState with isAdmin true when ToggleAdminEvent is added',
      build: () => roleBloc,
      act: (bloc) => bloc.add(ToggleAdminEvent()),
      expect: () => [
        RoleState(isAdmin: true),
      ],
    );
  });
}