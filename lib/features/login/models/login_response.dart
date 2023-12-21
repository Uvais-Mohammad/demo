// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:sf_chat_im/features/signup/models/signup_model.dart';

class LoginResponse with EquatableMixin {
  LoginResponse({this.currentTime, this.data, this.resultCode});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    currentTime = json['currentTime'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    resultCode = json['resultCode'];
  }
  int? currentTime;
  Data? data;
  int? resultCode;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['currentTime'] = currentTime;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['resultCode'] = resultCode;
    return data;
  }

  factory LoginResponse.fromSignup(SignupResponse signupResponse) {
    final accessToken = signupResponse.data.accessToken;
    final password = signupResponse.data.password;
    final nickname = signupResponse.data.nickname;
    final roleName = signupResponse.data.roleName;
    final userId = signupResponse.data.userId;
    final expiresIn = signupResponse.data.expiresIn;
    final currentTime = signupResponse.currentTime;
    final resultCode = signupResponse.resultCode;
    final role = signupResponse.data.role;
    return LoginResponse(
      currentTime: currentTime,
      resultCode: resultCode,
      data: Data(
        accessToken: accessToken,
        password: password,
        nickname: nickname,
        roleName: roleName,
        userId: userId,
        expiresIn: expiresIn,
        role: role,
      ),
    );
  }

  LoginResponse copyWith({
    int? currentTime,
    Data? data,
    int? resultCode,
  }) {
    return LoginResponse(
      currentTime: currentTime ?? this.currentTime,
      data: data ?? this.data,
      resultCode: resultCode ?? this.resultCode,
    );
  }

  @override
  List<Object?> get props => [currentTime, data, resultCode];
}

class Data with EquatableMixin {
  Data({
    this.birthday,
    this.settings,
    this.friendCount,
    this.role,
    this.offlineNoPushMsg,
    this.sex,
    this.multipleDevices,
    this.isWapChatShowPhone,
    this.telephone,
    this.login,
    this.userId,
    this.myInviteCode,
    this.accessToken,
    this.password,
    this.nickname,
    this.roleName,
    this.userType,
    this.isupdate,
    this.expiresIn,
    this.payPassword,
  });

