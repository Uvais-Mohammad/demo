// To parse this JSON data, do
//
//     final signupResponse = signupResponseFromJson(jsonString);

import 'dart:convert';

SignupResponse signupResponseFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
  SignupResponse({
    required this.currentTime,
    required this.data,
    required this.resultCode,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        currentTime: json['currentTime'],
        data: Data.fromJson(json['data']),
        resultCode: json['resultCode'],
      );
  final int currentTime;
  final Data data;
  final int resultCode;

  Map<String, dynamic> toJson() => {
        'currentTime': currentTime,
        'data': data.toJson(),
        'resultCode': resultCode,
      };
}

class Data {
  Data({
    required this.accessToken,
    required this.password,
    required this.role,
    required this.createTime,
    required this.nickname,
    required this.name,
    required this.roleName,
    required this.expiresIn,
    required this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json['access_token'],
        password: json['password'],
        role: List<int>.from(json['role'].map((dynamic x) => x)),
        createTime: json['createTime'],
        nickname: json['nickname'],
        name: json['name'],
        roleName: json['roleName'],
        expiresIn: json['expires_in'],
        userId: json['userId'],
      );
  final String accessToken;
  final String password;
  final List<int> role;
  final int createTime;
  final String nickname;
  final String name;
  final String roleName;
  final int expiresIn;
  final int userId;

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'password': password,
        'role': List<dynamic>.from(role.map((x) => x)),
        'createTime': createTime,
        'nickname': nickname,
        'name': name,
        'roleName': roleName,
        'expires_in': expiresIn,
        'userId': userId,
      };
}
