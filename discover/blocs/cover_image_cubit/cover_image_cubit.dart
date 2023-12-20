import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sf_chat_im/features/chat/repository/chat_repository.dart';
import 'package:sf_chat_im/features/discover/repository/i_discover_repo.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/services/image_picker/i_image_picker.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';

part 'cover_image_state.dart';

class CoverImageCubit extends Cubit<CoverImageState> {
  CoverImageCubit() : super(const CoverImageState());

  final _imageService = locator<IImageService>();
  final _discoverRepo = locator<IDiscoverRepository>();

  Future<void> onPicImage(ImageSource source, [int? imageQuality]) async {
    try {
      emit(state.copyWith(localImagePickStatus: ApiFetchStatus.loading));
      final response = await _imageService.pickImage(source, imageQuality);
      if (response == null) {
        return emit(
          state.copyWith(localImagePickStatus: ApiFetchStatus.failed),
        );
      }
      if (isClosed) return;
      uploadUpdateImage(image: response.path);
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

  Future<void> uploadUpdateImage({required String image}) async {
    try {
      emit(state.copyWith(uplaodImageStatus: ApiFetchStatus.loading));
      final response = await _discoverRepo.uploadCoverImage(image: image);
      if (response == null) {
        return emit(
          state.copyWith(uplaodImageStatus: ApiFetchStatus.failed),
        );
      }
      if (isClosed) return;
      final imageUrl = response.data?.images?.first.oUrl;
      if (imageUrl == null) return;

      final responseUpdate = await _discoverRepo.updateCoverImage(imageUrl);
      print(responseUpdate);
      if (isClosed) return;
      return emit(
        state.copyWith(
          uplaodImageStatus: ApiFetchStatus.success,
        ),
      );
    } on Exception catch (e) {
      if (e is UnableToProcessException) {
        emit(
          state.copyWith(
            uplaodImageStatus: ApiFetchStatus.failed,
            errorMessage: 'An error occured',
          ),
        );
      }
    }
  }
}