  // Data.fromJson(Map<String, dynamic> json) {
  //   birthday = json['birthday'];
  //   settings =
  //       json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  //   friendCount = json['friendCount'];
  //   role = json['role'].cast<int>();
  //   offlineNoPushMsg = json['offlineNoPushMsg'];
  //   sex = json['sex'];
  //   multipleDevices = json['multipleDevices'];
  //   isWapChatShowPhone = json['is_wap_chat_show_phone'];
  //   telephone = json['telephone'];
  //   login = json['login'] != null ? Login.fromJson(json['login']) : null;
  //   userId = json['userId'];
  //   myInviteCode = json['myInviteCode'];
  //   accessToken = json['access_token'];
  //   password = json['password'];
  //   nickname = json['nickname'];
  //   roleName = json['roleName'];
  //   userType = json['userType'];
  //   isupdate = json['isupdate'];
  //   expiresIn = json['expires_in'];
  //   payPassword = json['payPassword'];
  // }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      birthday: json['birthday'],
      settings:
          json['settings'] != null ? Settings.fromJson(json['settings']) : null,
      friendCount: json['friendCount'],
      role: json['role'].cast<int>(),
      offlineNoPushMsg: json['offlineNoPushMsg'],
      sex: json['sex'],
      multipleDevices: json['multipleDevices'],
      isWapChatShowPhone: json['is_wap_chat_show_phone'],
      telephone: json['telephone'],
      login: json['login'] != null ? Login.fromJson(json['login']) : null,
      userId: json['userId'],
      myInviteCode: json['myInviteCode'],
      accessToken: json['access_token'],
      password: json['password'],
      nickname: json['nickname'],
      roleName: json['roleName'],
      userType: json['userType'],
      isupdate: json['isupdate'],
      expiresIn: json['expires_in'],
      payPassword: json['payPassword'],
    );
  }

  final int? birthday;
  final Settings? settings;
  final int? friendCount;
  final List<int>? role;
  final int? offlineNoPushMsg;
  final int? sex;
  final int? multipleDevices;
  final int? isWapChatShowPhone;
  final String? telephone;
  final Login? login;
  final int? userId;
  final String? myInviteCode;
  final String? accessToken;
  final String? password;
  final String? nickname;
  final String? roleName;
  final int? userType;
  final int? isupdate;
  final int? expiresIn;
  final int? payPassword;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['birthday'] = birthday;
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    data['friendCount'] = friendCount;
    data['role'] = role;
    data['offlineNoPushMsg'] = offlineNoPushMsg;
    data['sex'] = sex;
    data['multipleDevices'] = multipleDevices;
    data['is_wap_chat_show_phone'] = isWapChatShowPhone;
    data['telephone'] = telephone;
    if (login != null) {
      data['login'] = login!.toJson();
    }
    data['userId'] = userId;
    data['myInviteCode'] = myInviteCode;
    data['access_token'] = accessToken;
    data['password'] = password;
    data['nickname'] = nickname;
    data['roleName'] = roleName;
    data['userType'] = userType;
    data['isupdate'] = isupdate;
    data['expires_in'] = expiresIn;
    data['payPassword'] = payPassword;
    return data;
  }

  @override
  List<Object?> get props {
    return [
      birthday,
      settings,
      friendCount,
      role,
      offlineNoPushMsg,
      sex,
      multipleDevices,
      isWapChatShowPhone,
      telephone,
      login,
      userId,
      myInviteCode,
      accessToken,
      password,
      nickname,
      roleName,
      userType,
      isupdate,
      expiresIn,
      payPassword,
    ];
  }

  Data copyWith({
    int? birthday,
    Settings? settings,
    int? friendCount,
    List<int>? role,
    int? offlineNoPushMsg,
    int? sex,
    int? multipleDevices,
    int? isWapChatShowPhone,
    String? telephone,
    Login? login,
    int? userId,
    String? myInviteCode,
    String? accessToken,
    String? password,
    String? nickname,
    String? roleName,
    int? userType,
    int? isupdate,
    int? expiresIn,
    int? payPassword,
  }) {
    return Data(
      birthday: birthday ?? this.birthday,
      settings: settings ?? this.settings,
      friendCount: friendCount ?? this.friendCount,
      role: role ?? this.role,
      offlineNoPushMsg: offlineNoPushMsg ?? this.offlineNoPushMsg,
      sex: sex ?? this.sex,
      multipleDevices: multipleDevices ?? this.multipleDevices,
      isWapChatShowPhone: isWapChatShowPhone ?? this.isWapChatShowPhone,
      telephone: telephone ?? this.telephone,
      login: login ?? this.login,
      userId: userId ?? this.userId,
      myInviteCode: myInviteCode ?? this.myInviteCode,
      accessToken: accessToken ?? this.accessToken,
      password: password ?? this.password,
      nickname: nickname ?? this.nickname,
      roleName: roleName ?? this.roleName,
      userType: userType ?? this.userType,
      isupdate: isupdate ?? this.isupdate,
      expiresIn: expiresIn ?? this.expiresIn,
      payPassword: payPassword ?? this.payPassword,
    );
  }
}

class Settings with EquatableMixin {
  Settings({
    this.allowAtt,
    this.allowGreet,
    this.chatRecordTimeOut,
    this.chatSyncTimeLen,
    this.closeTelephoneFind,
    this.friendsVerify,
    this.isEncrypt,
    this.isTyping,
    this.isUseGoogleMap,
    this.isVibration,
    this.multipleDevices,
    this.openService,
  });

