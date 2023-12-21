// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class TaskInfo {
  TaskInfo(
      {this.name,
      this.link,
      this.taskId,
      this.progress = 0,
      this.status = DownloadTaskStatus.undefined});

  final String? name;
  final String? link;

  String? taskId;
  int progress;
  DownloadTaskStatus status;
}

class NewTaskInfo extends Equatable {
  NewTaskInfo({
    this.name,
    this.messageId,
    this.link,
    this.taskId,
    this.progress = 0,
    this.status = DownloadTaskStatus.undefined,
    this.isDownloaded = false,
  });

  final String? name;
  final String? link;
  final String? messageId;
  final String? taskId;
  final int progress;
  final DownloadTaskStatus status;
  final bool isDownloaded;
  @override
  List<Object?> get props =>
      [name, link, taskId, progress, status, messageId, isDownloaded];

  NewTaskInfo copyWith({
    String? name,
    String? link,
    String? messageId,
    String? taskId,
    int? progress,
    DownloadTaskStatus? status,
    bool? isDownloaded,
  }) {
    return NewTaskInfo(
      name: name ?? this.name,
      link: link ?? this.link,
      messageId: messageId ?? this.messageId,
      taskId: taskId ?? this.taskId,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }
}
