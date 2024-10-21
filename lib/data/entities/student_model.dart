class StudentModel {
  StudentModel({
    this.id,
    this.name,
  });

  StudentModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  String? id;
  String? name;

  StudentModel copyWith({
    String? id,
    String? name,
  }) =>
      StudentModel(
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
