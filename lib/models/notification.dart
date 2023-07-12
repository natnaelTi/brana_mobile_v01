
class Notification {
  String title;
  String? subTitle;
  String body;
  DateTime createdAt;
  String? userId;
  String? imageUrl;
  List<String> toDisplay;

  Notification({
    required this.title,
    this.subTitle,
    required this.body,
    required this.createdAt,
    this.userId,
    this.imageUrl,
    this.toDisplay = const [],
  });

  Notification.fromFirestore(
      {required this.title,
        this.subTitle,
        required this.body,
        this.imageUrl,
        required this.createdAt,
        this.userId,
        this.toDisplay = const []});

  factory Notification.fromDatabase({required data}) {
    return Notification.fromFirestore(
        title: data["title"],
        subTitle: data["sub_title"],
        body: data["text"],
        imageUrl: data["image_url"],
        createdAt: data["created_at"].toDate(),
        userId: data["user_id"]);
  }

  toJson() {
    return {
      "title": title,
      "sub_title": subTitle,
      "text": body,
      "image_url": imageUrl,
      "created_at": createdAt,
      "user_id": userId
    };
  }
}