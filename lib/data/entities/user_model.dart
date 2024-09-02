class UserModel {
  UserModel({
    this.id,
    this.name,
    this.isFirstLogin,
    this.email,
    this.phone,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    isFirstLogin = json['isFirstLogin'];
    email = json['email'];
    phone = json['phone'];
  }

  String? id;
  String? name;
  bool? isFirstLogin;
  String? email;
  String? phone;
}
