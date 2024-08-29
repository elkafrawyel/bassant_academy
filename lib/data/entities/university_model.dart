class UniversityModel {
  UniversityModel({
    this.id,
    this.name,
    this.image,
  });

  UniversityModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  num? id;
  String? name;
  String? image;
}
