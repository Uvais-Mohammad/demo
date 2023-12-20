// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cover_image_cubit.dart';

class CoverImageState extends Equatable {
  const CoverImageState({
    this.localImagePickStatus = ApiFetchStatus.idle,
    this.uploadImageStatus = ApiFetchStatus.idle,
    this.localImageFile,
    this.errorMessage,
  });
  final ApiFetchStatus localImagePickStatus;
  final ApiFetchStatus uploadImageStatus;
  final XFile? localImageFile;
  final String? errorMessage;
  @override
  List<Object?> get props =>
      [localImagePickStatus, uploadImageStatus, localImageFile];

  CoverImageState copyWith({
    ApiFetchStatus? localImagePickStatus,
    ApiFetchStatus? uplaodImageStatus,
    XFile? localImageFile,
    String? errorMessage,
  }) {
    return CoverImageState(
      localImagePickStatus: localImagePickStatus ?? this.localImagePickStatus,
      uploadImageStatus: uplaodImageStatus ?? this.uploadImageStatus,
      localImageFile: localImageFile ?? this.localImageFile,
      errorMessage: errorMessage ?? errorMessage,
    );
  }
}
