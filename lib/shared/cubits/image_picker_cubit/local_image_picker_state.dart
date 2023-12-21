// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../../../shared/cubits/image_picker_cubit/local_image_picker_cubit.dart';

class LocalImagePickerState extends Equatable {
  const LocalImagePickerState({
    this.localImagePickStatus = ApiFetchStatus.idle,
    this.localImageFile,
    this.errorMessage,
    this.localImageFiles,
  });
  final ApiFetchStatus localImagePickStatus;
  final XFile? localImageFile;
  final String? errorMessage;
  final List<XFile>? localImageFiles;
  @override
  List<Object?> get props =>
      [localImagePickStatus, localImageFile, localImageFiles];

  LocalImagePickerState copyWith({
    ApiFetchStatus? localImagePickStatus,
    XFile? localImageFile,
    String? errorMessage,
    List<XFile>? localImageFiles,
  }) {
    return LocalImagePickerState(
      localImagePickStatus: localImagePickStatus ?? this.localImagePickStatus,
      localImageFile: localImageFile ?? this.localImageFile,
      errorMessage: errorMessage ?? errorMessage,
      localImageFiles: localImageFiles ?? this.localImageFiles,
    );
  }
}
