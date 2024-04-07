import 'dart:async';

import 'package:flutter/material.dart';

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
  StreamAuth({
    this.refreshInterval = 20,
  }) : _userStreamController = StreamController<String?>.broadcast() {
    _userStreamController.stream.listen((String? currentUser) {
      _currentUser = currentUser;
    });
  }

  String? get currentUser => _currentUser;
  String? _currentUser;

  Future<bool> isSignedIn() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return _currentUser != null;
  }

  Stream<String?> get onCurrentUserChanged => _userStreamController.stream;
  final StreamController<String?> _userStreamController;

  final int refreshInterval;

  Timer? _timer;
  Timer _createRefreshTimer() {
    return Timer(Duration(seconds: refreshInterval), () {
      _userStreamController.add(null);
      _timer = null;
    });
  }

  Future<void> signIn(String newUserName) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    _userStreamController.add(newUserName);
    _timer?.cancel();
    _timer = _createRefreshTimer();
  }

  Future<void> signOut() async {
    _timer?.cancel();
    _timer = null;
    _userStreamController.add(null);
  }
}
