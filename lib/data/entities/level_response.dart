import 'package:bassant_academy/data/entities/level_model.dart';

class LevelResponse {
  LevelResponse({
    this.data,
    this.errorOccurred,
    this.status,
    this.message,
  });

  LevelResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(LevelModel.fromJson(v));
      });
    }
    errorOccurred = json['errorOccurred'];
    status = json['status'];
    message = json['message'];
  }

  List<LevelModel>? data;
  bool? errorOccurred;
  num? status;
  dynamic message;
}
