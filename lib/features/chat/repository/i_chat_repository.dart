import 'package:image_picker/image_picker.dart';
import 'package:sf_chat_im/features/chat/models/chat_history_list_model.dart';
import 'package:sf_chat_im/features/chat/models/chat_members_model.dart';
import 'package:sf_chat_im/features/chat/models/group_model.dart';
import 'package:sf_chat_im/shared/enums/group_role_type.dart';
import 'package:sf_chat_im/shared/models/image_upload_response.dart';

abstract interface class IChatRepository {
  Future<ChatMembersModel?> getChatMembersData({
    required int pageNumber,
    required String? keyWord,
  });

  Future<String?> getProfileImage({
    required String userId,
    bool isThumb = true,
  });
  Future<String?> getProfileImageWithoutCache({
    required String userId,
    bool isThumb = true,
  });
  Future<ChatHistoryListData?> getChatHistoryData({
    required int pageNumber,
    required String receiver,
  });
  Future<List<ChatModel>?> getChats({
    required String receiver,
    required int startTime,
    required int endTime,
  });
  Future<List<ChatModel>?> getGroupChats({
    required String roomId,
    required int startTime,
    required int endTime,
  });

  Future<GroupModel?> createGroup({
    required String groupName,
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
    String category = '0',
  });

  Future<bool> addMembersToGroup(
      {required String groupId, required List<String> userIds});

  Future<List<GroupModel>> getListOfGroups();
  Future<bool> updateGroupInfo({
    required String groupId,
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
    String? allowSpeakCourse,
  });

  Future<GroupModel> getGroupInfo({required String groupId});
  Future<bool> deleteGroup({required String groupId});
  Future<bool> removeMembersFromGroup(
      {required String groupId, required String userId});
  Future<bool> reportGroup({required String groupId, required String reason});
  Future<bool> setMemberRole({
    required String groupId,
    required String userId,
    required GroupRoleType role,
  });
  Future<ImageUploadResponse?> uploadImage(String path);
  Future<XFile?> pickImage(ImageSource imageSource, [int? imageQuality = 50]);
  Future<String?> getNickName(String userId);
}
