// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:sf_chat_im/features/chat/models/chat_history_list_model.dart';
import 'package:sf_chat_im/features/chat/models/chat_members_model.dart';
import 'package:sf_chat_im/features/login/models/login_response.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';

class ChatHistoryState extends Equatable {
  const ChatHistoryState({
    this.chatListFetchStatus = ApiFetchStatus.idle,
    this.chatLoadMoreStatus = ApiFetchStatus.idle,
    this.offset = 0,
    this.canLoadMore = true,
    this.chatHistoryData,
    this.composedId,
    this.chatList = const [],
    this.imageUploadStatus,
    this.uploadedChat,
    this.isInitialLoad = false,
    this.loginResponse,
    this.emitTime,
    this.isReadUpdateEmit = false,
  });

  final ChatHistoryListData? chatHistoryData;
  final List<ChatModel> chatList;
  final ApiFetchStatus chatListFetchStatus;
  final ApiFetchStatus chatLoadMoreStatus;
  final int offset;
  final bool canLoadMore;
  final ComposedId? composedId;
  final String? imageUploadStatus;
  final ChatModel? uploadedChat;
  final bool isInitialLoad;
  final LoginResponse? loginResponse;

  final int? emitTime;
  final bool isReadUpdateEmit;
  @override
  List<Object?> get props {
    return [
      chatListFetchStatus,
      chatLoadMoreStatus,
      offset,
      canLoadMore,
      chatList,
      chatHistoryData,
      composedId,
      imageUploadStatus,
      uploadedChat,
      isInitialLoad,
      loginResponse,
      emitTime,
      isReadUpdateEmit
    ];
  }

  ChatHistoryState copyWith({
    ChatHistoryListData? chatHistoryData,
    List<ChatModel>? chatList,
    ApiFetchStatus? chatListFetchStatus,
    ApiFetchStatus? chatLoadMoreStatus,
    int? offset,
    bool? canLoadMore,
    ComposedId? composedId,
    bool clearComposeId = false,
    String? imageUploadStatus,
    ChatModel? uploadedChat,
    bool clearUploadedImage = false,
    bool isInitialLoad = false,
    LoginResponse? loginResponse,
    int? emitTime,
    bool isReadUpdateEmit = false,
  }) {
    return ChatHistoryState(
      chatHistoryData: chatHistoryData ?? this.chatHistoryData,
      chatList: chatList ?? this.chatList,
      chatListFetchStatus: chatListFetchStatus ?? this.chatListFetchStatus,
      chatLoadMoreStatus: chatLoadMoreStatus ?? this.chatLoadMoreStatus,
      offset: offset ?? this.offset,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      composedId: clearComposeId ? null : composedId ?? this.composedId,
      imageUploadStatus: imageUploadStatus ?? this.imageUploadStatus,
      uploadedChat:
          clearUploadedImage ? null : uploadedChat ?? this.uploadedChat,
      isInitialLoad: isInitialLoad,
      loginResponse: loginResponse ?? this.loginResponse,
      emitTime: emitTime ?? this.emitTime,
      isReadUpdateEmit: isReadUpdateEmit,
    );
  }
}
