import 'package:bassant_academy/data/entities/country_model.dart';

class CountryResponse {
  CountryResponse({
    this.data,
    this.errorOccurred,
    this.status,
    this.message,
  });

  CountryResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CountryModel.fromJson(v));
      });
    }
    errorOccurred = json['errorOccurred'];
    status = json['status'];
    message = json['message'];
  }

  List<CountryModel>? data;
  bool? errorOccurred;
  num? status;
  dynamic message;
}
