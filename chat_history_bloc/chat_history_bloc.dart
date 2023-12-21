import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cache_manager/core/read_cache_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sf_chat_im/features/chat/chat_variables.dart';
import 'package:sf_chat_im/features/chat/logic/already_synced_data/chat_history_fetched_ids_cubit.dart';
import 'package:sf_chat_im/features/chat/logic/chat_history_bloc/chat_history_event.dart';
import 'package:sf_chat_im/features/chat/logic/chat_history_bloc/chat_history_state.dart';
import 'package:sf_chat_im/features/chat/models/chat_history_list_model.dart';
import 'package:sf_chat_im/features/chat/models/chat_members_model.dart';
import 'package:sf_chat_im/features/chat/models/xmpp_message_model.dart';
import 'package:sf_chat_im/features/chat/repository/i_chat_repository.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/services/isar_service/compose_id_generator.dart';
import 'package:sf_chat_im/shared/services/isar_service/isar_service.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:sf_chat_im/shared/services/xmpp_new_service/xmpp_listener.dart';
import 'package:sf_chat_im/shared/utilities/on_string.dart';

class ChatHistoryBloc extends Bloc<ChatHistoryEvent, ChatHistoryState> {
  ChatHistoryBloc() : super(const ChatHistoryState()) {
    on<ChatHistoryLoadEvent>(
      (event, emit) => switch (event) {
        ChatHistoryInitialLoadRequested() =>
          _onChatHistoryInitialLoadRequested(event, emit),
        ChatHistoryRefreshRequested() =>
          _onChatHistoryRefreshRequested(event, emit),
        ChatHistoryLoadMoreRequested() =>
          _onChatHistoryLoadMoreRequested(event, emit),
      },
      transformer: droppable(),
    );
    on<UploadImage>(_onUploadImage, transformer: sequential());
    on<UpdateImageUpdateStatus>(_updateImageUploadStatus);
    on<ChatHistoryInitialEvent>(_onInitialEvent);
    on<SendMessageEvent>(_onSendMessage, transformer: sequential());

    on<UpdateReadStatusForAllNonUpdated>(_updateReadStatusForAllChat);
    on<UpdateReadStatusOfaSingleMessage>(_onUpdateReadStatusOfaSingleMessage);
    on<SyncChatHistory>(_onSyncChatHistory);
  }

  final dataFetchLimit = 20;
  CancelableOperation<ChatHistoryState>? _cancellableOperation;
  final IChatRepository _chatService = locator<IChatRepository>();

  Future<void> _onSyncChatHistory(
    SyncChatHistory event,
    Emitter<ChatHistoryState> emit,
  ) async {}

  Future<void> _updateImageUploadStatus(
    UpdateImageUpdateStatus event,
    Emitter<ChatHistoryState> emit,
  ) async {
    final chats = state.chatList.map((e) => e.copyWith()).toList();
    final index = chats.indexWhere(
        (element) => element.messageId == event.chatModel.messageId);
    if (index == -1) return;
    chats
      ..removeAt(index)
      ..insert(index, event.chatModel);
    emit(
      state.copyWith(
          chatList: chats, emitTime: DateTime.now().microsecondsSinceEpoch),
    );
  }

  Future<void> _onUpdateReadStatusOfaSingleMessage(
    UpdateReadStatusOfaSingleMessage event,
    Emitter<ChatHistoryState> emit,
  ) async {
    final message = event.message;
    // final now = DateTime.now().millisecondsSinceEpoch;
    final now = ChatVariables().getSendTime();
    final chat = ChatModel(
      composeId: message.composeId,
      content: message.messageId,
      contentType: 26,
      deleteTime: message.deleteTime,
      messageId: getRandomId(),
      timeSend: now,
      isRead: 0,
      receiver: message.composeId?.to ?? '',
      sender: int.tryParse(message.composeId?.from ?? ''),
      ts: now,
      senderJid: message.composeId?.to,
      receiverJid: message.senderJid,
    );
    await locator<IsarService>().updateReadStatusOfaMessage(message.messageId!);
    locator<XmppConnectionServiceManager>().sendMessage(
      receiverJid: message.senderJid!,
      chat: chat,
      fromUserName: state.loginResponse!.data!.nickname!,
      toFullJid: message.senderJid!,
    );
    final chats = state.chatList.map((e) => e.copyWith()).toList();
    final index = chats.indexWhere((element) => element == message);
    if (index == -1) return;
    chats
      ..removeAt(index)
      ..insert(index, message.copyWith(isRead: 1));
    emit(
      state.copyWith(
        chatList: chats,
        chatHistoryData: ChatHistoryListData(chats: chats),
      ),
    );
  }

