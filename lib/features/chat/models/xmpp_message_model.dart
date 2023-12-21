import 'dart:convert';

class XmppMessageBody {
  XmppMessageBody({
    this.content,
    this.deleteTime,
    this.filter,
    this.fromUserId,
    this.fromUserName,
    this.toUserName,
    this.messageId,
    this.timeSend,
    this.toUserId,
    this.type,
    this.objectId,
    this.other,
  });

  XmppMessageBody.fromJson(Map<String, dynamic> json) {
    content = json['content']?.toString();
    deleteTime = json['deleteTime'];
    filter = json['filter'];
    fromUserId = json['fromUserId']?.toString();
    fromUserName = json['fromUserName']?.toString();
    messageId = json['messageId'];
    timeSend = double.parse(json['timeSend']?.toString() ?? '0');
    toUserId = json['toUserId']?.toString();
    toUserName = json['toUserName']?.toString();
    type = json['type'];
    objectId = json['objectId'];
    other = jsonEncode(json['other'] ?? "");
  }

  String? content;
  int? deleteTime;
  int? filter;
  String? fromUserId;
  String? fromUserName;
  String? toUserName;
  String? messageId;
  double? timeSend;
  String? toUserId;
  int? type;
  String? objectId;
  String? other;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['content'] = content;
    data['deleteTime'] = deleteTime;
    data['filter'] = filter;
    data['fromUserId'] = fromUserId;
    data['fromUserName'] = fromUserName;
    data['toUserName'] = toUserName;
    data['messageId'] = messageId;
    data['timeSend'] = timeSend;
    data['toUserId'] = toUserId;
    data['type'] = type;
    data['other'] = other;
    return data;
  }
}
