class SubjectModel {
  SubjectModel({
    this.id,
    this.name,
    this.image,
  });

  SubjectModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  num? id;
  String? name;
  String? image;
}
