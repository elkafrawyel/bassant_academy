import 'package:bassant_academy/data/entities/lecture_model.dart';

class NotificationModel {
  NotificationModel({
    this.studentId,
    this.notificationId,
    this.title,
    this.description,
    this.link,
    this.creationDate,
    this.lecture,
  });

  NotificationModel.fromJson(dynamic json) {
    studentId = json['studentId'];
    notificationId = json['notificationId'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
    creationDate = json['creationDate'];
    lecture = json['lecture'] != null
        ? LectureModel.fromJson(
            json['lecture'],
          )
        : null;
  }

  String? studentId;
  num? notificationId;
  String? title;
  String? description;
  String? link;
  String? creationDate;
  LectureModel? lecture;
}