  Future<void> _updateReadStatusForAllChat(
    UpdateReadStatusForAllNonUpdated event,
    Emitter<ChatHistoryState> emit,
  ) async {
    final chats = state.chatList.map((e) => e.copyWith());
    final futures = <dynamic>[];
    final list = chats.map((element) {
      if (element.isRead == 0 &&
          element.sender?.toString() != element.composeId?.from) {
        element.isRead = 1;
        print(chats.toList().indexOf(element));
        _updateReadStatus(element);
        futures.add(
          locator<IsarService>().updateReadStatusOfaMessage(element.messageId!),
        );
      }
      return element;
    }).toList();
    // for (final element in chats) {
    //   if (element.isRead == 0 &&
    //       element.sender?.toString() != element.composeId?.from) {
    //     element.isRead = 1;
    //     print(chats.toList().indexOf(element));
    //     _updateReadStatus(element);
    //     await locator<IsarService>()
    //         .updateReadStatusOfaMessage(element.messageId!);
    //   }
    // }
    await Future.wait(List.from([...futures]));
    emit(state.copyWith(chatList: List.from([...list])));
  }

  Future<void> _onUploadImage(
    UploadImage event,
    Emitter<ChatHistoryState> emit,
  ) async {
    try {
      final response =
          await _chatService.uploadImage(event.chat.localFilePath!);
      if (response != null) {
        emit(
          state.copyWith(
            uploadedChat: event.chat.copyWith(
              content: response.data!.images!.first.oUrl,
              localFileUploadingStatus: UploadingStatusStrings.completed,
            ),
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(
          imageUploadStatus: UploadingStatusStrings.failed,
          uploadedChat: event.chat.copyWith(
            localFileUploadingStatus: UploadingStatusStrings.failed,
          ),
        ),
      );
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatHistoryState> emit,
  ) async {
    try {
      final chat = event.chat;

      final chatHistory = state.chatList.map((e) => e.copyWith()).toList();

      chatHistory.insert(
        0,
        chat,
      );

      emit(
        state.copyWith(
          clearUploadedImage: true,
          chatList: chatHistory.toSet().toList(),
        ),
      );
      if ((chat.isLocalImage ?? false) && chat.content.isNullOrEmpty) {
        return;
      }
    } catch (e) {
      print(e);
    }
  }

//calls when a message is received and you are currently on that screen
  void _updateReadStatus(ChatModel message) {
    // final now = DateTime.now().millisecondsSinceEpoch;
    final now = ChatVariables().getSendTime();

    final chat = ChatModel(
      composeId: message.composeId,
      content: message.messageId,
      contentType: 26,
      deleteTime: message.deleteTime,
      messageId: getRandomId(),
      timeSend: now,
      isRead: 0,
      receiver: message.composeId?.to ?? '',
      sender: int.tryParse(message.composeId?.from ?? ''),
      ts: now,
      senderJid: message.composeId?.to,
      receiverJid: message.senderJid,
    );

    locator<XmppConnectionServiceManager>().sendMessage(
      receiverJid: message.senderJid!,
      chat: chat,
      fromUserName: state.loginResponse!.data!.nickname!,
      toFullJid: message.senderJid!,
    );
  }

  Future<void> _onInitialEvent(
    ChatHistoryInitialEvent event,
    Emitter<ChatHistoryState> emit,
  ) async {
    await emit.forEach(
      locator<XmppConnectionServiceManager>().messageStanzaStream,
      onData: (data) {
        try {
          if (data?.children.firstOrNull?.name == 'received') {
            final id =
                data?.children.firstOrNull?.attributes.lastOrNull?.value ?? '';

            final chats = state.chatList.map((e) => e.copyWith()).toList();
            final readerChat =
                chats.where((element) => element.messageId == id).firstOrNull;
            if (readerChat != null) {
              final index = chats.indexOf(readerChat);
              chats
                ..removeAt(index)
                ..insert(index, readerChat.copyWith(isDelivered: 1));
              return state.copyWith(
                chatList: chats.toSet().toList(),
                emitTime: DateTime.now().microsecondsSinceEpoch,
                isReadUpdateEmit: true,
              );
            }
            return state;
          }
          ChatModel chat;
          final Map<String, dynamic> body = json.decode(data?.body ?? '{}');
          final message = XmppMessageBody.fromJson(body);
          if (data?.body == null) return state;
          if ((data?.fromJid?.fullJid?.contains("@muc.serverdnstigase.com") ??
                  false) &&
              data?.body != null) {
            chat = ChatModel(
              composeId:
                  locator<ComposeIdGenerator>().generateGroupComposedIdTo(
                data?.fromJid?.local ?? "",
              ),
              other: message.other != null
                  ? jsonDecode(message.other ?? '')
                  : null,
              sId: data?.id,
              content: message.content,
              contentType: message.type,
              deleteTime: message.deleteTime,
              messageId: message.messageId,
              isRead: 0,
              objectId: message.objectId,
              timeSend: message.timeSend?.toInt(),
              receiver: message.toUserId ?? '',
              sender: int.tryParse(message.fromUserId ?? ''),
              ts: (message.timeSend)?.toInt(),
              senderJid: data?.fromJid?.fullJid,
              receiverJid: data?.toJid?.fullJid,
            );
          } else {
            chat = ChatModel(
              composeId: locator<ComposeIdGenerator>().generateComposedId(
                message.fromUserId.toString(),
                message.toUserId.toString(),
              ),
              other: message.other != null
                  ? jsonDecode(message.other ?? '')
                  : null,
              sId: data?.id,
              content: message.content,
              contentType: message.type,
              deleteTime: message.deleteTime,
              messageId: message.messageId,
              isRead: 0,
              objectId: message.objectId,
              timeSend: message.timeSend?.toInt(),
              receiver: message.toUserId ?? '',
              sender: int.tryParse(message.fromUserId ?? ''),
              ts: (message.timeSend)?.toInt(),
              senderJid: data?.fromJid?.fullJid,
              receiverJid: message.toUserId,
            );
          }

          final isCurrentChat = state.composedId == chat.composeId;
          if (isCurrentChat) {
            //acknowledgment
            if (message.type == 26) {
              final chats = state.chatList.map((e) => e.copyWith()).toList();
              final readerChat = chats
                  .where((element) => element.messageId == chat.content)
                  .firstOrNull;
              if (readerChat != null) {
                final index = chats.indexOf(readerChat);
                chats
                  ..removeAt(index)
                  ..insert(index, readerChat.copyWith(isRead: 1));
                return state.copyWith(
                  chatList: chats.toSet().toList(),
                  emitTime: DateTime.now().microsecondsSinceEpoch,
                  isReadUpdateEmit: true,
                );
              }
              return state;
            } else {
              _updateReadStatus(chat);
            }
            final chats = state.chatList.map((e) => e.copyWith()).toList()
              ..insert(0, chat);

            return state.copyWith(chatList: chats.toSet().toList());
          }
          return state;
        } catch (e) {
          print(e);
          return state;
        }
      },
    );
  }

  Future<void> _onChatHistoryInitialLoadRequested(
    ChatHistoryInitialLoadRequested event,
    Emitter<ChatHistoryState> emit,
  ) async {
    try {
      emit(state.copyWith(
        chatListFetchStatus: ApiFetchStatus.loading,
      ));
      RootIsolateToken rootToken = RootIsolateToken.instance!;
      final chats =
          await compute(gets, GetterIsolate(event.composedId, rootToken));
      final emitChat = chats.toSet().toList();
      emitChat.forEach((element) {
        print(
            "Time send ${DateTime.fromMillisecondsSinceEpoch(element.timeSend!)}");
      });

      emit(
        state.copyWith(
          chatList: emitChat,
          composedId: event.composedId,
          chatListFetchStatus: ApiFetchStatus.success,
          loginResponse: event.loginResponse,
        ),
      );

      //checking sync time is less than last message time
      if (event.lastSyncTime < event.timeSend) {
        emit(
          state.copyWith(
            chatListFetchStatus: ApiFetchStatus.loading,
          ),
        );

        final nextState = await _getChats(
          endTime: event.timeSend + 10,
          startTime: event.lastSyncTime,
          receiver: event.receiver,
          isGroup: event.isGroup,
        );

        if (nextState == null) {
          return emit(
            state.copyWith(
              chatListFetchStatus: ApiFetchStatus.failed,
            ),
          );
        }

        final chatsInNextState = nextState.map((e) => e.copyWith()).toList();
        final currentList = state.chatList.map((e) => e.copyWith()).toList();

        for (final element in chatsInNextState) {
          final index = currentList.indexOf(element);
          if (index != -1) {
            element.isRead = currentList[index].isRead;
          }
        }

        locator<IsarService>().saveListOfChatToLocal(chatsInNextState);
        final listOfChatToEmit =
            [...currentList, ...chatsInNextState].toSet().toList();
        listOfChatToEmit.sort(
          (a, b) => b.timeSend!.compareTo(a.timeSend!),
        );

        return emit(
          state.copyWith(
            isInitialLoad: true,
            chatList: listOfChatToEmit,
            chatListFetchStatus: ApiFetchStatus.success,
            chatHistoryData: ChatHistoryListData(
              chats: listOfChatToEmit,
            ),
          ),
        );
      }
    } catch (e) {
      return emit(
        state.copyWith(
          chatListFetchStatus: ApiFetchStatus.failed,
        ),
      );
    }
  }

  Future<void> _onChatHistoryRefreshRequested(
    ChatHistoryRefreshRequested event,
    Emitter<ChatHistoryState> emit,
  ) async {
    if (state.chatListFetchStatus == ApiFetchStatus.loading) return;
    emit(state.copyWith(chatListFetchStatus: ApiFetchStatus.loading));
    final nextState = await _getStateFromCancelable(
      pageNumber: 0,
      receiver: event.receiver,
    );
    if (nextState == null) return;
    emit(nextState);
  }

  Future<void> _onChatHistoryLoadMoreRequested(
    ChatHistoryLoadMoreRequested event,
    Emitter<ChatHistoryState> emit,
  ) async {
    if (state.chatListFetchStatus == ApiFetchStatus.loading ||
        !state.canLoadMore) return;
    emit(
      state.copyWith(
        chatLoadMoreStatus: ApiFetchStatus.loading,
      ),
    );
    final nextState = await _getStateFromCancelable(
      pageNumber: state.offset,
      receiver: event.receiver,
      isLoadMore: true,
    );
    if (nextState == null) return;

    emit(nextState);
  }

  Future<ChatHistoryState?> _getStateFromCancelable({
    required String receiver,
    int? pageNumber,
    bool isLoadMore = false,
  }) async {
    await _cancellableOperation?.cancel();
    _cancellableOperation = CancelableOperation.fromFuture(
      _loadDataAndGetState(
        pageNumber = pageNumber ?? 0,
        receiver,
        isLoadMore,
      ),
    );
    return _cancellableOperation?.valueOrCancellation();
  }

  Future<List<ChatModel>?> _getChats({
    required String receiver,
    required int startTime,
    required int endTime,
    required bool isGroup,
  }) async {
    final response = isGroup
        ? await _chatService.getGroupChats(
            startTime: startTime,
            roomId: receiver,
            endTime: endTime,
          )
        : await _chatService.getChats(
            startTime: startTime,
            receiver: receiver,
            endTime: endTime,
          );
    return response;
  }

  Future<ChatHistoryState> _loadDataAndGetState(
    int pageNumber,
    String receiver, [
    bool isLoadMore = false,
  ]) async {
    if (isLoadMore) {
      pageNumber = calculatePageNumber(state.chatList.length, 20);
    }
    final response = await _chatService.getChatHistoryData(
      pageNumber: pageNumber,
      receiver: receiver,
    );
    if (response == null) {
      if (isLoadMore) {
        return state.copyWith(
          chatLoadMoreStatus: ApiFetchStatus.failed,
          canLoadMore: true,
        );
      }
      return state.copyWith(
        chatListFetchStatus: ApiFetchStatus.failed,
        canLoadMore: true,
      );
    }
    final newChatList = response.chats ?? [];
    if (isLoadMore) {
      final chatList = <ChatModel>{...state.chatList, ...newChatList}.toList();
      await locator<IsarService>()
          .clearAllChatAgainstAUserAndInsertFresh(state.composedId!, chatList);
      return state.copyWith(
        canLoadMore: newChatList.length >= dataFetchLimit,
        chatLoadMoreStatus: ApiFetchStatus.success,
        offset: newChatList.isNotEmpty ? pageNumber + 1 : pageNumber,
        chatList: chatList,
        chatHistoryData: response,
      );
    }
    final chatList = pageNumber == 0
        ? newChatList
        : <ChatModel>{...state.chatList, ...newChatList}.toList();
    await locator<IsarService>()
        .clearAllChatAgainstAUserAndInsertFresh(state.composedId!, chatList);
    return state.copyWith(
      canLoadMore: newChatList.length >= dataFetchLimit,
      chatListFetchStatus: ApiFetchStatus.success,
      offset: newChatList.isNotEmpty ? pageNumber + 1 : pageNumber,
      chatList: chatList,
      chatHistoryData: response,
    );
  }
}

int calculatePageNumber(int totalItemsLoaded, int itemsPerPage) {
  final pageNumber = totalItemsLoaded ~/ itemsPerPage;
  return pageNumber;
}

List<T> getFirst20Elements<T>(List<T> elements) {
  if (elements.length >= 20) {
    return elements.sublist(0, 20);
  } else {
    return elements;
  }
}

class GetterIsolate {
  GetterIsolate(this.id, this.token);

  final ComposedId id;
  final RootIsolateToken token;
}

class SaverIsolate {
  SaverIsolate(this.chats, this.token);

  final List<ChatModel> chats;
  final RootIsolateToken token;
}

Future<List<ChatModel>> gets(GetterIsolate ds) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(ds.token);
  final id = ds.id;
  final dir = await getApplicationDocumentsDirectory();
  final _isar = await Isar.open(
    [ChatModelSchema],
    directory: dir.path,
  );
  final chatList = await _isar.chatModels
      .filter()
      .group(
        (q) => q
            .composeId((q) => q.fromEqualTo(id.from))
            .and()
            .composeId((q) => q.toEqualTo(id.to)),
      )
      .sortByTimeSendDesc()
      .findAll();

  var chats = chatList.toList();
  //set image uploading failed
  print(AlreadySyncedChatMembersDataKeeper().syncedMembersId);
  final list = await ReadCache.getStringList(key: "ItemInProgress");
  if (!AlreadySyncedChatMembersDataKeeper().isAlreadySynced(id)) {
    for (final element in chats) {
      // if ((element.isLocalImage ?? false) == true &&
      //     element.content.isNullOrEmpty)
      if (element.localFileUploadingStatus ==
              UploadingStatusStrings.inProgress &&
          element.localFileUploadingStatus != null &&
          !list.contains(element.messageId)) {
        element.localFileUploadingStatus = UploadingStatusStrings.failed;
      }
    }
  }

  return chats.toSet().toList();
}
