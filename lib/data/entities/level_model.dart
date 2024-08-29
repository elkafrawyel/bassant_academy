class LevelModel {
  LevelModel({
    this.id,
    this.name,
    this.image,
  });

  LevelModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  num? id;
  String? name;
  String? image;
}
