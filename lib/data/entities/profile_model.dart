import 'package:bassant_academy/data/entities/college_model.dart';
import 'package:bassant_academy/data/entities/country_model.dart';
import 'package:bassant_academy/data/entities/level_model.dart';
import 'package:bassant_academy/data/entities/teacher_model.dart';
import 'package:bassant_academy/data/entities/university_model.dart';
import 'package:bassant_academy/data/entities/user_model.dart';

import 'lecture_model.dart';

class ProfileModel {
  ProfileModel({
    this.user,
    this.country,
    this.university,
    this.collage,
    this.level,
    this.subjects,
  });

  ProfileModel.fromJson(dynamic json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    country =
        json['country'] != null ? CountryModel.fromJson(json['country']) : null;
    university = json['university'] != null
        ? UniversityModel.fromJson(json['university'])
        : null;
    collage =
        json['collage'] != null ? CollegeModel.fromJson(json['collage']) : null;
    level = json['studyLevel'] != null
        ? LevelModel.fromJson(json['studyLevel'])
        : null;
    if (json['subjects'] != null) {
      subjects = [];
      json['subjects'].forEach((v) {
        subjects?.add(SubjectWithLecturesModel.fromJson(v));
      });
    }
  }

  UserModel? user;
  CountryModel? country;
  UniversityModel? university;
  CollegeModel? collage;
  LevelModel? level;
  List<SubjectWithLecturesModel>? subjects;
}

class SubjectWithLecturesModel {
  SubjectWithLecturesModel({
    this.id,
    this.name,
    this.lectures,
    this.teacher,
  });

  SubjectWithLecturesModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    teacher =
        json['teacher'] != null ? TeacherModel.fromJson(json['teacher']) : null;
    if (json['lectures'] != null) {
      lectures = [];
      json['lectures'].forEach((v) {
        lectures?.add(LectureModel.fromJson(v));
      });
    }
  }

  num? id;
  String? name;
  List<LectureModel>? lectures;
  TeacherModel? teacher;
}
