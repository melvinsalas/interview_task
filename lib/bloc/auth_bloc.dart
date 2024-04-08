import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/models/auth_request.dart';
import 'package:interview_task/models/auth_response.dart';
import 'package:interview_task/utils/token_storage.dart';
import 'package:interview_task/utils/urls.dart';
import 'package:logger/logger.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(UnauthenticatedState()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<LoginByTokenEvent>(_onLoginByToken);
    onAppStart();
  }

  void onAppStart() {
    final token = TokenStorage.getToken();
    if (token != null) {
      add(LoginByTokenEvent());
    } else {
      add(LogoutEvent());
    }
  }

  Future<void> _onLoginByToken(_, Emitter<AuthState> emit) async {
    try {
      Logger().i('Login by token');

      final token = TokenStorage.getToken();
      final response = await http.get(
        Uri.parse(aboutMe),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        Logger().i('Error: ${response.statusCode}');
        TokenStorage.deleteToken();
        emit(UnauthenticatedState());
        return;
      }

      final responseData = json.decode(response.body);
      final authResponse = AuthResponse.fromJson(responseData);
      emit(AuthenticatedState(authResponse));
    } catch (e) {
      Logger().e('Error: $e');
      emit(AuthErrorState('Error: $e'));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) {
    TokenStorage.deleteToken();
    emit(UnauthenticatedState());
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      final request = AuthRequest(
        username: event.username,
        password: event.password,
        expiresInMins: 5,
      );

      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode != 200) {
        Logger().i('Error: ${response.statusCode}');
        try {
          var message = json.decode(response.body)['message'];
          emit(AuthErrorState(message));
          return;
        } catch (e) {
          Logger().e('Error: $e');
          emit(AuthErrorState('Error: $e'));
          return;
        }
      }

      final responseData = json.decode(response.body);
      final authResponse = AuthResponse.fromJson(responseData);

      /// Save token into web storage
      TokenStorage.saveToken(token: authResponse.token);
      emit(AuthenticatedState(authResponse));
    } catch (e) {
      Logger().e('Error: $e');
      emit(AuthErrorState('Error: $e'));
    }
  }
}

/// EVENTS

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});
}

class LogoutEvent extends AuthEvent {}

class LoginByTokenEvent extends AuthEvent {}

/// STATES

abstract class AuthState {}

class AuthInitState extends AuthState {}

class AuthLoadingState extends AuthState {}

class UnauthenticatedState extends AuthState {}

class AuthLoadingTokenState extends AuthState {}

class AuthenticatedState extends AuthState {
  final AuthResponse response;

  AuthenticatedState(this.response);
}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState(this.message);
}
