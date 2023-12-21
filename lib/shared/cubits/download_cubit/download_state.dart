// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'download_cubit.dart';

class DownloadState extends Equatable {
  const DownloadState({
    this.taskInfo = const [],
  });
  final List<NewTaskInfo> taskInfo;
  @override
  List<Object?> get props => [taskInfo];

  DownloadState copyWith({
    List<NewTaskInfo>? taskInfo,
  }) {
    return DownloadState(
      taskInfo: taskInfo ?? this.taskInfo,
    );
  }
}
