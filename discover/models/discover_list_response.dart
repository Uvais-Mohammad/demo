// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:equatable/equatable.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';

class DiscoverListResponse extends Equatable {
  final int? currentTime;
  final List<DiscoverData>? data;
  final int? resultCode;

  const DiscoverListResponse({this.currentTime, this.data, this.resultCode});

  factory DiscoverListResponse.fromJson(Map<String, dynamic> json) {
    return DiscoverListResponse(
      currentTime: json['currentTime'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => DiscoverData.fromJson(i)).toList()
          : null,
      resultCode: json['resultCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['currentTime'] = this.currentTime;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['resultCode'] = this.resultCode;
    return data;
  }

  @override
  List<Object?> get props => [currentTime, data, resultCode];

  DiscoverListResponse copyWith({
    int? currentTime,
    List<DiscoverData>? data,
    int? resultCode,
  }) {
    return DiscoverListResponse(
      currentTime: currentTime ?? this.currentTime,
      data: data ?? this.data,
      resultCode: resultCode ?? this.resultCode,
    );
  }
}

class DiscoverData extends Equatable {
  final Body? body;
  final int? cityId;
  final List<Comments>? comments;
  final Count? count;
  final int? flag;
  final List<Gifts>? gifts;
  final int? isCollect;
  final int? isPraise;
  final double? latitude;
  final double? longitude;
  final String? model;
  final String? msgId;
  final String? nickname;
  final List<Praises>? praises;
  final int? state;
  final int? time;
  final int? userId;
  final int? visible;
  final String? fileName;
  final ApiFetchStatus? commentingStatus;

  const DiscoverData({
    this.body,
    this.cityId,
    this.comments,
    this.count,
    this.flag,
    this.gifts,
    this.isCollect,
    this.isPraise,
    this.latitude,
    this.longitude,
    this.model,
    this.msgId,
    this.nickname,
    this.praises,
    this.state,
    this.time,
    this.userId,
    this.visible,
    this.fileName,
    this.commentingStatus,
  });

  factory DiscoverData.fromJson(Map<String, dynamic> json) {
    return DiscoverData(
      body: json['body'] != null ? Body.fromJson(json['body']) : null,
      cityId: json['cityId'],
      comments: json['comments'] != null
          ? (json['comments'] as List).map((i) => Comments.fromJson(i)).toList()
          : null,
      count: json['count'] != null ? Count.fromJson(json['count']) : null,
      flag: json['flag'],
      gifts: json['gifts'] != null
          ? (json['gifts'] as List).map((i) => Gifts.fromJson(i)).toList()
          : null,
      isCollect: json['isCollect'],
      isPraise: json['isPraise'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      model: json['model'],
      msgId: json['msgId'],
      nickname: json['nickname'],
      praises: json['praises'] != null
          ? (json['praises'] as List).map((i) => Praises.fromJson(i)).toList()
          : null,
      state: json['state'],
      time: json['time'],
      userId: json['userId'],
      visible: json['visible'],
      fileName: json['fileName'],
      commentingStatus: json['commentingStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    data['cityId'] = this.cityId;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    data['flag'] = this.flag;
    if (this.gifts != null) {
      data['gifts'] = this.gifts!.map((v) => v.toJson()).toList();
    }
    data['isCollect'] = this.isCollect;
    data['isPraise'] = this.isPraise;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['model'] = this.model;
    data['msgId'] = this.msgId;
    data['nickname'] = this.nickname;
    if (this.praises != null) {
      data['praises'] = this.praises!.map((v) => v.toJson()).toList();
    }
    data['state'] = this.state;
    data['time'] = this.time;
    data['userId'] = this.userId;
    data['visible'] = this.visible;
    data['fileName'] = this.fileName;
    data['commentingStatus'] = this.commentingStatus;
    return data;
  }

  @override
  List<Object?> get props => [
        body,
        cityId,
        comments,
        count,
        flag,
        gifts,
        isCollect,
        isPraise,
        latitude,
        longitude,
        model,
        msgId,
        nickname,
        praises,
        state,
        time,
        userId,
        visible,
        fileName,
        commentingStatus,
      ];

  DiscoverData copyWith({
    Body? body,
    int? cityId,
    List<Comments>? comments,
    Count? count,
    int? flag,
    List<Gifts>? gifts,
    int? isCollect,
    int? isPraise,
    double? latitude,
    double? longitude,
    String? model,
    String? msgId,
    String? nickname,
    List<Praises>? praises,
    int? state,
    int? time,
    int? userId,
    int? visible,
    String? fileName,
    ApiFetchStatus? commentingStatus,
  }) {
    return DiscoverData(
      body: body ?? this.body,
      cityId: cityId ?? this.cityId,
      comments: comments ?? this.comments,
      count: count ?? this.count,
      flag: flag ?? this.flag,
      gifts: gifts ?? this.gifts,
      isCollect: isCollect ?? this.isCollect,
      isPraise: isPraise ?? this.isPraise,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      model: model ?? this.model,
      msgId: msgId ?? this.msgId,
      nickname: nickname ?? this.nickname,
      praises: praises ?? this.praises,
      state: state ?? this.state,
      time: time ?? this.time,
      userId: userId ?? this.userId,
      visible: visible ?? this.visible,
      fileName: fileName ?? this.fileName,
      commentingStatus: commentingStatus ?? this.commentingStatus,
    );
  }
}

class Body extends Equatable {
  final List<Images>? images;
  final String? text;
  final int? time;
  final int? type;
  final List<Audios>? audios;
  final List<Files>? files;

  const Body(
      {this.images, this.text, this.time, this.type, this.audios, this.files});

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      images: json['images'] != null
          ? (json['images'] as List).map((i) => Images.fromJson(i)).toList()
          : null,
      text: json['text'],
      time: json['time'],
      type: json['type'],
      audios: json['audios'] != null
          ? (json['audios'] as List).map((i) => Audios.fromJson(i)).toList()
          : null,
      files: json['files'] != null
          ? (json['files'] as List).map((i) => Files.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['text'] = this.text;
    data['time'] = this.time;
    data['type'] = this.type;
    if (this.audios != null) {
      data['audios'] = this.audios!.map((v) => v.toJson()).toList();
    }
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [images, text, time, type, audios, files];
}

class Images extends Equatable {
  final int? length;
  final String? oUrl;
  final int? size;
  final String? tUrl;
  final String? localImage;

  const Images({this.length, this.oUrl, this.size, this.tUrl, this.localImage});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      length: json['length'],
      oUrl: json['oUrl'],
      size: json['size'],
      tUrl: json['tUrl'],
      localImage: json['localImage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['length'] = this.length;
    data['oUrl'] = this.oUrl;
    data['size'] = this.size;
    data['tUrl'] = this.tUrl;
    data['localImage'] = this.localImage;
    return data;
  }

  @override
  List<Object?> get props => [length, oUrl, size, tUrl, localImage];
}

class Audios extends Equatable {
  final int? length;
  final String? oUrl;
  final int? size;

  Audios({this.length, this.oUrl, this.size});

  factory Audios.fromJson(Map<String, dynamic> json) {
    return Audios(
      length: json['length'],
      oUrl: json['oUrl'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['length'] = this.length;
    data['oUrl'] = this.oUrl;
    data['size'] = this.size;
    return data;
  }

  @override
  List<Object?> get props => [length, oUrl, size];
}

class Files extends Equatable {
  final int? length;
  final String? oFileName;
  final String? oUrl;
  final int? size;
  final String? tUrl;

  const Files({this.length, this.oFileName, this.oUrl, this.size, this.tUrl});

  factory Files.fromJson(Map<String, dynamic> json) {
    return Files(
      length: json['length'],
      oFileName: json['oFileName'],
      oUrl: json['oUrl'],
      size: json['size'],
      tUrl: json['tUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['length'] = this.length;
    data['oFileName'] = this.oFileName;
    data['oUrl'] = this.oUrl;
    data['size'] = this.size;
    data['tUrl'] = this.tUrl;
    return data;
  }

  @override
  List<Object?> get props => [length, oFileName, oUrl, size, tUrl];
}

class Comments extends Equatable {
  final String? body;
  final String? commentId;
  final String? msgId;
  final String? nickname;
  final int? time;
  final int? toUserId;
  final int? userId;

  const Comments({
    this.body,
    this.commentId,
    this.msgId,
    this.nickname,
    this.time,
    this.toUserId,
    this.userId,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      body: json['body'],
      commentId: json['commentId'],
      msgId: json['msgId'],
      nickname: json['nickname'],
      time: json['time'],
      toUserId: json['toUserId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['body'] = this.body;
    data['commentId'] = this.commentId;
    data['msgId'] = this.msgId;
    data['nickname'] = this.nickname;
    data['time'] = this.time;
    data['toUserId'] = this.toUserId;
    data['userId'] = this.userId;
    return data;
  }

  @override
  List<Object?> get props =>
      [body, commentId, msgId, nickname, time, toUserId, userId];
}

class Count extends Equatable {
  final int? collect;
  final int? comment;
  final int? forward;
  final int? money;
  final int? play;
  final int? praise;
  final int? share;
  final int? total;

  const Count({
    this.collect,
    this.comment,
    this.forward,
    this.money,
    this.play,
    this.praise,
    this.share,
    this.total,
  });

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      collect: json['collect'],
      comment: json['comment'],
      forward: json['forward'],
      money: json['money'],
      play: json['play'],
      praise: json['praise'],
      share: json['share'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['collect'] = this.collect;
    data['comment'] = this.comment;
    data['forward'] = this.forward;
    data['money'] = this.money;
    data['play'] = this.play;
    data['praise'] = this.praise;
    data['share'] = this.share;
    data['total'] = this.total;
    return data;
  }

  @override
  List<Object?> get props =>
      [collect, comment, forward, money, play, praise, share, total];

  Count copyWith({
    int? collect,
    int? comment,
    int? forward,
    int? money,
    int? play,
    int? praise,
    int? share,
    int? total,
  }) {
    return Count(
      collect: collect ?? this.collect,
      comment: comment ?? this.comment,
      forward: forward ?? this.forward,
      money: money ?? this.money,
      play: play ?? this.play,
      praise: praise ?? this.praise,
      share: share ?? this.share,
      total: total ?? this.total,
    );
  }
}

class Gifts extends Equatable {
  final int? giftId;
  final String? giftName;
  final String? giftUrl;
  final int? num;

  const Gifts({this.giftId, this.giftName, this.giftUrl, this.num});

  factory Gifts.fromJson(Map<String, dynamic> json) {
    return Gifts(
      giftId: json['giftId'],
      giftName: json['giftName'],
      giftUrl: json['giftUrl'],
      num: json['num'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['giftId'] = this.giftId;
    data['giftName'] = this.giftName;
    data['giftUrl'] = this.giftUrl;
    data['num'] = this.num;
    return data;
  }

  @override
  List<Object?> get props => [giftId, giftName, giftUrl, num];
}

class Praises extends Equatable {
  final String? nickname;
  final int? userId;

  const Praises({this.nickname, this.userId});

  factory Praises.fromJson(Map<String, dynamic> json) {
    return Praises(
      nickname: json['nickname'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['userId'] = this.userId;
    return data;
  }

  @override
  List<Object?> get props => [nickname, userId];
}
