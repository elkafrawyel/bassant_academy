class CollegeModel {
  CollegeModel({
    this.id,
    this.name,
    this.image,
  });

  CollegeModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  num? id;
  String? name;
  String? image;
}
