import 'package:bassant_academy/data/entities/college_model.dart';

class CollegeResponse {
  CollegeResponse({
    this.data,
    this.errorOccurred,
    this.status,
    this.message,
  });

  CollegeResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CollegeModel.fromJson(v));
      });
    }
    errorOccurred = json['errorOccurred'];
    status = json['status'];
    message = json['message'];
  }

  List<CollegeModel>? data;
  bool? errorOccurred;
  num? status;
  dynamic message;
}
