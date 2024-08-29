import 'package:bassant_academy/data/entities/university_model.dart';

class UniversityResponse {
  UniversityResponse({
    this.data,
    this.errorOccurred,
    this.status,
    this.message,
  });

  UniversityResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(UniversityModel.fromJson(v));
      });
    }
    errorOccurred = json['errorOccurred'];
    status = json['status'];
    message = json['message'];
  }

  List<UniversityModel>? data;
  bool? errorOccurred;
  num? status;
  dynamic message;
}
