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

  @override
  String toString() {
    return name ?? '';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
