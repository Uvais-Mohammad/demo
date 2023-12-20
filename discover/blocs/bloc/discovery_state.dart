// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discovery_bloc.dart';

class DiscoveryState extends Equatable {
  const DiscoveryState({
    this.discoverList,
    this.error,
    this.apiFetchStatus = ApiFetchStatus.idle,
    this.loadMoreStatus = ApiFetchStatus.idle,
    this.uploadStatus = ApiFetchStatus.idle,
    this.discoverDetailStatus = ApiFetchStatus.idle,
    this.commentDetailStatus = ApiFetchStatus.idle,
    this.scrollToIndex,
  });

  final DiscoverListResponse? discoverList;
  final String? error;
  final ApiFetchStatus apiFetchStatus;
  final ApiFetchStatus loadMoreStatus;
  final ApiFetchStatus? uploadStatus;
  final ApiFetchStatus? discoverDetailStatus;
  final ApiFetchStatus? commentDetailStatus;
  final int? scrollToIndex;
  @override
  List<Object?> get props => [
        discoverList,
        error,
        apiFetchStatus,
        loadMoreStatus,
        uploadStatus,
        scrollToIndex,
        discoverDetailStatus,
        commentDetailStatus
      ];

  DiscoveryState copyWith({
    DiscoverListResponse? discoverList,
    String? error,
    ApiFetchStatus? apiFetchStatus,
    ApiFetchStatus? loadMoreStatus,
    ApiFetchStatus? uploadStatus,
    ApiFetchStatus? discoverDetailStatus,
    ApiFetchStatus? commentDetailStatus,
    int? scrollToIndex,
  }) {
    return DiscoveryState(
      discoverList: discoverList ?? this.discoverList,
      error: error ?? this.error,
      apiFetchStatus: apiFetchStatus ?? this.apiFetchStatus,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      scrollToIndex: scrollToIndex ?? this.scrollToIndex,
      discoverDetailStatus: discoverDetailStatus ?? this.discoverDetailStatus,
      commentDetailStatus: commentDetailStatus ?? this.commentDetailStatus,
    );
  }
}
