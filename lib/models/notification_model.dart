class NotificationModel {
  final String id;
  final String uid;
  final String content;
  final String date;
  final bool read;

  NotificationModel(this.id, this.uid, this.content, this.date, this.read);

  // toJson
  toJson() {
    return {
      "id": id,
      "uid": uid,
      "content": content,
      "date": date,
      "read": read
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    print(1);
    return NotificationModel(
        json["id"], json["uid"], json["content"], json["date"], json["read"]);
  }
}
