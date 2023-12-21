// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:sf_chat_im/features/chat/models/chat_members_model.dart';
import 'package:sf_chat_im/shared/services/isar_service/compose_id_generator.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';

part 'chat_history_list_model.g.dart';

class ChatHistoryListData with EquatableMixin {
  ChatHistoryListData({
    this.currentTime,
    this.chats,
    this.resultCode,
    this.resultMsg,
  });

  ChatHistoryListData.fromJson(Map<String, dynamic> json,
      {bool isGroupData = false}) {
    currentTime = json['currentTime'];
    if (json['data'] != null) {
      chats = <ChatModel>[];
      json['data'].forEach((dynamic v) {
        chats!.add(
            isGroupData ? ChatModel.fromGroupJson(v) : ChatModel.fromJson(v));
      });
    }
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
  }

  List<ChatModel>? chats;
  int? currentTime;
  int? resultCode;
  String? resultMsg;

  @override
  List<Object?> get props => [currentTime, chats, resultCode, resultMsg];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['currentTime'] = currentTime;
    if (chats != null) {
      data['data'] = chats!.map((v) => v.toJson()).toList();
    }
    data['resultCode'] = resultCode;
    data['resultMsg'] = resultMsg;
    return data;
  }

  ChatHistoryListData copyWith({
    int? currentTime,
    List<ChatModel>? data,
    int? resultCode,
    String? resultMsg,
  }) {
    return ChatHistoryListData(
      currentTime: currentTime ?? this.currentTime,
      chats: data ?? chats,
      resultCode: resultCode ?? this.resultCode,
      resultMsg: resultMsg ?? this.resultMsg,
    );
  }
}

@Collection(inheritance: false)
class ChatModel with EquatableMixin {
  ChatModel({
    this.composeId,
    this.senderJid,
    this.receiverJid,
    this.ts,
    this.contentType,
    this.messageId,
    this.timeSend,
    this.deleteTime,
    this.sender,
    this.receiver,
    this.isRead,
    this.content,
    this.isLocalImage,
    this.objectId,
    this.boxId = Isar.autoIncrement,
    this.localFilePath,
    this.localFileUploadingStatus,
    this.sId,
    this.downloadStatus,
    this.other,
    this.isGroupMessage,
    this.isDelivered,
    this.nickName,
  });

  ChatModel.fromJson(Map<String, dynamic> newJson) {
    composeId = locator<ComposeIdGenerator>().generateComposedId(
      newJson['sender'].toString(),
      newJson['receiver'].toString(),
    );
    sId = newJson['_id'];
    senderJid = newJson['sender_jid'];
    receiverJid = newJson['receiver_jid'];
    ts = newJson['ts'];

    contentType = newJson['contentType'];
    // messageId = newJson['messageId'];
    messageId = newJson['body'] == null
        ? null
        : json.decode(newJson['body'])['messageId'];

    timeSend = (newJson['timeSend'] as double).toInt();
    deleteTime = newJson['deleteTime'];
    sender = newJson['sender'];
    receiver = newJson['receiver']?.toString();
    isRead = newJson['isRead'];
    content = newJson['content'];
    objectId = newJson['body'] == null
        ? null
        : json.decode(newJson['body'])['objectId'];
    other = json.encode(json.decode(newJson['body'])['other']);
    isDelivered = 1;
  }

  ChatModel.fromGroupJson(Map<String, dynamic> newJson) {
    composeId = locator<ComposeIdGenerator>().generateGroupComposedIdTo(
      newJson['room_jid_id'],
    );
    sId = newJson['_id'];
    nickName = newJson['nickname'];
    receiver = newJson['room_jid_id'];
    receiverJid = newJson['room_jid'];
    senderJid = newJson['sender_jid'];
    sender = newJson['sender'];
    ts = newJson['ts'];
    isDelivered = 1;
    contentType = newJson['contentType'];
    messageId = newJson['messageId'];
    timeSend = (newJson['timeSend'] as double).toInt();
    deleteTime = newJson['deleteTime'];
    other = json.encode(json.decode(newJson['body'])['other']);
    content = newJson['content'];
  }