  Settings.fromJson(Map<String, dynamic> json) {
    allowAtt = json['allowAtt']?.toString();
    allowGreet = json['allowGreet']?.toString();
    chatRecordTimeOut = json['chatRecordTimeOut']?.toString();
    chatSyncTimeLen = json['chatSyncTimeLen']?.toString();
    closeTelephoneFind = json['closeTelephoneFind']?.toString();
    friendsVerify = json['friendsVerify']?.toString();
    isEncrypt = json['isEncrypt']?.toString();
    isTyping = json['isTyping']?.toString();
    isUseGoogleMap = json['isUseGoogleMap']?.toString();
    isVibration = json['isVibration']?.toString();
    multipleDevices = json['multipleDevices']?.toString();
    openService = json['openService']?.toString();
  }
  String? allowAtt;
  String? allowGreet;
  String? chatRecordTimeOut;
  String? chatSyncTimeLen;
  String? closeTelephoneFind;
  String? friendsVerify;
  String? isEncrypt;
  String? isTyping;
  String? isUseGoogleMap;
  String? isVibration;
  String? multipleDevices;
  String? openService;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['allowAtt'] = allowAtt;
    data['allowGreet'] = allowGreet;
    data['chatRecordTimeOut'] = chatRecordTimeOut;
    data['chatSyncTimeLen'] = chatSyncTimeLen;
    data['closeTelephoneFind'] = closeTelephoneFind;
    data['friendsVerify'] = friendsVerify;
    data['isEncrypt'] = isEncrypt;
    data['isTyping'] = isTyping;
    data['isUseGoogleMap'] = isUseGoogleMap;
    data['isVibration'] = isVibration;
    data['multipleDevices'] = multipleDevices;
    data['openService'] = openService;
    return data;
  }

  Settings copyWith({
    String? allowAtt,
    String? allowGreet,
    String? chatRecordTimeOut,
    String? chatSyncTimeLen,
    String? closeTelephoneFind,
    String? friendsVerify,
    String? isEncrypt,
    String? isTyping,
    String? isUseGoogleMap,
    String? isVibration,
    String? multipleDevices,
    String? openService,
  }) {
    return Settings(
      allowAtt: allowAtt ?? this.allowAtt,
      allowGreet: allowGreet ?? this.allowGreet,
      chatRecordTimeOut: chatRecordTimeOut ?? this.chatRecordTimeOut,
      chatSyncTimeLen: chatSyncTimeLen ?? this.chatSyncTimeLen,
      closeTelephoneFind: closeTelephoneFind ?? this.closeTelephoneFind,
      friendsVerify: friendsVerify ?? this.friendsVerify,
      isEncrypt: isEncrypt ?? this.isEncrypt,
      isTyping: isTyping ?? this.isTyping,
      isUseGoogleMap: isUseGoogleMap ?? this.isUseGoogleMap,
      isVibration: isVibration ?? this.isVibration,
      multipleDevices: multipleDevices ?? this.multipleDevices,
      openService: openService ?? this.openService,
    );
  }

  @override
  List<Object?> get props {
    return [
      allowAtt,
      allowGreet,
      chatRecordTimeOut,
      chatSyncTimeLen,
      closeTelephoneFind,
      friendsVerify,
      isEncrypt,
      isTyping,
      isUseGoogleMap,
      isVibration,
      multipleDevices,
      openService,
    ];
  }
}

class Login with EquatableMixin {
  Login({
    this.isFirstLogin,
    this.latitude,
    this.loginTime,
    this.longitude,
    this.model,
    this.offlineTime,
    this.serial,
  });

  Login.fromJson(Map<String, dynamic> json) {
    isFirstLogin = json['isFirstLogin'];
    latitude = json['latitude'];
    loginTime = json['loginTime'];
    longitude = json['longitude'];
    model = json['model'];
    offlineTime = json['offlineTime'];
    serial = json['serial'];
  }
  int? isFirstLogin;
  double? latitude;
  int? loginTime;
  double? longitude;
  String? model;
  int? offlineTime;
  String? serial;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isFirstLogin'] = isFirstLogin;
    data['latitude'] = latitude;
    data['loginTime'] = loginTime;
    data['longitude'] = longitude;
    data['model'] = model;
    data['offlineTime'] = offlineTime;
    data['serial'] = serial;
    return data;
  }

  @override
  List<Object?> get props {
    return [
      isFirstLogin,
      latitude,
      loginTime,
      longitude,
      model,
      offlineTime,
      serial,
    ];
  }
}
