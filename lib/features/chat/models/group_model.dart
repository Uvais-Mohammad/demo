// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sf_chat_im/features/chat/models/chat_members_model.dart';
import 'package:sf_chat_im/shared/services/isar_service/compose_id_generator.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';

class GroupListModel {
  int? currentTime;
  List<GroupModel>? data;
  int? resultCode;

  GroupListModel({this.currentTime, this.data, this.resultCode});

  GroupListModel.fromJson(Map<String, dynamic> json) {
    currentTime = json['currentTime'];
    if (json['data'] != null) {
      data = <GroupModel>[];
      json['data'].forEach((v) {
        data!.add(new GroupModel.fromJson(v));
      });
    }
    resultCode = json['resultCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentTime'] = this.currentTime;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['resultCode'] = this.resultCode;
    return data;
  }
}

class GroupModel {
  String? adminAddFriend;
  String? allowConference;
  String? allowHostUpdate;
  String? allowInviteFriend;
  String? allowPrivateChat;
  String? allowSendCard;
  String? allowSpeakCourse;
  String? allowUploadFile;
  String? appIsSendFile;
  String? areaId;
  String? bonus;
  String? call;
  String? category;
  String? chatRecordTimeOut;
  String? cityId;
  String? countryId;
  String? createTime;
  String? customerShowUserSize;
  String? desc;
  String? foreignKey;
  String? id;
  String? imgUrl;
  String? inviteBonus;
  String? isAttritionNotice;
  String? isLook;
  String? isNeedVerify;
  String? isShowRedNickname;
  String? jid;
  String? latitude;
  String? longitude;
  String? maxUserSize;
  Member? myProfile;
  String? modifyImg;
  String? modifyTime;
  String? name;
  String? nickname;
  Notice? notice;
  String? pcIsSendFile;
  String? provinceId;
  String? s;
  String? showMember;
  String? showMemberCustomer;
  String? showRead;
  String? showUserSize;
  String? subject;
  String? talkTime;
  String? userId;
  String? userSize;
  String? videoMeetingNo;
  String? waiterAppIsSendFile;
  String? waiterPcIsSendFile;
  String? waiterWebIsSendFile;
  String? webIsSendFile;
  List<Member>? members;

  GroupModel({
    this.adminAddFriend,
    this.allowConference,
    this.allowHostUpdate,
    this.allowInviteFriend,
    this.allowPrivateChat,
    this.allowSendCard,
    this.allowSpeakCourse,
    this.allowUploadFile,
    this.appIsSendFile,
    this.areaId,
    this.bonus,
    this.call,
    this.category,
    this.chatRecordTimeOut,
    this.cityId,
    this.countryId,
    this.createTime,
    this.customerShowUserSize,
    this.desc,
    this.foreignKey,
    this.id,
    this.imgUrl,
    this.inviteBonus,
    this.isAttritionNotice,
    this.isLook,
    this.isNeedVerify,
    this.isShowRedNickname,
    this.jid,
    this.latitude,
    this.longitude,
    this.maxUserSize,
    this.myProfile,
    this.modifyImg,
    this.modifyTime,
    this.name,
    this.nickname,
    this.notice,
    this.pcIsSendFile,
    this.provinceId,
    this.s,
    this.showMember,
    this.showMemberCustomer,
    this.showRead,
    this.showUserSize,
    this.subject,
    this.talkTime,
    this.userId,
    this.userSize,
    this.videoMeetingNo,
    this.waiterAppIsSendFile,
    this.waiterPcIsSendFile,
    this.waiterWebIsSendFile,
    this.webIsSendFile,
    this.members,
  });

