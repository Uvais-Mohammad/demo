import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sf_chat_im/features/chat/logic/send_chat_message_bloc/send_chat_message_bloc.dart';
import 'package:sf_chat_im/features/chat/models/file_messaging_model.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadState()) {}
  late final String localPath;

  void init() async {
    localPath = (await getApplicationDocumentsDirectory()).path;
  }

  void addTask(NewTaskInfo task) {
    if (state.taskInfo.any((element) => element.messageId == task.messageId)) {
      return;
    }
    emit(state.copyWith(taskInfo: [...state.taskInfo, task]));
  }

  void updateTaskInfo({
    String? messageId,
    required String taskId,
    required int progress,
    required DownloadTaskStatus status,
    bool isDownloaded = false,
  }) {
    final taskInfo = state.taskInfo.map((task) {
      if (task.taskId == taskId) {
        return task.copyWith(
          taskId: taskId,
          progress: progress,
          status: status,
          isDownloaded: isDownloaded,
        );
      }
      return task;
    }).toList();
    emit(state.copyWith(taskInfo: taskInfo));
  }

  Future<void> prepare() async {
    final tasks = await FlutterDownloader.loadTasks();
    if (tasks == null || tasks.isEmpty) {
      print('No tasks were retrieved from the database.');
      return;
    } else {
      List<NewTaskInfo> tasksList = [];
      tasks.forEach((info) {
        print(info.toString());
        tasksList.add(
          NewTaskInfo(
            name: info.filename,
            link: info.url,
            taskId: info.taskId,
            status: info.status,
            progress: info.progress,
            messageId: info.filename!.split('.').first,
            isDownloaded: info.status == DownloadTaskStatus.complete,
          ),
        );
      });
      tasksList.toSet().toList();
      emit(state.copyWith(taskInfo: tasksList));
    }
  }

  Future<void> clearAllTasks() async {
    final tasks = await FlutterDownloader.loadTasks();
    if (tasks == null || tasks.isEmpty) {
      print('No tasks were retrieved from the database.');
      return;
    }
    tasks.forEach((element) async {
      await FlutterDownloader.remove(taskId: element.taskId);
    });
  }

  Future<void> clearData() async {
    final localPath = (await getApplicationDocumentsDirectory()).path;
    final directory = Directory(localPath);
    directory.deleteSync(recursive: true);
  }

  Future<void> resumeDownload(String taskId) async {
    final newTaskId = await FlutterDownloader.resume(taskId: taskId);
    final taskInfo = state.taskInfo.map((task) {
      if (task.taskId == taskId) {
        return task.copyWith(taskId: newTaskId);
      }
      return task;
    }).toList();
    emit(state.copyWith(taskInfo: taskInfo));
  }

  Future<void> retryDownload(String taskId) async {
    final newTaskId = await FlutterDownloader.retry(taskId: taskId);
    final taskInfo = state.taskInfo.map((task) {
      if (task.taskId == taskId) {
        return task.copyWith(taskId: newTaskId);
      }
      return task;
    }).toList();
    emit(state.copyWith(taskInfo: taskInfo));
  }

  Future<void> requestDownload({
    required String link,
    required String messageId,
    required SendingFileType fileType,
  }) async {
    if (state.taskInfo.any((element) => element.messageId == messageId)) {
      return;
    }
    final localPath = (await getApplicationDocumentsDirectory()).path;

    final type = link.split('.').last;
    final pathToSave =
        '$localPath${Platform.pathSeparator}media${Platform.pathSeparator}${fileType.toDirName}';
    final savedDir = Directory(pathToSave);
    final hasExisted = await savedDir.exists();
    if (!hasExisted) {
      await savedDir.create(recursive: true);
    }
    final fileName = '$messageId.$type';
    print(messageId);
    print('$pathToSave/$fileName');
    var taskId = await FlutterDownloader.enqueue(
      url: link,
      savedDir: pathToSave,
      fileName: fileName,
      timeout: 60000,
      openFileFromNotification: false,
      showNotification: false,
    );
    emit(state.copyWith(
      taskInfo: [
        ...state.taskInfo,
        NewTaskInfo(
          link: link,
          taskId: taskId,
          status: DownloadTaskStatus.running,
          progress: 0,
          messageId: messageId,
        ),
      ],
    ));
  }

  Future<void> openDownloadedFile(String messageId) async {
    try {
      final task = state.taskInfo
          .where((element) => element.messageId == messageId)
          .firstOrNull;
      if (task == null) {
        return;
      }
      if (task.status == DownloadTaskStatus.complete) {
        final taskId = task.taskId;
        final canOpen = await FlutterDownloader.open(taskId: taskId!);
        if (!canOpen) {
          showToast(StringConstants.cannotOpenThisFile);
          return;
        }
      }
    } catch (e) {
      showToast(StringConstants.cannotOpenThisFile);
      return;
    }
  }

  String? getDownloadedFile({
    required String messageId,
    required String link,
    required SendingFileType fileType,
  }) {
    try {
      final task = state.taskInfo
          .where((element) => element.messageId == messageId)
          .firstOrNull;
      if (task == null) {
        return null;
      }
      if (task.status == DownloadTaskStatus.complete) {
        final type = link.split('.').last;
        final fileName = '$messageId.$type';
        final filePath =
            '$localPath${Platform.pathSeparator}media${Platform.pathSeparator}${fileType.toDirName}${Platform.pathSeparator}$fileName';
        return filePath;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> updateDownloadStatus({
    required String url,
    required String messageId,
    required SendingFileType fileType,
  }) async {
    final type = url.split('.').last;
    final localPath = (await getApplicationDocumentsDirectory()).path;
    final fileName = '$messageId.$type';
    final filePath =
        '$localPath${Platform.pathSeparator}media${Platform.pathSeparator}${fileType.toDirName}${Platform.pathSeparator}$fileName';
    final isFileExist = await File(filePath).exists();
    if (isFileExist) {
      final taskInfo = state.taskInfo.map((task) {
        if (task.messageId == messageId) {
          return task.copyWith(isDownloaded: true);
        }
        return task;
      }).toList();
      emit(state.copyWith(taskInfo: taskInfo));
    } else {
      final taskInfo = state.taskInfo.map((task) {
        if (task.messageId == messageId) {
          return task.copyWith(isDownloaded: false);
        }
        return task;
      }).toList();
      emit(state.copyWith(taskInfo: taskInfo));
    }
  }
}
