class SocialLinksResponse {
  SocialLinksResponse({
    this.data,
    this.errorOccurred,
    this.status,
    this.message,
  });

  SocialLinksResponse.fromJson(dynamic json) {
    data =
        json['data'] != null ? SocialLinksModel.fromJson(json['data']) : null;
    errorOccurred = json['errorOccurred'];
    status = json['status'];
    message = json['message'];
  }

  SocialLinksModel? data;
  bool? errorOccurred;
  num? status;
  dynamic message;
}

class SocialLinksModel {
  SocialLinksModel({
    this.id,
    this.instagram,
    this.tikTok,
    this.faceBook,
    this.whatsapp,
  });

  SocialLinksModel.fromJson(dynamic json) {
    id = json['id'];
    instagram = json['instagram'];
    tikTok = json['tikTok'];
    faceBook = json['faceBook'];
    whatsapp = json['whatsapp'];
  }

  num? id;
  String? instagram;
  String? tikTok;
  String? faceBook;
  String? whatsapp;
}
