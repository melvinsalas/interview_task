class AuthRequest {
  final String username;
  final String password;
  final int expiresInMins;

  AuthRequest({
    required this.username,
    required this.password,
    this.expiresInMins = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'expiresInMins': expiresInMins,
    };
  }

  factory AuthRequest.fromJson(Map<String, dynamic> json) {
    return AuthRequest(
      username: json['username'],
      password: json['password'],
      expiresInMins: json['expiresInMins'],
    );
  }
}
