import 'profile_model.dart';

class ProfileResponse {
  ProfileResponse({
    this.data,
    this.errorOccurred,
    this.status,
    this.message,
  });

  ProfileResponse.fromJson(dynamic json) {
    data = json['data'] != null ? ProfileModel.fromJson(json['data']) : null;
    errorOccurred = json['errorOccurred'];
    status = json['status'];
    message = json['message'];
  }

  ProfileModel? data;
  bool? errorOccurred;
  num? status;
  dynamic message;
}
