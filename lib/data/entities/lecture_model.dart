class LectureModel {
  LectureModel({
    this.id,
    this.name,
    this.duration,
    this.url,
  });

  LectureModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    duration = json['duration'];
    url = json['url'];
  }

  num? id;
  String? name;
  String? duration;
  String? url;
}
