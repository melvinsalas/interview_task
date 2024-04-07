import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:interview_task/bloc/auth_bloc.dart';

class StreamAuthScope extends InheritedNotifier<StreamAuthNotifier> {
  StreamAuthScope({super.key, required super.child}) : super(notifier: StreamAuthNotifier());

  static StreamAuth of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StreamAuthScope>()!.notifier!.streamAuth;
  }
}

class StreamAuthNotifier extends ChangeNotifier {
  StreamAuthNotifier() : streamAuth = StreamAuth() {
    streamAuth.onCurrentUserChanged.listen((String? string) {
      notifyListeners();
    });
  }
  final StreamAuth streamAuth;
}

class StreamAuth {
  StreamAuth() : _userStreamController = StreamController<String?>.broadcast() {
    _userStreamController.stream.listen((String? currentUser) {
      _currentUser = currentUser;
    });
  }

  String? get currentUser => _currentUser;
  String? _currentUser;

  bool isSignedIn() {
    // GetIt.I<AuthBloc>().add(LoginByTokenEvent());

    return _currentUser != null;
  }

  Stream<String?> get onCurrentUserChanged => _userStreamController.stream;
  final StreamController<String?> _userStreamController;

  Future<void> signIn(String newUserName) async {
    _userStreamController.add(newUserName);
  }

  Future<void> signOut() async {
    _userStreamController.add(null);
  }
}
