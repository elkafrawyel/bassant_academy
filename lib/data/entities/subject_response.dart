import 'package:bassant_academy/data/entities/subject_model.dart';

class SubjectResponse {
  SubjectResponse({
    this.data,
    this.errorOccurred,
    this.status,
    this.message,
  });

  SubjectResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SubjectModel.fromJson(v));
      });
    }
    errorOccurred = json['errorOccurred'];
    status = json['status'];
    message = json['message'];
  }

  List<SubjectModel>? data;
  bool? errorOccurred;
  num? status;
  dynamic message;
}
