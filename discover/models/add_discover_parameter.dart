// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sf_chat_im/shared/utilities/extensions.dart';

class DiscoverParameter {
  final String? address;
  final String? apiVersion;
  final int? areaId;
  final String? audios;
  final int? cityId;
  final String? cityName;
  final int? countryId;
  final String? files;

  /// [Message Tags]: 1=job search; 2=recruitment; 3=general; Most of the time, this field is 3
  final int? flag;
  final String? images;
  final String? label;
  final num? latitude;
  final String? location;
  final num? longitude;
  final String? messageId;
  final String? model;
  final String? musicId;
  final String? osVersion;
  final int? provinceId;
  final String? remark;
  final String? sdkIcon;
  final String? sdkTitle;
  final String? sdkUrl;
  final String? serial;
  final String? nickName;
  final int? source;

  ///Message content
  final String? text;
  final int? time;
  final String? title;

  ///*[Message types]: 1=text message; 2=image message; 3=voice message; 4=video message;
  final int type;

  /// Who can watch this message. Only when [visible] is 3, this field is valid.
  final String? userLook;

  /// Who can not watch this message. Only when [visible] is 4, this field is valid.
  final String? userNotLook;

  /// Who can be reminded to watch this message.
  final String? userRemindLook;
  final String? videos;

  ///*[Message Privacy Scope]: 1=public; 2=private; 3=partially visible; 4=not visible;
  final String? visible;
  final String? kto;

  DiscoverParameter({
    this.address,
    this.apiVersion,
    this.areaId,
    this.audios,
    this.cityId,
    this.cityName,
    this.countryId,
    this.files,
    this.flag,
    this.images,
    this.label,
    this.latitude = 0.0,
    this.location,
    this.longitude = 0.0,
    this.messageId,
    this.model,
    this.musicId,
    this.osVersion,
    this.provinceId,
    this.remark,
    this.sdkIcon,
    this.sdkTitle,
    this.sdkUrl,
    this.serial,
    this.nickName,
    this.source,
    this.text,
    this.time,
    this.title,
    required this.type,
    this.userLook,
    this.userNotLook,
    this.userRemindLook,
    this.videos,
    this.visible = '1',
    this.kto,
  });

  DiscoverParameter.text({
    this.address,
    this.apiVersion,
    this.areaId,
    this.audios,
    this.cityId = 0,
    this.cityName,
    this.countryId,
    this.files,
    this.flag = 3,
    this.images,
    this.label,
    this.latitude = 0.0,
    this.location,
    this.longitude = 0.0,
    this.messageId,
    this.model,
    this.musicId,
    this.osVersion,
    this.provinceId,
    this.remark,
    this.sdkIcon,
    this.sdkTitle,
    this.sdkUrl,
    this.serial,
    this.nickName,
    this.source,
    required this.text,
    this.time,
    this.title,
    this.type = 1,
    this.userLook,
    this.userNotLook,
    this.userRemindLook,
    this.videos,
    this.visible = '1',
    this.kto,
  });