  GroupModel.fromJson(Map<String, dynamic> newJson) {
    //function to convert all values in newJson to String if they are not null or Map or List
    final json = newJson.map((key, value) => MapEntry(
        key, value is List || value is Map ? value : value?.toString()));

    adminAddFriend = json['adminAddFriend'];
    allowConference = json['allowConference'];
    allowHostUpdate = json['allowHostUpdate'];
    allowInviteFriend = json['allowInviteFriend'];
    allowPrivateChat = json['allowPrivateChat'];
    allowSendCard = json['allowSendCard'];
    allowSpeakCourse = json['allowSpeakCourse'];
    allowUploadFile = json['allowUploadFile'];
    appIsSendFile = json['appIsSendFile'];
    areaId = json['areaId']?.toString();
    bonus = json['bonus']?.toString();
    call = json['call'];
    category = json['category'];
    chatRecordTimeOut = json['chatRecordTimeOut']?.toString();
    cityId = json['cityId'];
    countryId = json['countryId'];
    createTime = json['createTime'];
    customerShowUserSize = json['customerShowUserSize'];
    desc = json['desc'];
    foreignKey = json['foreignKey'];
    id = json['id'];
    imgUrl = json['imgUrl'];
    inviteBonus = json['inviteBonus'];
    isAttritionNotice = json['isAttritionNotice'];
    isLook = json['isLook'];
    isNeedVerify = json['isNeedVerify'];
    isShowRedNickname = json['isShowRedNickname'];
    jid = json['jid'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    maxUserSize = json['maxUserSize'];
    myProfile =
        json['member'] != null ? new Member.fromJson(json['member']) : null;
    modifyImg = json['modifyImg'];
    modifyTime = json['modifyTime'];
    name = json['name'];
    nickname = json['nickname'];
    notice =
        json['notice'] != null ? new Notice.fromJson(json['notice']) : null;
    pcIsSendFile = json['pcIsSendFile'];
    provinceId = json['provinceId'];
    s = json['s'];
    showMember = json['showMember'];
    showMemberCustomer = json['showMember_customer'];
    showRead = json['showRead'];
    showUserSize = json['showUserSize'];
    subject = json['subject'];
    talkTime = json['talkTime'];
    userId = json['userId'];
    userSize = json['userSize'];
    videoMeetingNo = json['videoMeetingNo'];
    waiterAppIsSendFile = json['waiterAppIsSendFile'];
    waiterPcIsSendFile = json['waiterPcIsSendFile'];
    waiterWebIsSendFile = json['waiterWebIsSendFile'];
    webIsSendFile = json['webIsSendFile'];
    if (json['members'] != null) {
      members = <Member>[];
      json['members'].forEach((v) {
        members!.add(new Member.fromJson(v));
      });
    }
  }
  SingleMemberModel getSingleMemberModel() {
    return SingleMemberModel(
      jid: this.jid,
      composedId: locator<ComposeIdGenerator>()
          .generateGroupComposedIdTo(this.jid.toString()),
      userId: this.id.toString(),
      from: this.nickname,
      unreadCount: 0,
      timeSend: (int.tryParse(((createTime)).toString())),
      to: this.jid,
      isGroup: true,
      toUserName: name,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminAddFriend'] = this.adminAddFriend;
    data['allowConference'] = this.allowConference;
    data['allowHostUpdate'] = this.allowHostUpdate;
    data['allowInviteFriend'] = this.allowInviteFriend;
    data['allowPrivateChat'] = this.allowPrivateChat;
    data['allowSendCard'] = this.allowSendCard;
    data['allowSpeakCourse'] = this.allowSpeakCourse;
    data['allowUploadFile'] = this.allowUploadFile;
    data['appIsSendFile'] = this.appIsSendFile;
    data['areaId'] = this.areaId;
    data['bonus'] = this.bonus;
    data['call'] = this.call;
    data['category'] = this.category;
    data['chatRecordTimeOut'] = this.chatRecordTimeOut;
    data['cityId'] = this.cityId;
    data['countryId'] = this.countryId;
    data['createTime'] = this.createTime;
    data['customerShowUserSize'] = this.customerShowUserSize;
    data['desc'] = this.desc;
    data['foreignKey'] = this.foreignKey;
    data['id'] = this.id;
    data['imgUrl'] = this.imgUrl;
    data['inviteBonus'] = this.inviteBonus;
    data['isAttritionNotice'] = this.isAttritionNotice;
    data['isLook'] = this.isLook;
    data['isNeedVerify'] = this.isNeedVerify;
    data['isShowRedNickname'] = this.isShowRedNickname;
    data['jid'] = this.jid;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['maxUserSize'] = this.maxUserSize;
    if (this.myProfile != null) {
      data['member'] = this.myProfile!.toJson();
    }
    data['modifyImg'] = this.modifyImg;
    data['modifyTime'] = this.modifyTime;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    if (this.notice != null) {
      data['notice'] = this.notice!.toJson();
    }
    data['pcIsSendFile'] = this.pcIsSendFile;
    data['provinceId'] = this.provinceId;
    data['s'] = this.s;
    data['showMember'] = this.showMember;
    data['showMember_customer'] = this.showMemberCustomer;
    data['showRead'] = this.showRead;
    data['showUserSize'] = this.showUserSize;
    data['subject'] = this.subject;
    data['talkTime'] = this.talkTime;
    data['userId'] = this.userId;
    data['userSize'] = this.userSize;
    data['videoMeetingNo'] = this.videoMeetingNo;
    data['waiterAppIsSendFile'] = this.waiterAppIsSendFile;
    data['waiterPcIsSendFile'] = this.waiterPcIsSendFile;
    data['waiterWebIsSendFile'] = this.waiterWebIsSendFile;
    data['webIsSendFile'] = this.webIsSendFile;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  GroupModel copyWith({
    String? adminAddFriend,
    String? allowConference,
    String? allowHostUpdate,
    String? allowInviteFriend,
    String? allowPrivateChat,
    String? allowSendCard,
    String? allowSpeakCourse,
    String? allowUploadFile,
    String? appIsSendFile,
    String? areaId,
    String? bonus,
    String? call,
    String? category,
    String? chatRecordTimeOut,
    String? cityId,
    String? countryId,
    String? createTime,
    String? customerShowUserSize,
    String? desc,
    String? foreignKey,
    String? id,
    String? imgUrl,
    String? inviteBonus,
    String? isAttritionNotice,
    String? isLook,
    String? isNeedVerify,
    String? isShowRedNickname,
    String? jid,
    String? latitude,
    String? longitude,
    String? maxUserSize,
    Member? myProfile,
    String? modifyImg,
    String? modifyTime,
    String? name,
    String? nickname,
    Notice? notice,
    String? pcIsSendFile,
    String? provinceId,
    String? s,
    String? showMember,
    String? showMemberCustomer,
    String? showRead,
    String? showUserSize,
    String? subject,
    String? talkTime,
    String? userId,
    String? userSize,
    String? videoMeetingNo,
    String? waiterAppIsSendFile,
    String? waiterPcIsSendFile,
    String? waiterWebIsSendFile,
    String? webIsSendFile,
    List<Member>? members,
  }) {
    return GroupModel(
      adminAddFriend: adminAddFriend ?? this.adminAddFriend,
      allowConference: allowConference ?? this.allowConference,
      allowHostUpdate: allowHostUpdate ?? this.allowHostUpdate,
      allowInviteFriend: allowInviteFriend ?? this.allowInviteFriend,
      allowPrivateChat: allowPrivateChat ?? this.allowPrivateChat,
      allowSendCard: allowSendCard ?? this.allowSendCard,
      allowSpeakCourse: allowSpeakCourse ?? this.allowSpeakCourse,
      allowUploadFile: allowUploadFile ?? this.allowUploadFile,
      appIsSendFile: appIsSendFile ?? this.appIsSendFile,
      areaId: areaId ?? this.areaId,
      bonus: bonus ?? this.bonus,
      call: call ?? this.call,
      category: category ?? this.category,
      chatRecordTimeOut: chatRecordTimeOut ?? this.chatRecordTimeOut,
      cityId: cityId ?? this.cityId,
      countryId: countryId ?? this.countryId,
      createTime: createTime ?? this.createTime,
      customerShowUserSize: customerShowUserSize ?? this.customerShowUserSize,
      desc: desc ?? this.desc,
      foreignKey: foreignKey ?? this.foreignKey,
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      inviteBonus: inviteBonus ?? this.inviteBonus,
      isAttritionNotice: isAttritionNotice ?? this.isAttritionNotice,
      isLook: isLook ?? this.isLook,
      isNeedVerify: isNeedVerify ?? this.isNeedVerify,
      isShowRedNickname: isShowRedNickname ?? this.isShowRedNickname,
      jid: jid ?? this.jid,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      maxUserSize: maxUserSize ?? this.maxUserSize,
      myProfile: myProfile ?? this.myProfile,
      modifyImg: modifyImg ?? this.modifyImg,
      modifyTime: modifyTime ?? this.modifyTime,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      notice: notice ?? this.notice,
      pcIsSendFile: pcIsSendFile ?? this.pcIsSendFile,
      provinceId: provinceId ?? this.provinceId,
      s: s ?? this.s,
      showMember: showMember ?? this.showMember,
      showMemberCustomer: showMemberCustomer ?? this.showMemberCustomer,
      showRead: showRead ?? this.showRead,
      showUserSize: showUserSize ?? this.showUserSize,
      subject: subject ?? this.subject,
      talkTime: talkTime ?? this.talkTime,
      userId: userId ?? this.userId,
      userSize: userSize ?? this.userSize,
      videoMeetingNo: videoMeetingNo ?? this.videoMeetingNo,
      waiterAppIsSendFile: waiterAppIsSendFile ?? this.waiterAppIsSendFile,
      waiterPcIsSendFile: waiterPcIsSendFile ?? this.waiterPcIsSendFile,
      waiterWebIsSendFile: waiterWebIsSendFile ?? this.waiterWebIsSendFile,
      webIsSendFile: webIsSendFile ?? this.webIsSendFile,
      members: members ?? this.members,
    );
  }
}

class Member {
  int? active;
  String? call;
  int? createTime;
  int? modifyTime;
  String? nickname;
  int? offlineNoPushMsg;
  int? role;
  int? sub;
  int? talkTime;
  int? userId;
  String? videoMeetingNo;

  Member(
      {this.active,
      this.call,
      this.createTime,
      this.modifyTime,
      this.nickname,
      this.offlineNoPushMsg,
      this.role,
      this.sub,
      this.talkTime,
      this.userId,
      this.videoMeetingNo});

  Member.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    call = json['call'];
    createTime = json['createTime'];
    modifyTime = json['modifyTime'];
    nickname = json['nickname'];
    offlineNoPushMsg = json['offlineNoPushMsg'];
    role = json['role'];
    sub = json['sub'];
    talkTime = json['talkTime'];
    userId = json['userId'];
    videoMeetingNo = json['videoMeetingNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['call'] = this.call;
    data['createTime'] = this.createTime;
    data['modifyTime'] = this.modifyTime;
    data['nickname'] = this.nickname;
    data['offlineNoPushMsg'] = this.offlineNoPushMsg;
    data['role'] = this.role;
    data['sub'] = this.sub;
    data['talkTime'] = this.talkTime;
    data['userId'] = this.userId;
    data['videoMeetingNo'] = this.videoMeetingNo;
    return data;
  }

  Member copyWith({
    int? active,
    String? call,
    int? createTime,
    int? modifyTime,
    String? nickname,
    int? offlineNoPushMsg,
    int? role,
    int? sub,
    int? talkTime,
    int? userId,
    String? videoMeetingNo,
  }) {
    return Member(
      active: active ?? this.active,
      call: call ?? this.call,
      createTime: createTime ?? this.createTime,
      modifyTime: modifyTime ?? this.modifyTime,
      nickname: nickname ?? this.nickname,
      offlineNoPushMsg: offlineNoPushMsg ?? this.offlineNoPushMsg,
      role: role ?? this.role,
      sub: sub ?? this.sub,
      talkTime: talkTime ?? this.talkTime,
      userId: userId ?? this.userId,
      videoMeetingNo: videoMeetingNo ?? this.videoMeetingNo,
    );
  }
}

class Notice {
  int? time;
  String? id;
  String? nickname;
  String? roomId;
  String? text;
  int? userId;
  String? value;

  Notice(
      {this.time,
      this.id,
      this.nickname,
      this.roomId,
      this.text,
      this.userId,
      this.value});

  Notice.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    id = json['id'];
    nickname = json['nickname'];
    roomId = json['roomId'];
    text = json['text'];
    userId = json['userId'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['roomId'] = this.roomId;
    data['text'] = this.text;
    data['userId'] = this.userId;
    data['value'] = this.value;
    return data;
  }
}
