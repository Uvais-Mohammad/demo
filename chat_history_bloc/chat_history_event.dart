import 'package:equatable/equatable.dart';
import 'package:sf_chat_im/features/chat/models/chat_history_list_model.dart';
import 'package:sf_chat_im/features/chat/models/chat_members_model.dart';
import 'package:sf_chat_im/features/login/models/login_response.dart';

sealed class ChatHistoryEvent extends Equatable {
  const ChatHistoryEvent(this.receiver);
  final String receiver;
  @override
  List<Object?> get props => [];
}

sealed class ChatHistoryLoadEvent extends ChatHistoryEvent {
  const ChatHistoryLoadEvent(super.receiver);
}

class ChatHistoryInitialEvent extends ChatHistoryEvent {
  const ChatHistoryInitialEvent(super.receiver);
}

class SendMessageEvent extends ChatHistoryEvent {
  const SendMessageEvent(
    super.receiver, {
    required this.chat,
    required this.fromUserName,
    required this.toFullJid,
    this.type,
  });
  final ChatModel chat;
  final String fromUserName;
  final String toFullJid;
  final String? type;
}

class UpdateImageUpdateStatus extends ChatHistoryEvent {
  final ChatModel chatModel;

  UpdateImageUpdateStatus(super.receiver, this.chatModel);
}

class ChatHistoryInitialLoadRequested extends ChatHistoryLoadEvent {
  const ChatHistoryInitialLoadRequested(
    super.receiver, {
    required this.composedId,
    required this.loginResponse,
    required this.lastSyncTime,
    required this.timeSend,
    required this.isGroup,
  });
  final ComposedId composedId;
  final LoginResponse? loginResponse;
  final int lastSyncTime;
  final int timeSend;
  final bool isGroup;
}

class SyncChatHistory extends ChatHistoryEvent {
  const SyncChatHistory(super.receiver, this.lastSyncMessageTime);
  final int lastSyncMessageTime;
}

class ChatHistoryRefreshRequested extends ChatHistoryLoadEvent {
  const ChatHistoryRefreshRequested(super.receiver);
}

class ChatHistoryLoadMoreRequested extends ChatHistoryLoadEvent {
  const ChatHistoryLoadMoreRequested(super.receiver);
}

// class _chatHistoryUpdateReadStatusRealTime extends ChatHistoryEvent {
//   const _chatHistoryUpdateReadStatusRealTime(
//     super.receiver, {
//     required this.messageId,
//   });
//   final String messageId;
// }

class AddedChatFromXmpp extends ChatHistoryEvent {
  const AddedChatFromXmpp(super.receiver, this.chat);

  @override
  List<Object?> get props => [chat];

  final ChatModel chat;
}

class UploadImage extends ChatHistoryEvent {
  const UploadImage(super.receiver, this.chat);

  final ChatModel chat;
}

class UpdateReadStatusForAllNonUpdated extends ChatHistoryEvent {
  const UpdateReadStatusForAllNonUpdated(super.receiver);
}

class UpdateReadStatusOfaSingleMessage extends ChatHistoryEvent {
  const UpdateReadStatusOfaSingleMessage(super.receiver, this.message);
  final ChatModel message;
}
