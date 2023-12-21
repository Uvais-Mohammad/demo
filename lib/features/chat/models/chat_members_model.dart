// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:sf_chat_im/shared/services/isar_service/compose_id_generator.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';

part 'chat_members_model.g.dart';

class ChatMembersModel with EquatableMixin {
  ChatMembersModel({this.currentTime, this.data, this.resultCode});

  ChatMembersModel.fromJson(Map<String, dynamic> json) {
    currentTime = json['currentTime'];
    if (json['data'] != null) {
      data = <SingleMemberModel>[];
      json['data'].forEach((dynamic v) {
        data!.add(SingleMemberModel.fromJson(v));
      });
    }
    resultCode = json['resultCode'];
  }
  int? currentTime;
  List<SingleMemberModel>? data;
  int? resultCode;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['currentTime'] = currentTime;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['resultCode'] = resultCode;
    return data;
  }

  @override
  List<Object?> get props => [currentTime, data, resultCode];

  ChatMembersModel copyWith({
    int? currentTime,
    List<SingleMemberModel>? data,
    int? resultCode,
  }) {
    return ChatMembersModel(
      currentTime: currentTime ?? this.currentTime,
      data: data ?? this.data,
      resultCode: resultCode ?? this.resultCode,
    );
  }
}

@Collection(inheritance: false)
class SingleMemberModel with EquatableMixin {
  SingleMemberModel({
    this.jid,
    this.userId,
    this.content,
    this.from,
    this.unreadCount = 0,
    this.boxId = Isar.autoIncrement,
    this.timeSend,
    this.lastMessageId,
    this.to,
    this.isGroup = false,
    this.toUserName,
    this.composedId,
    this.lastMessageIdAvailableInLocal,
    this.lastSyncTime,
    this.toUserStatus,
    this.contentType,
  });

  bool get isDeletedAccount => this.toUserStatus == -2;

  SingleMemberModel.fromJson(Map<String, dynamic> json) {
    jid = json['jid'];
    composedId =
        locator<ComposeIdGenerator>().generateComposedIdTo(json['jid']);
    userId = json['userId'];
    content = json['content'];
    from = json['from'];
    timeSend = json['timeSend'];
    to = json['to']?.toString();
    toUserName = json['toUserName'];
    lastMessageId = json['messageId'];
    lastSyncTime = 0;
    toUserStatus = json['toUserStatus'];
    isGroup = json['isRoom'] == 1;
  }
  ComposedId? composedId;
  String? jid;
  Id? boxId;
  bool? isGroup;
  String? lastMessageId;
  String? userId;
  int? unreadCount;
  String? content;
  int? contentType;
  String? from;
  int? timeSend;
  int? lastSyncTime;
  String? to;
  String? lastMessageIdAvailableInLocal;
  String? toUserName;
  int? toUserStatus;
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jid'] = jid;
    data['userId'] = userId;
    data['content'] = content;
    data['from'] = from;
    data['timeSend'] = timeSend;
    data['messageId'] = lastMessageId;
    data['to'] = to;
    data['toUserName'] = toUserName;
    return data;
  }

  @ignore
  @override
  List<Object?> get props {
    return [
      composedId,
      jid,
      boxId,
      userId,
      content,
      from,
      to,
      unreadCount,
      lastMessageId,
      timeSend,
      toUserName,
      lastMessageIdAvailableInLocal,
      lastSyncTime,
      toUserStatus,
      isGroup,
      contentType,
    ];
  }

  SingleMemberModel copyWith({
    ComposedId? composedId,
    String? jid,
    String? userId,
    int? unreadCount,
    Id? boxId,
    String? content,
    String? from,
    String? lastMessageId,
    int? timeSend,
    String? to,
    bool? isGroup,
    String? toUserName,
    String? lastMessageIdAvailableInLocal,
    int? lastSyncTime,
    int? toUserStatus,
    int? contentType,
  }) {
    return SingleMemberModel(
      boxId: boxId ?? this.boxId,
      isGroup: isGroup ?? this.isGroup,
      composedId: composedId ?? this.composedId,
      jid: jid ?? this.jid,
      userId: userId ?? this.userId,
      unreadCount: unreadCount ?? this.unreadCount,
      content: content ?? this.content,
      from: from ?? this.from,
      timeSend: timeSend ?? this.timeSend,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      to: to ?? this.to,
      toUserName: toUserName ?? this.toUserName,
      lastMessageIdAvailableInLocal:
          lastMessageIdAvailableInLocal ?? this.lastMessageIdAvailableInLocal,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      toUserStatus: toUserStatus ?? this.toUserStatus,
      contentType: contentType ?? this.contentType,
    );
  }
}

@embedded
class ComposedId {
  const ComposedId({this.from, this.to});
  // : assert(from != to,
  //       'from and to cannot be the same when composing ComposedId $from : $to');

  // from always should be the owner
  // to always should be the opponent
  final String? from;
  final String? to;

  @override
  String toString() {
    return '$from : $to';
  }

  @override
  bool operator ==(covariant ComposedId other) {
    if (identical(this, other)) return true;

    return other.from == from && other.to == to ||
        other.from == to && other.to == from;
  }

  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}
