class AuthResponse {
  AuthResponse({
    this.message,
    this.errorOccured,
    this.isAuthenticated,
    this.token,
    this.userId,
    this.isStudent,
    this.expireOn,
  });

  AuthResponse.fromJson(dynamic json) {
    message = json['message'];
    errorOccured = json['errorOccured'];
    isAuthenticated = json['isAuthenticated'];
    token = json['token'];
    userId = json['userId'];
    isStudent = json['isStudent'];
    expireOn = json['expireOn'];
  }

  dynamic message;
  bool? errorOccured;
  bool? isAuthenticated;
  String? token;
  String? userId;
  bool? isStudent;
  String? expireOn;

  AuthResponse copyWith({
    dynamic message,
    bool? errorOccured,
    bool? isAuthenticated,
    String? token,
    String? userId,
    bool? isStudent,
    String? expireOn,
  }) =>
      AuthResponse(
        message: message ?? this.message,
        errorOccured: errorOccured ?? this.errorOccured,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        token: token ?? this.token,
        userId: userId ?? this.userId,
        isStudent: isStudent ?? this.isStudent,
        expireOn: expireOn ?? this.expireOn,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['errorOccured'] = errorOccured;
    map['isAuthenticated'] = isAuthenticated;
    map['token'] = token;
    map['userId'] = userId;
    map['isStudent'] = isStudent;
    map['expireOn'] = expireOn;
    return map;
  }
}
