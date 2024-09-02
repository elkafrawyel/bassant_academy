class GeneralResponse {
  GeneralResponse({
    this.data,
    this.errorOccurred,
    this.status,
    this.message,
  });

  GeneralResponse.fromJson(dynamic json) {
    data = json['data'];
    errorOccurred = json['errorOccurred'];
    status = json['status'];
    message = json['message'];
  }

  String? data;
  bool? errorOccurred;
  num? status;
  dynamic message;
}