  DiscoverParameter.image({
    this.address,
    this.apiVersion,
    this.areaId,
    this.audios,
    this.cityId = 0,
    this.cityName,
    this.countryId,
    this.files,
    this.flag = 3,
    this.images,
    this.label,
    this.latitude = 0.0,
    this.location,
    this.longitude = 0.0,
    this.messageId,
    this.model,
    this.musicId,
    this.osVersion,
    this.provinceId,
    this.remark,
    this.sdkIcon,
    this.sdkTitle,
    this.sdkUrl,
    this.serial,
    this.nickName,
    this.source,
    this.text,
    this.time,
    this.title,
    this.type = 2,
    this.userLook,
    this.userNotLook,
    this.userRemindLook,
    this.videos,
    this.visible = '1',
    this.kto,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..addIfNotNull('address', address)
    ..addIfNotNull('apiVersion', apiVersion)
    ..addIfNotNull('areaId', areaId)
    ..addIfNotNull('audios', audios)
    ..addIfNotNull('cityId', cityId)
    ..addIfNotNull('cityName', cityName)
    ..addIfNotNull('countryId', countryId)
    ..addIfNotNull('files', files)
    ..addIfNotNull('flag', flag)
    ..addIfNotNull('images', images)
    ..addIfNotNull('lable', label)
    ..addIfNotNull('latitude', latitude)
    ..addIfNotNull('location', location)
    ..addIfNotNull('longitude', longitude)
    ..addIfNotNull('messageId', messageId)
    ..addIfNotNull('model', model)
    ..addIfNotNull('musicId', musicId)
    ..addIfNotNull('osVersion', osVersion)
    ..addIfNotNull('provinceId', provinceId)
    ..addIfNotNull('remark', remark)
    ..addIfNotNull('sdkIcon', sdkIcon)
    ..addIfNotNull('sdkTitle', sdkTitle)
    ..addIfNotNull('sdkUrl', sdkUrl)
    ..addIfNotNull('serial', serial)
    ..addIfNotNull('nickName', nickName)
    ..addIfNotNull('source', source)
    ..addIfNotNull('text', text)
    ..addIfNotNull('time', time)
    ..addIfNotNull('title', title)
    ..addIfNotNull('type', type)
    ..addIfNotNull('userLook', userLook)
    ..addIfNotNull('userNotLook', userNotLook)
    ..addIfNotNull('userRemindLook', userRemindLook)
    ..addIfNotNull('videos', videos)
    ..addIfNotNull('visible', visible)
    ..addIfNotNull('kto', kto);

  DiscoverParameter copyWith({
    String? address,
    String? apiVersion,
    int? areaId,
    String? audios,
    int? cityId,
    String? cityName,
    int? countryId,
    String? files,
    int? flag,
    String? images,
    String? label,
    num? latitude,
    String? location,
    num? longitude,
    String? messageId,
    String? model,
    String? musicId,
    String? osVersion,
    int? provinceId,
    String? remark,
    String? sdkIcon,
    String? sdkTitle,
    String? sdkUrl,
    String? serial,
    String? nickName,
    int? source,
    String? text,
    int? time,
    String? title,
    int? type,
    String? userLook,
    String? userNotLook,
    String? userRemindLook,
    String? videos,
    String? visible,
    String? kto,
  }) {
    return DiscoverParameter(
      address: address ?? this.address,
      apiVersion: apiVersion ?? this.apiVersion,
      areaId: areaId ?? this.areaId,
      audios: audios ?? this.audios,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      countryId: countryId ?? this.countryId,
      files: files ?? this.files,
      flag: flag ?? this.flag,
      images: images ?? this.images,
      label: label ?? this.label,
      latitude: latitude ?? this.latitude,
      location: location ?? this.location,
      longitude: longitude ?? this.longitude,
      messageId: messageId ?? this.messageId,
      model: model ?? this.model,
      musicId: musicId ?? this.musicId,
      osVersion: osVersion ?? this.osVersion,
      provinceId: provinceId ?? this.provinceId,
      remark: remark ?? this.remark,
      sdkIcon: sdkIcon ?? this.sdkIcon,
      sdkTitle: sdkTitle ?? this.sdkTitle,
      sdkUrl: sdkUrl ?? this.sdkUrl,
      serial: serial ?? this.serial,
      nickName: nickName ?? this.nickName,
      source: source ?? this.source,
      text: text ?? this.text,
      time: time ?? this.time,
      title: title ?? this.title,
      type: type ?? this.type,
      userLook: userLook ?? this.userLook,
      userNotLook: userNotLook ?? this.userNotLook,
      userRemindLook: userRemindLook ?? this.userRemindLook,
      videos: videos ?? this.videos,
      visible: visible ?? this.visible,
      kto: kto ?? this.kto,
    );
  }
}
