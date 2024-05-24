class TokenModel {
  final String token;
  final String refreshToken;
  final String? errorMessages;
  final bool isSuccess;

  TokenModel(
      {required this.token,
      required this.refreshToken,
      required this.errorMessages,
      required this.isSuccess});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json['token'],
      refreshToken: json['refreshToken'],
      errorMessages: json['errorMessages'],
      isSuccess: json['isSuccess'],
    );
  }
}
