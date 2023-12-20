part of 'discovery_bloc.dart';

sealed class DiscoveryEvent extends Equatable {
  const DiscoveryEvent();

  @override
  List<Object?> get props => [];
}

sealed class DiscoveryLoadEvent extends DiscoveryEvent {
  final bool? isLoadMore;
  const DiscoveryLoadEvent({this.isLoadMore});

  @override
  List<Object?> get props => [];
}

sealed class LikeUnlikeCommentEvent extends DiscoveryEvent {
  const LikeUnlikeCommentEvent();

  @override
  List<Object?> get props => [];
}

class LikeUnlike extends LikeUnlikeCommentEvent {
  final String messageId;
  const LikeUnlike({required this.messageId});
  @override
  List<Object?> get props => [messageId];
}

class DiscoverSingleItem extends DiscoveryEvent {
  final String? messageId;
  const DiscoverSingleItem({required this.messageId});
  @override
  List<Object?> get props => [messageId];
}

class DiscoverCommentList extends DiscoveryEvent {
  final String? messageId;
  const DiscoverCommentList({required this.messageId});
  @override
  List<Object?> get props => [messageId];
}

class AddComment extends DiscoveryEvent {
  const AddComment({
    required this.messageId,
    required this.comment,
    required this.nickName,
    required this.toUserId,
  });

  final String messageId;
  final String comment;
  final String nickName;
  final int toUserId;

  @override
  List<Object?> get props => [messageId, comment, nickName, toUserId];
}

class DeleteComment extends DiscoveryEvent {
  const DeleteComment({
    required this.messageId,
    required this.commentId,
  });

  final String messageId;
  final String commentId;

  @override
  List<Object?> get props => [messageId, commentId];
}

class FetchDiscoveryList extends DiscoveryLoadEvent {
  const FetchDiscoveryList({
    this.userId,
    this.messageId,
    this.pageSize,
    this.pageIndex,
    this.userType,
    this.isLoadMore,
  });

  final int? userId;
  final String? messageId;
  final int? pageSize;
  final int? pageIndex;
  final int? userType;
  final bool? isLoadMore;

  @override
  List<Object?> get props =>
      [userId, messageId, pageSize, pageIndex, userType, isLoadMore];
}

class PostText extends DiscoveryEvent {
  const PostText({
    required this.discoverParameter,
    required this.userId,
  });

  final DiscoverParameter discoverParameter;
  final String userId;

  @override
  List<Object?> get props => [discoverParameter, userId];
}

class ResetUploadStatus extends DiscoveryEvent {
  const ResetUploadStatus();

  @override
  List<Object?> get props => [];
}

class ScrollToItem extends DiscoveryEvent {
  const ScrollToItem({
    required this.itemId,
  });

  final String? itemId;

  @override
  List<Object?> get props => [itemId];
}

class PostImage extends DiscoveryEvent {
  const PostImage({
    required this.discoverParameter,
    required this.localImageFiles,
    required this.userId,
  });

  final DiscoverParameter discoverParameter;
  final List<XFile> localImageFiles;
  final String userId;
  @override
  List<Object?> get props => [discoverParameter, localImageFiles, userId];
}

class DeleteDiscovery extends DiscoveryEvent {
  const DeleteDiscovery({
    required this.messageId,
  });

  final String messageId;

  @override
  List<Object?> get props => [messageId];
}
