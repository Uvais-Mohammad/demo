class MainNotificationModel {
  MainNotificationModel({
    required this.content,
    required this.sender,
    required this.senderName,
    required this.receiver,
    required this.contentType,
    required this.objectId,
  });
  String? content;
  String? sender;
  String? senderName;
  String? receiver;
  int? contentType;
  String? objectId;
}
