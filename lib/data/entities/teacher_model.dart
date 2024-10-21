class TeacherModel {
  TeacherModel({
    this.id,
    this.name,
  });

  TeacherModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  String? id;
  String? name;

  TeacherModel copyWith({
    String? id,
    String? name,
  }) =>
      TeacherModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