  Id? boxId;
  ComposedId? composeId;
  String? content;
  int? contentType;
  int? deleteTime;
  bool? isLocalImage;
  int? isRead;
  String? localFilePath;
  String? localFileUploadingStatus;
  String? messageId;
  String? receiver;
  String? receiverJid;
  String? nickName;
  String? sId;
  int? sender;
  String? senderJid;
  int? timeSend;
  int? ts;
  String? objectId;
  bool? downloadStatus;
  bool? isGroupMessage;
  int? isDelivered;
  String? other;
  @ignore
  @override
  List<Object?> get props {
    return [
      // senderJid,
      // receiverJid,
      // ts,
      // contentType,
      // composeId,
      messageId,
      // timeSend,
      // deleteTime,
      // sender,
      // receiver,
      // isRead,
      // content,
    ];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sender_jid'] = senderJid;
    data['_id'] = sId;
    data['receiver_jid'] = receiverJid;
    data['ts'] = ts;
    data['contentType'] = contentType;
    data['messageId'] = messageId;
    data['timeSend'] = timeSend;
    data['deleteTime'] = deleteTime;
    data['sender'] = sender;
    data['receiver'] = receiver;
    data['isRead'] = isRead;
    data['content'] = content;
    data['objectId'] = objectId;
    data['other'] = other;
    return data;
  }

  ChatModel copyWith({
    String? sId,
    String? body,
    bool? fileDownloadStatus,
    ComposedId? composeId,
    int? direction,
    String? message,
    String? senderJid,
    String? receiverJid,
    Id? boxId,
    int? ts,
    int? type,
    int? contentType,
    String? messageId,
    int? timeSend,
    int? deleteTime,
    int? sender,
    String? receiver,
    bool? isLocalImage,
    String? local,
    String? localFileUploadingStatus,
    String? localFilePath,
    String? content,
    String? objectId,
    int? isRead,
    bool makeBoxIDNull = false,
    String? other,
    bool? isGroupMessage,
    int? isDelivered,
    String? nickName,
  }) {
    return ChatModel(
      objectId: objectId ?? this.objectId,
      senderJid: senderJid ?? this.senderJid,
      receiverJid: receiverJid ?? this.receiverJid,
      ts: ts ?? this.ts,
      downloadStatus: fileDownloadStatus ?? this.downloadStatus,
      // type: type ?? this.type,
      contentType: contentType ?? this.contentType,
      messageId: messageId ?? this.messageId,
      composeId: composeId ?? this.composeId,
      timeSend: timeSend ?? this.timeSend,
      deleteTime: deleteTime ?? this.deleteTime,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      localFilePath: localFilePath ?? this.localFilePath,
      localFileUploadingStatus:
          localFileUploadingStatus ?? this.localFileUploadingStatus,
      isLocalImage: isLocalImage ?? this.isLocalImage,
      isRead: isRead ?? this.isRead,
      content: content ?? this.content,
      boxId: makeBoxIDNull ? null : boxId ?? this.boxId,
      other: other ?? this.other,
      isGroupMessage: isGroupMessage ?? this.isGroupMessage,
      isDelivered: isDelivered ?? this.isDelivered,
      nickName: nickName ?? this.nickName,
    );
  }
}

// Define the enum for uploading status
enum UploadingStatus {
  inProgress,
  completed,
  failed,
}

// Extension on the String class to convert a string to UploadingStatus enum
extension ParseUploadingStatus on String {
  UploadingStatus toUploadingStatus() {
    switch (toLowerCase()) {
      case 'inprogress':
        return UploadingStatus.inProgress;
      case 'completed':
        return UploadingStatus.completed;
      case 'failed':
        return UploadingStatus.failed;
      default:
        throw ArgumentError('Invalid uploading status: $this');
    }
  }
}

class UploadingStatusStrings {
  static const completed = 'Completed';
  static const failed = 'Failed';
  static const inProgress = 'InProgress';
}
