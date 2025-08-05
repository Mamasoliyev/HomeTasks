class AuthResponseEntity {
  final String accessToken;
  final String refreshToken;

  AuthResponseEntity({
    required this.accessToken,
    required this.refreshToken,
  });
}