class AuthResponse {
  AuthResponse({
    this.message,
    this.errorOccured,
    this.isAuthenticated,
    this.token,
    this.userId,
    this.expireOn,
  });

  AuthResponse.fromJson(dynamic json) {
    message = json['message'];
    errorOccured = json['errorOccured'];
    isAuthenticated = json['isAuthenticated'];
    token = json['token'];
    userId = json['userId'];
    expireOn = json['expireOn'];
  }

  dynamic message;
  bool? errorOccured;
  bool? isAuthenticated;
  String? token;
  String? userId;
  String? expireOn;
}
