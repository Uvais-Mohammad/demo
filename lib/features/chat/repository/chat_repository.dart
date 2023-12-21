import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http_util_package/core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sf_chat_im/features/chat/models/chat_history_list_model.dart';
import 'package:sf_chat_im/features/chat/models/chat_members_model.dart';
import 'package:sf_chat_im/features/chat/models/group_model.dart';
import 'package:sf_chat_im/features/chat/repository/i_chat_repository.dart';
import 'package:sf_chat_im/features/login/models/login_response.dart';
import 'package:sf_chat_im/features/login/repository/login_repository.dart';
import 'package:sf_chat_im/features/splash/repository/i_splash_repo.dart';
import 'package:sf_chat_im/shared/api/app_urls.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/enums/group_role_type.dart';
import 'package:sf_chat_im/shared/models/image_upload_response.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:sf_chat_im/shared/utilities/on_string.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';

final class ChatRepository implements IChatRepository {
  ChatRepository();
  final splashRepo = locator<ISplashRepository>();
  final appUrl = locator<AppUrls>();
  final loginRepo = locator<LoginRepository>();
  LoginResponse? loginResponse;

  @override
  Future<ChatMembersModel?> getChatMembersData({
    required int pageNumber,
    required String? keyWord,
  }) async {
    try {
      final response = await HttpUtil().postData(
        appUrl.getChatMembersList,
        contentType: Headers.formUrlEncodedContentType,
      );
      if (response.isSuccess) {
        return ChatMembersModel.fromJson(response.responseBody);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ChatHistoryListData?> getChatHistoryData({
    required int pageNumber,
    required String receiver,
  }) async {
    try {
      // ignore: prefer_final_locals, omit_local_variable_types
      Map<String, dynamic> body = {
        'pageIndex': pageNumber,
        'pageSize': 20,
        'startTime': 0,
        'receiver': receiver,
      };
      final response = await HttpUtil().postData(
        appUrl.getChatHistoryList,
        data: body,
        contentType: Headers.formUrlEncodedContentType,
      );
      if (response.isSuccess) {
        return ChatHistoryListData.fromJson(response.responseBody);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> getProfileImage({
    required String userId,
    bool isThumb = true,
  }) async {
    // final randomNumber = Random().nextInt(10000);
    try {
      final config = await splashRepo.getConfigFromLocal();
      final intUserId = int.tryParse(userId);
      if (config == null || userId.isNullOrEmpty || intUserId == null) {
        return null;
      }
      final endPoint = config.data?.downloadAvatarUrl;
      final original = '${endPoint}avatar/o';
      final thumb = '${endPoint}avatar/t';
      final dirName = intUserId % 10000;
      String? url;
      if (isThumb) {
        url = '$thumb/$dirName/$userId.jpg';
      } else {
        url = '$original/$dirName/$userId.jpg';
      }
      return '$url';
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getProfileImageWithoutCache({
    required String userId,
    bool isThumb = true,
  }) async {
    final randomNumber = Random().nextInt(10000);
    try {
      final config = await splashRepo.getConfigFromLocal();
      final intUserId = int.tryParse(userId);
      if (config == null || userId.isNullOrEmpty || intUserId == null) {
        return null;
      }
      final endPoint = config.data?.downloadAvatarUrl;
      final original = '${endPoint}avatar/o';
      final thumb = '${endPoint}avatar/t';
      final dirName = intUserId % 10000;
      String? url;
      if (isThumb) {
        url = '$thumb/$dirName/$userId.jpg';
      } else {
        url = '$original/$dirName/$userId.jpg';
      }
      return '$url?v=$randomNumber';
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ImageUploadResponse?> uploadImage(String path) async {
    try {
      final uploadUrl = await locator<ISplashRepository>()
          .getConfigFromLocal()
          .then((value) => value?.data?.uploadUrl);
      final response = await HttpUtil().uploadFile(
        appUrl.uploadMediaUrl(uploadUrl!),
        [path],
        {},
      );
      // throwIf(!response.isSuccess, Exception('MediaUploadingFailed'));
      if (response.isSuccess) {
        return ImageUploadResponse.fromJson(response.responseBody);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<XFile?> pickImage(ImageSource imageSource,
      [int? imageQuality = 50]) async {
    try {
      if (imageSource == ImageSource.camera) {
        final result = await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: imageQuality);
        return result;
      }
      final result = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: imageQuality);
      return result;
    } on Exception catch (e) {
      if (e is OverSizedException) rethrow;
      throw UnableToProcessException();
    }
  }

  @override
  Future<List<ChatModel>?> getChats(
      {required String receiver,
      required int startTime,
      required int endTime}) async {
    try {
      // ignore: prefer_final_locals, omit_local_variable_types
      Map<String, dynamic> body = {
        'pageSize': '10000',
        'startTime': "${startTime * 1000}",
        'receiver': receiver,
        'endTime': "${endTime * 1000}"
      };
      final response = await HttpUtil().postData(
        appUrl.getChatHistoryList,
        data: body,
        contentType: Headers.formUrlEncodedContentType,
      );
      if (response.isSuccess) {
        final data = ChatHistoryListData.fromJson(response.responseBody);
        return data.chats ?? [];
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<GroupModel?> createGroup(
      {required String groupName,
      required List<String> userIds,
      required String groupDesc,
      required String jid,
      String countryId = '1',
      String showRead = '1',
      String isLook = '1',
      String isNeedVerify = '1',
      String showMember = '1',
      String allowSendCard = '1',
      String allowInviteFriend = '1',
      String allowUploadFile = '1',
      String allowConference = '1',
      String allowSpeakCourse = '1',
      String category = '0'}) async {
    Map<String, dynamic> body = {
      'name': groupName,
      'desc': groupDesc,
      'countryId': countryId,
      'showRead': showRead,
      'isLook': isLook,
      'isNeedVerify': isNeedVerify,
      'showMember': showMember,
      'allowSendCard': allowSendCard,
      'allowInviteFriend': allowInviteFriend,
      'allowUploadFile': allowUploadFile,
      'allowConference': allowConference,
      'allowSpeakCourse': allowSpeakCourse,
      'category': category,
      'jid': jid,
    };

    final response = await HttpUtil().postData(
      appUrl.roomAdd,
      data: body..addAll(defaultParameterMap(appUrl.roomAdd)),
      contentType: Headers.formUrlEncodedContentType,
    );
    if (response.isSuccess) {
      return GroupModel.fromJson(response.responseBody['data']);
    }
    return null;
  }

  @override
  Future<bool> addMembersToGroup(
      {required String groupId, required List<String> userIds}) {
    // Encode the list of user IDs individually and wrap them in square brackets
    String encodedUserIds =
        '[${userIds.map((id) => Uri.encodeComponent(id)).join(',')}]';

    final Map<String, dynamic> body = {
      'roomId': groupId,
      'text': encodedUserIds,
    };

    body.addAll(defaultParameterMap(appUrl.roomMemberUpdate));

    return HttpUtil()
        .getData(
      appUrl.roomMemberUpdate,
      data: body,
      // contentType: Headers.formUrlEncodedContentType,
    )
        .then((value) {
      throwIf(!value.isSuccess,
          CommonException(value.message ?? StringConstants.somethingWentWrong));
      return value.isSuccess;
    });
  }

  @override
  Future<List<GroupModel>> getListOfGroups() {
    final Map<String, dynamic> body = {
      'pageIndex': 0,
      'pageSize': 10000,
      'type': '0',
    };
    body.addAll(defaultParameterMap(appUrl.roomList));
    return HttpUtil()
        .getData(
      appUrl.roomList,
      data: body,
      // contentType: Headers.formUrlEncodedContentType,
    )
        .then((value) {
      if (value.isSuccess) {
        final data = GroupListModel.fromJson(value.responseBody);
        return data.data ?? [];
      }
      return [];
    });
  }

  @override
  Future<bool> updateGroupInfo(
      {required String groupId,
      String? groupName,
      String? groupDesc,
      String? countryId,
      String? showRead,
      String? isLook,
      String? isNeedVerify,
      String? showMember,
      String? allowSendCard,
      String? allowInviteFriend,
      String? allowUploadFile,
      String? allowConference,
      String? allowSpeakCourse}) {
    final Map<String, dynamic> body = {
      'roomId': groupId,
      'roomName': groupName,
      'desc': groupDesc,
      'countryId': countryId,
      'showRead': showRead,
      'isLook': isLook,
      'isNeedVerify': isNeedVerify,
      'showMember': showMember,
      'allowSendCard': allowSendCard,
      'allowInviteFriend': allowInviteFriend,
      'allowUploadFile': allowUploadFile,
      'allowConference': allowConference,
      'allowSpeakCourse': allowSpeakCourse,
    };

    return HttpUtil()
        .postData(
      appUrl.roomUpdate,
      data: body,
      contentType: Headers.formUrlEncodedContentType,
    )
        .then((value) {
      throwIf(!value.isSuccess,
          CommonException(value.message ?? StringConstants.somethingWentWrong));
      return value.isSuccess;
    });
  }

  @override
  Future<GroupModel> getGroupInfo({required String groupId}) {
    final Map<String, dynamic> body = {
      'roomId': groupId,
    };
    body.addAll(defaultParameterMap(appUrl.roomDetails));
    return HttpUtil()
        .getData(
      appUrl.roomDetails,
      data: body,
    )
        .then((value) {
      if (value.isSuccess) {
        final data = GroupModel.fromJson(value.responseBody['data']);
        return data;
      }
      throwIf(!value.isSuccess,
          CommonException(value.message ?? StringConstants.somethingWentWrong));
      return GroupModel();
    });
  }

  //this is the method to delete the group als other members to leave the group
  @override
  Future<bool> deleteGroup({required String groupId}) {
    final Map<String, dynamic> body = {
      'roomId': groupId,
    };
    body.addAll(defaultParameterMap(
      appUrl.roomDelete,
      disableSourceType: true,
    ));
    return HttpUtil()
        .postData(
      appUrl.roomDelete,
      data: body,
      contentType: Headers.formUrlEncodedContentType,
    )
        .then((value) {
      throwIf(!value.isSuccess,
          CommonException(value.message ?? StringConstants.somethingWentWrong));
      return value.isSuccess;
    });
  }

  @override
  Future<bool> removeMembersFromGroup(
      {required String groupId, required String userId}) {
    final Map<String, dynamic> body = {
      'roomId': groupId,
      'userId': userId,
    };
    body.addAll(defaultParameterMap(appUrl.roomMemberDelete));
    return HttpUtil()
        .postData(
      appUrl.roomMemberDelete,
      data: body,
      contentType: Headers.formUrlEncodedContentType,
    )
        .then((value) {
      throwIf(!value.isSuccess,
          CommonException(value.message ?? StringConstants.somethingWentWrong));
      return value.isSuccess;
    });
  }

  @override
  Future<bool> reportGroup({required String groupId, required String reason}) {
    final Map<String, dynamic> body = {
      'roomId': groupId,
      'reason': reason,
    };

    body.addAll(defaultParameterMap(appUrl.reportAUser));
    return HttpUtil()
        .postData(
      appUrl.reportAUser,
      data: body,
      contentType: Headers.formUrlEncodedContentType,
    )
        .then((value) {
      throwIf(!value.isSuccess,
          CommonException(value.message ?? StringConstants.somethingWentWrong));
      return value.isSuccess;
    });
  }

  @override
  Future<bool> setMemberRole(
      {required String groupId,
      required String userId,
      required GroupRoleType role}) {
    int roleInt = 0;
    switch (role) {
      case GroupRoleType.admin:
        roleInt = 1;
        break;
      case GroupRoleType.manager:
        roleInt = 2;
        break;
      case GroupRoleType.member:
        roleInt = 3;
        break;
      default:
    }

    final Map<String, dynamic> body = {
      'roomId': groupId,
      'userId': userId,
      'role': roleInt,
    };
    body.addAll(defaultParameterMap(appUrl.roomMemberUpdate));
    return HttpUtil()
        .postData(
      appUrl.roomMemberUpdate,
      data: body,
      contentType: Headers.formUrlEncodedContentType,
    )
        .then((value) {
      throwIf(!value.isSuccess,
          CommonException(value.message ?? StringConstants.somethingWentWrong));
      return value.isSuccess;
    });
  }

  @override
  Future<List<ChatModel>?> getGroupChats(
      {required String roomId,
      required int startTime,
      required int endTime}) async {
    try {
      // ignore: prefer_final_locals, omit_local_variable_types
      Map<String, dynamic> body = {
        'pageSize': '10000',
        'startTime': "${startTime * 1000}",
        'roomId': roomId,
        'endTime': "${endTime * 1000}"
      };
      final response = await HttpUtil().postData(
        appUrl.groupChat,
        data: body,
        contentType: Headers.formUrlEncodedContentType,
      );
      if (response.isSuccess) {
        final data = ChatHistoryListData.fromJson(response.responseBody,
            isGroupData: true);
        return data.chats ?? [];
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> getNickName(String userId) async {
    try {
      final response = await HttpUtil().postData(
        appUrl.nickName,
        data: {
          'userId': userId,
        },
        contentType: Headers.formUrlEncodedContentType,
      );
      if (response.isSuccess) {
        return response.responseBody['data']['nickname'];
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}

sealed class CustomException implements Exception {}

class NoPermissionAllowedException implements CustomException {}

class UnableToProcessException implements CustomException {}

class OverSizedException implements CustomException {}

class CommonException implements CustomException {
  final String message;
  CommonException(this.message);
}
