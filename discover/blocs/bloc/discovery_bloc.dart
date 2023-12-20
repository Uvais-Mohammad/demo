import 'dart:convert';

import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http_util_package/models/api_response_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sf_chat_im/features/discover/models/add_discover_parameter.dart';
import 'package:sf_chat_im/features/discover/models/discover_list_response.dart';
import 'package:sf_chat_im/features/discover/repository/i_discover_repo.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  DiscoveryBloc() : super(DiscoveryState()) {
    on<DiscoveryLoadEvent>(
      (event, emit) => switch (event) {
        FetchDiscoveryList() => _fetchDiscoveryList(event, emit),
      },
      transformer: droppable(),
    );
    on<PostText>(
      (event, emit) => switch (event) {
        PostText() => _postText(event, emit),
      },
    );
    on<PostImage>(
      (event, emit) => switch (event) {
        PostImage() => _postImage(event, emit),
      },
    );
    on<LikeUnlikeCommentEvent>(
      (event, emit) => switch (event) {
        LikeUnlike() => _likeUnlike(event, emit),
      },
      transformer: sequential(),
    );
    on<AddComment>(_addComment);
    on<DeleteComment>(_deleteComment);
    on<DeleteDiscovery>(_deleteDiscovery);
    on<ResetUploadStatus>(_resetStatus);
    on<ScrollToItem>(_scrollToItem);
    on<DiscoverSingleItem>(_fetchDiscoverSingleItem);
    on<DiscoverCommentList>(_getCommentListAll);
  }
  CancelableOperation<DiscoveryState>? _cancellableOperation;
  final _discoverRepo = locator<IDiscoverRepository>();

  Future<void> _fetchDiscoveryList(
      DiscoveryLoadEvent event, Emitter<DiscoveryState> emit) async {
    if (state.discoverList?.data == null ||
        (state.discoverList?.data ?? []).isEmpty) {
      if (!(event.isLoadMore ?? false)) {
        emit(state.copyWith(apiFetchStatus: ApiFetchStatus.loading, error: ''));
      } else {
        emit(state.copyWith(loadMoreStatus: ApiFetchStatus.loading, error: ''));
      }
    }
    final nextState =
        await _getStateFromCancelable(isLoadMore: event.isLoadMore ?? false);
    if (nextState == null) return;
    emit(nextState);
  }

  Future<void> _fetchDiscoverSingleItem(
      DiscoverSingleItem event, Emitter<DiscoveryState> emit) async {
    if (event.messageId == null) return;
    emit(state.copyWith(discoverDetailStatus: ApiFetchStatus.loading));
    final data = await _discoverRepo.getDiscoverSingleItem(
      messageId: event.messageId!,
    );
    if (data == null) {
      emit(state.copyWith(
        discoverDetailStatus: ApiFetchStatus.failed,
      ));
    }

    final tempData = data?.copyWith(msgId: event.messageId!);
    final newDataList = state.discoverList?.data;
    newDataList?.add(tempData!);

    emit(state.copyWith(
      discoverList: state.discoverList!.copyWith(data: newDataList),
      discoverDetailStatus: ApiFetchStatus.success,
    ));

    emit(state.copyWith(commentDetailStatus: ApiFetchStatus.loading));
    final nextState = await _getCommentList(messageId: event.messageId!);
    emit(nextState);
  }

  Future<void> _getCommentListAll(
      DiscoverCommentList event, Emitter<DiscoveryState> emit) async {
    final nextState = await _getCommentList(messageId: event.messageId!);
    emit(nextState);
  }

  Future<DiscoveryState> _getCommentList({required String messageId}) async {
    final data = await _discoverRepo.getCommentList(
      messageId: messageId,
    );
    if (data == null) {
      return state.copyWith(
        commentDetailStatus: ApiFetchStatus.failed,
      );
    }

    final message = state.discoverList!.data!
        .where((element) => element.msgId == messageId)
        .firstOrNull;

    if (message == null ||
        state.discoverList == null ||
        state.discoverList?.data == null) {
      return state.copyWith(
        commentDetailStatus: ApiFetchStatus.failed,
      );
    }

    final commentList = data.data.map((item) {
      return Comments(
        body: item.body,
        commentId: item.commentId,
        msgId: item.msgId,
        nickname: item.nickname,
        time: item.time,
        toUserId: item.toUserId,
        userId: item.userId,
      );
    }).toList();

    final modifiedMessage = message.copyWith(
      comments: commentList,
    );

    final messageIndex = state.discoverList!.data!.indexOf(message);
    final newDiscoverListData =
        state.discoverList!.data!.map((e) => e.copyWith()).toList()
          ..removeAt(messageIndex)
          ..insert(messageIndex, modifiedMessage)
          ..sort(
            (a, b) => b.time!.compareTo(a.time!),
          );

    return state.copyWith(
      discoverList: state.discoverList!.copyWith(data: newDiscoverListData),
      commentDetailStatus: ApiFetchStatus.success,
    );
  }

  Future<void> _postText(PostText event, Emitter<DiscoveryState> emit) async {
    emit(state.copyWith(uploadStatus: ApiFetchStatus.loading, error: ''));
    final response = await _discoverRepo.postText(
      discoverParameter: event.discoverParameter,
    );
    if (response.isSuccess) {
      final newDiscoverListData = state.discoverList!.data!;
      newDiscoverListData.insert(
          0,
          DiscoverData(
            msgId: response.responseBody['data'],
            userId: int.tryParse(event.userId),
            body: Body(
              text: event.discoverParameter.text,
            ),
            nickname: event.discoverParameter.nickName,
            time: DateTime.now().millisecondsSinceEpoch,
          ));

      emit(state.copyWith(
        uploadStatus: ApiFetchStatus.success,
        discoverList: (state.discoverList ?? DiscoverListResponse()).copyWith(
          data: newDiscoverListData,
        ),
      ));
    } else {
      emit(state.copyWith(
        uploadStatus: ApiFetchStatus.failed,
        error: response.message,
      ));
    }
  }

  Future<void> _postImage(PostImage event, Emitter<DiscoveryState> emit) async {
    emit(state.copyWith(uploadStatus: ApiFetchStatus.loading, error: ''));
    final imageResponse = await _discoverRepo.uploadImage(
      images: event.localImageFiles.map((e) => e.path).toList(),
      userId: event.userId,
    );
    final images = imageResponse?.data?.images
            ?.map((e) => <String, String>{
                  "oUrl": e.oUrl ?? '',
                  "tUrl": e.turl ?? '',
                })
            .toList() ??
        [];
    if (images.isEmpty) {
      emit(state.copyWith(
        uploadStatus: ApiFetchStatus.failed,
        error: StringConstants.imageUploadError,
      ));
      return;
    }
    final response = await _discoverRepo.postImage(
      discoverParameter: event.discoverParameter.copyWith(
        images: jsonEncode(images),
      ),
    );
    if (response.isSuccess) {
      final newDiscoverListData = state.discoverList!.data!;
      newDiscoverListData.insert(
          0,
          DiscoverData(
            msgId: response.responseBody['data'],
            userId: int.tryParse(event.userId),
            body: Body(
                text: event.discoverParameter.text,
                images: event.localImageFiles.map((e) {
                  return Images(
                    localImage: e.path,
                  );
                }).toList()),
            nickname: event.discoverParameter.nickName,
            time: DateTime.now().millisecondsSinceEpoch,
          ));

      emit(state.copyWith(
        uploadStatus: ApiFetchStatus.success,
        discoverList: (state.discoverList ?? DiscoverListResponse()).copyWith(
          data: newDiscoverListData,
        ),
      ));
    } else {
      emit(state.copyWith(
        uploadStatus: ApiFetchStatus.failed,
        error: response.message,
      ));
    }
  }

  Future<DiscoveryState?> _getStateFromCancelable(
      {int? pageNumber, int? pageSize, required bool isLoadMore}) async {
    await _cancellableOperation?.cancel();
    _cancellableOperation = CancelableOperation.fromFuture(
      _loadDataAndGetState(
          pageNumber: pageNumber, pageSize: pageSize, isLoadMore: isLoadMore),
    );
    return _cancellableOperation?.valueOrCancellation();
  }

  Future<DiscoveryState> _loadDataAndGetState({
    int? pageNumber,
    int? pageSize,
    required bool isLoadMore,
  }) async {
    final List<DiscoverData> existingData =
        isLoadMore ? state.discoverList?.data ?? [] : [];
    final data = await _discoverRepo.getDiscoverList(
      pageIndex: (existingData.length / 20).ceil(),
      pageSize: pageSize ?? 20,
    );
    if (data == null) {
      return state.copyWith(
        apiFetchStatus: ApiFetchStatus.failed,
        error: StringConstants.failedToLoadData,
        loadMoreStatus:
            isLoadMore ? ApiFetchStatus.failed : state.loadMoreStatus,
      );
    }

    return state.copyWith(
      discoverList: data.copyWith(data: [...existingData, ...?data.data]),
      apiFetchStatus: ApiFetchStatus.success,
      loadMoreStatus:
          isLoadMore ? ApiFetchStatus.success : state.loadMoreStatus,
    );
  }

  Future<void> _likeUnlike(
      LikeUnlike event, Emitter<DiscoveryState> emit) async {
    final message = state.discoverList!.data!
        .where((element) => element.msgId == event.messageId)
        .firstOrNull;

    if (message == null ||
        state.discoverList == null ||
        state.discoverList?.data == null) return;

    ApiResponse? response;
    final isLiked = (message.isPraise ?? 0) == 1;

    if (!isLiked) {
      response = await _discoverRepo.like(event.messageId);
    } else {
      response = await _discoverRepo.unlike(event.messageId);
    }

    final modifiedMessage = message.copyWith(
      isPraise: isLiked ? 0 : 1,
      count: message.count?.copyWith(
              praise: (message.count?.praise ?? 0) + (isLiked ? -1 : 1)) ??
          Count(praise: (isLiked ? 0 : 1)),
    );

    final messageIndex = state.discoverList!.data!.indexOf(message);
    final newDiscoverListData =
        state.discoverList!.data!.map((e) => e.copyWith()).toList()
          ..removeAt(messageIndex)
          ..insert(messageIndex, modifiedMessage)
          ..sort(
            (a, b) => b.time!.compareTo(a.time!),
          );

    if (response.isSuccess) {
      emit(state.copyWith(
        discoverList: (state.discoverList ?? DiscoverListResponse()).copyWith(
          data: newDiscoverListData,
        ),
      ));
    }
  }

  Future<void> _addComment(
      AddComment event, Emitter<DiscoveryState> emit) async {
    final response = await _discoverRepo.addComment(
      messageId: event.messageId,
      body: event.comment,
    );
    final message = state.discoverList!.data!
        .where((element) => element.msgId == event.messageId)
        .firstOrNull;
    if (message == null ||
        state.discoverList == null ||
        state.discoverList?.data == null) return;

    final messageIndex = state.discoverList!.data!.indexOf(message);

    final loadingMessage = message.copyWith(
      commentingStatus: ApiFetchStatus.loading,
    );
    final loadingDiscoverData =
        state.discoverList!.data!.map((e) => e.copyWith()).toList()
          ..removeAt(messageIndex)
          ..insert(messageIndex, loadingMessage)
          ..sort(
            (a, b) => b.time!.compareTo(a.time!),
          );
    emit(state.copyWith(
      discoverList: (state.discoverList ?? DiscoverListResponse()).copyWith(
        data: loadingDiscoverData,
      ),
    ));

    final modifiedMessage = response.isSuccess
        ? message.copyWith(
            count: message.count
                    ?.copyWith(comment: (message.count?.comment ?? 0) + 1) ??
                Count(comment: 1),
            comments: [
              Comments(
                body: event.comment,
                commentId: response.responseBody['data'],
                msgId: event.messageId,
                nickname: event.nickName,
                time: response.responseBody['currentTime'],
                userId: event.toUserId,
              ),
              ...?message.comments,
            ],
            commentingStatus: ApiFetchStatus.success,
          )
        : message.copyWith(
            commentingStatus: ApiFetchStatus.failed,
          );

    final newDiscoverListData =
        state.discoverList!.data!.map((e) => e.copyWith()).toList()
          ..removeAt(messageIndex)
          ..insert(messageIndex, modifiedMessage)
          ..sort(
            (a, b) => b.time!.compareTo(a.time!),
          );
    emit(state.copyWith(
      discoverList: (state.discoverList ?? DiscoverListResponse()).copyWith(
        data: newDiscoverListData,
      ),
    ));
  }

  Future<void> _deleteComment(
      DeleteComment event, Emitter<DiscoveryState> emit) async {
    final response = await _discoverRepo.deleteComment(
      messageId: event.messageId,
      commentId: event.commentId,
    );
    final message = state.discoverList!.data!
        .where((element) => element.msgId == event.messageId)
        .firstOrNull;
    if (message == null ||
        message.comments == null ||
        state.discoverList == null ||
        state.discoverList?.data == null) return;

    final messageIndex = state.discoverList!.data!.indexOf(message);
    final commentsRemoved = message.comments;
    if (commentsRemoved == null) return;
    commentsRemoved
        .removeWhere((element) => element.commentId == event.commentId);
    final modifiedMessage = message.copyWith(
      count:
          message.count?.copyWith(comment: (message.count?.comment ?? 0) - 1),
      comments: commentsRemoved,
    );
    final newDiscoverListData =
        state.discoverList!.data!.map((e) => e.copyWith()).toList()
          ..removeAt(messageIndex)
          ..insert(messageIndex, modifiedMessage)
          ..sort(
            (a, b) => b.time!.compareTo(a.time!),
          );
    if (response.isSuccess) {
      emit(state.copyWith(
        discoverList: (state.discoverList ?? DiscoverListResponse()).copyWith(
          data: newDiscoverListData,
        ),
      ));
    }
  }

  void _resetStatus(ResetUploadStatus event, Emitter<DiscoveryState> emit) {
    emit(state.copyWith(
      uploadStatus: ApiFetchStatus.idle,
    ));
  }

  Future<void> _scrollToItem(
      ScrollToItem event, Emitter<DiscoveryState> emit) async {
    final discoverItems = state.discoverList?.data;
    final discoverItemIndex = discoverItems?.indexWhere((element) {
      print('>>>itemId${element.msgId}');
      return element.msgId == event.itemId;
    });
    if (discoverItemIndex != null && discoverItemIndex >= 0) {
      emit(state.copyWith(
        scrollToIndex: discoverItemIndex,
      ));
    }
  }

  Future<void> _deleteDiscovery(
      DeleteDiscovery event, Emitter<DiscoveryState> emit) async {
    final response = await _discoverRepo.delete(
      messageId: event.messageId,
    );

    final message = state.discoverList!.data!
        .where((element) => element.msgId == event.messageId)
        .firstOrNull;
    if (message == null ||
        state.discoverList == null ||
        state.discoverList?.data == null) return;

    final messageIndex = state.discoverList!.data!.indexOf(message);
    final newDiscoverListData =
        state.discoverList!.data!.map((e) => e.copyWith()).toList()
          ..removeAt(messageIndex)
          ..sort(
            (a, b) => b.time!.compareTo(a.time!),
          );
    if (response.isSuccess) {
      emit(state.copyWith(
        discoverList: (state.discoverList ?? DiscoverListResponse()).copyWith(
          data: newDiscoverListData,
        ),
      ));
    }
  }
}
