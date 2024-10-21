import 'student_model.dart';

class MyStudentsResponse {
  MyStudentsResponse({
    this.data,
    this.errorOccurred,
    this.status,
    this.message,
    this.meta,
  });

  MyStudentsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(StudentModel.fromJson(v));
      });
    }
    errorOccurred = json['errorOccurred'];
    status = json['status'];
    message = json['message'];
    meta = json['meta'];
  }

  List<StudentModel>? data;
  bool? errorOccurred;
  num? status;
  dynamic message;
  dynamic meta;

  MyStudentsResponse copyWith({
    List<StudentModel>? data,
    bool? errorOccurred,
    num? status,
    dynamic message,
    dynamic meta,
  }) =>
      MyStudentsResponse(
        data: data ?? this.data,
        errorOccurred: errorOccurred ?? this.errorOccurred,
        status: status ?? this.status,
        message: message ?? this.message,
        meta: meta ?? this.meta,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['errorOccurred'] = errorOccurred;
    map['status'] = status;
    map['message'] = message;
    map['meta'] = meta;
    return map;
  }
}
