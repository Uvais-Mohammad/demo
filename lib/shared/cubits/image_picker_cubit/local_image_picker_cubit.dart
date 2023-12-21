import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sf_chat_im/features/chat/repository/chat_repository.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/services/image_picker/i_image_picker.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';

part 'local_image_picker_state.dart';

class LocalImagePickerCubit extends Cubit<LocalImagePickerState> {
  LocalImagePickerCubit() : super(const LocalImagePickerState());

  final imageService = locator<IImageService>();

  Future<void> onPicImage(ImageSource source, [int? imageQuality]) async {
    try {
      emit(state.copyWith(localImagePickStatus: ApiFetchStatus.loading));
      final response = await imageService.pickImage(source, imageQuality);
      if (response == null) {
        return emit(
          state.copyWith(localImagePickStatus: ApiFetchStatus.failed),
        );
      }
      if (isClosed) return;
      return emit(
        state.copyWith(
          localImagePickStatus: ApiFetchStatus.success,
          localImageFile: response,
        ),
      );
    } on Exception catch (e) {
      if (e is UnableToProcessException) {
        emit(
          state.copyWith(
            localImagePickStatus: ApiFetchStatus.failed,
            errorMessage: source == ImageSource.camera
                ? StringConstants.cameraPermissionError
                : StringConstants.galleryPermissionError,
          ),
        );
      }
    }
  }

  Future<bool?> onPicImageReturn(ImageSource source,
      [int? imageQuality]) async {
    try {
      emit(state.copyWith(localImagePickStatus: ApiFetchStatus.loading));
      final response = await imageService.pickImage(source, imageQuality);
      if (response == null) {
        emit(
          state.copyWith(localImagePickStatus: ApiFetchStatus.failed),
        );
        return null;
      }
      if (isClosed) return null;
      List<XFile> newList = state.localImageFiles ?? [];
      newList.add(response);

      emit(
        state.copyWith(
          localImagePickStatus: ApiFetchStatus.success,
          localImageFiles: newList,
        ),
      );
      return true;
    } on Exception catch (e) {
      if (e is UnableToProcessException) {
        emit(
          state.copyWith(
            localImagePickStatus: ApiFetchStatus.failed,
            errorMessage: source == ImageSource.camera
                ? StringConstants.cameraPermissionError
                : StringConstants.galleryPermissionError,
          ),
        );
      }
    }
    return null;
  }

  Future<bool?> onPickMultipleImages() async {
    try {
      emit(state.copyWith(localImagePickStatus: ApiFetchStatus.loading));
      final imagesPicked = await imageService.pickImagesFromGallery();
      final unsupportedFiles = imagesPicked?.where((element) {
        final fileExtension = element.path.split('.').last;
        return ['gif', 'avif', 'tif', 'pdf', 'mp4', 'mov']
            .contains(fileExtension);
      }).toList();
      if (unsupportedFiles?.isNotEmpty ?? false) {
        showToast(StringConstants.unsupportedFile);
      }
      final images = imagesPicked?.where((element) {
        final fileExtension = element.path.split('.').last;
        return !['gif', 'avif', 'tif', 'pdf', 'mp4', 'mov']
            .contains(fileExtension);
      }).toList();
      if (images == null) {
        emit(
          state.copyWith(localImagePickStatus: ApiFetchStatus.failed),
        );
        return null;
      }
      if (isClosed) return null;
      final previousImages = state.localImageFiles;
      List<XFile> newImages = [...?previousImages, ...images];

      if (newImages.length > 5) {
        showToast(StringConstants.only5Images);
        newImages = newImages.sublist(0, 5);
      }

      emit(state.copyWith(
        localImagePickStatus: ApiFetchStatus.success,
        localImageFiles: newImages,
      ));
      return newImages.isNotEmpty;
    } on Exception catch (e) {
      if (e is UnableToProcessException) {
        emit(
          state.copyWith(
            localImagePickStatus: ApiFetchStatus.failed,
            errorMessage: StringConstants.galleryPermissionError,
          ),
        );
      }
    }
    return null;
  }

  Future<void> removeImage(int index) async {
    emit(state.copyWith(
      localImagePickStatus: ApiFetchStatus.loading,
    ));
    final previousImages = state.localImageFiles;
    previousImages?.removeAt(index);
    emit(state.copyWith(
      localImagePickStatus: ApiFetchStatus.success,
      localImageFiles: previousImages,
    ));
  }

  Future<void> removeAllLocalImages() async {
    emit(state.copyWith(
      localImageFiles: [],
    ));
  }

  Future<void> onMultiPickedImageItem(XFile file) async {
    try {
      emit(state.copyWith(localImagePickStatus: ApiFetchStatus.loading));
      if (isClosed) return;
      return emit(
        state.copyWith(
          localImagePickStatus: ApiFetchStatus.success,
          localImageFile: file,
        ),
      );
    } on Exception catch (e) {
      if (e is UnableToProcessException) {
        emit(
          state.copyWith(
            localImagePickStatus: ApiFetchStatus.failed,
            errorMessage: StringConstants.galleryPermissionError,
          ),
        );
      }
    }
  }
}
