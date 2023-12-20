import 'dart:convert';

DiscoverComment discoverCommentFromJson(String str) =>
    DiscoverComment.fromJson(json.decode(str));

String discoverCommentToJson(DiscoverComment data) =>
    json.encode(data.toJson());

class DiscoverComment {
  int currentTime;
  List<CommentData> data;
  int resultCode;

  DiscoverComment({
    required this.currentTime,
    required this.data,
    required this.resultCode,
  });

  DiscoverComment copyWith({
    int? currentTime,
    List<CommentData>? data,
    int? resultCode,
  }) =>
      DiscoverComment(
        currentTime: currentTime ?? this.currentTime,
        data: data ?? this.data,
        resultCode: resultCode ?? this.resultCode,
      );

  factory DiscoverComment.fromJson(Map<String, dynamic> json) =>
      DiscoverComment(
        currentTime: json["currentTime"],
        data: List<CommentData>.from(json["data"].map((x) => CommentData.fromJson(x))),
        resultCode: json["resultCode"],
      );

  Map<String, dynamic> toJson() => {
        "currentTime": currentTime,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "resultCode": resultCode,
      };
}

class CommentData {
  String body;
  String commentId;
  String msgId;
  String nickname;
  int time;
  int toUserId;
  int userId;

  CommentData({
    required this.body,
    required this.commentId,
    required this.msgId,
    required this.nickname,
    required this.time,
    required this.toUserId,
    required this.userId,
  });

  CommentData copyWith({
    String? body,
    String? commentId,
    String? msgId,
    String? nickname,
    int? time,
    int? toUserId,
    int? userId,
  }) =>
      CommentData(
        body: body ?? this.body,
        commentId: commentId ?? this.commentId,
        msgId: msgId ?? this.msgId,
        nickname: nickname ?? this.nickname,
        time: time ?? this.time,
        toUserId: toUserId ?? this.toUserId,
        userId: userId ?? this.userId,
      );

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        body: json["body"],
        commentId: json["commentId"],
        msgId: json["msgId"],
        nickname: json["nickname"],
        time: json["time"],
        toUserId: json["toUserId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "commentId": commentId,
        "msgId": msgId,
        "nickname": nickname,
        "time": time,
        "toUserId": toUserId,
        "userId": userId,
      };
}
