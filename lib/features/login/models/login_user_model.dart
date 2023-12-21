// To parse this JSON data, do
//
//     final previousLoginUserData = previousLoginUserDataFromJson(jsonString);

import 'dart:convert';

PreviousLoginUserData previousLoginUserDataFromJson(String str) =>
    PreviousLoginUserData.fromJson(json.decode(str));

String previousLoginUserDataToJson(PreviousLoginUserData data) =>
    json.encode(data.toJson());

class PreviousLoginUserData {
  PreviousLoginUserData({
    required this.currentTime,
    required this.data,
    required this.resultCode,
  });

  factory PreviousLoginUserData.fromJson(Map<String, dynamic> json) =>
      PreviousLoginUserData(
        currentTime: json['currentTime'] ?? '',
        data: List<Data>.from(json['data'].map((x) => Data.fromJson(x))),
        resultCode: json['resultCode'],
      );
  int currentTime;
  List<Data> data;
  int resultCode;

  Map<String, dynamic> toJson() => {
        'currentTime': currentTime,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
        'resultCode': resultCode,
      };
}

class Data {
  Data({
    required this.password,
    required this.nickname,
    required this.telephone,
    required this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        password: json['password'] ?? '',
        nickname: json['nickname'] ?? '',
        telephone: json['telephone'] ?? '',
        userId: json['userId'] ?? '',
      );
  String password;
  String nickname;
  String telephone;
  int userId;

  Map<String, dynamic> toJson() => {
        'password': password,
        'nickname': nickname,
        'telephone': telephone,
        'userId': userId,
      };
}
