class MessageModel {
  String? title;
  String? creationDate;
  bool isCurrentUser = true;
  bool isTextMessage = true;

  MessageModel({
    this.title,
    this.creationDate,
    this.isCurrentUser = true,
    this.isTextMessage = true,
  });

  MessageModel.fromJson(dynamic json) {
    title = json['title'];
    creationDate = json['creationDate'];
  }

  @override
  String toString() {
    return creationDate ?? '';
  }
}
