import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sf_chat_im/features/login/models/login_response.dart';
import 'package:sf_chat_im/features/signup/repository/i_signup_repository.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/enums/enums.dart';
import 'package:sf_chat_im/shared/services/notification/i_notification.dart';
import 'package:sf_chat_im/shared/services/secure_storage_service/i_secure_storage.dart';
import 'package:sf_chat_im/shared/services/secure_storage_service/secure_storage_keys.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:sf_chat_im/shared/services/shared_preference_service/i_shared_preference.dart';
import 'package:sf_chat_im/shared/services/shared_preference_service/shared_pref_keys.dart';
import 'package:sf_chat_im/shared/utilities/on_string.dart';

part 'basic_info_state.dart';

class BasicInfoCubit extends Cubit<BasicInfoState> {
  BasicInfoCubit() : super(const BasicInfoState());

  final signupRepo = locator<ISignUpRepository>();
  Future<void> setProfileImage({
    required XFile image,
    required String userId,
  }) async {
    emit(state.copyWith(imageUploadStatus: ApiFetchStatus.loading));
    try {
      final status =
          await signupRepo.uploadAvatar(fileName: image.path, userId: userId);
      emit(
        state.copyWith(
          imageUploadStatus:
              status ? ApiFetchStatus.success : ApiFetchStatus.failed,
          image: status ? image : null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          imageUploadStatus: ApiFetchStatus.failed,
          error: e.toString(),
        ),
      );
    }
  }

  void setSex({required Sex sex}) {
    emit(state.copyWith(sex: sex));
  }

  void onUserFieldChanged({
    String? nickName,
    String? payPassword,
    String? payPasswordConfirm,
  }) {
    final isButtonActive = !nickName.isNullOrEmpty &&
        !payPassword.isNullOrEmpty &&
        !payPasswordConfirm.isNullOrEmpty;
    emit(
      state.copyWith(isButtonActive: isButtonActive),
    );
  }

  Future<void> submitBasicInfo({
    required String nickName,
    required String payPassword,
    required int gender,
    required LoginResponse signupResponse,
  }) async {
    emit(state.copyWith(submitStatus: ApiFetchStatus.loading));
    try {
      final status = await signupRepo.update(
        nickName: nickName,
        payPassword: payPassword,
        gender: gender,
      );
      await locator<ISharedPreferenceService>().setBool(
        SharedPrefKeys.isBasicInfoCompleted,
        value: true,
      );
      final loginResponse = signupResponse.copyWith(
        data: signupResponse.data?.copyWith(
          nickname: nickName,
        ),
      );
      await _saveLoginResponseToLocal(response: loginResponse);
      if (status) {
        final token = await locator<IPushNotificationsManager>().getToken();
        if (token != null) {
          await locator<IPushNotificationsManager>().setToken(token);
        }
      }
      emit(
        state.copyWith(
          submitStatus: status ? ApiFetchStatus.success : ApiFetchStatus.failed,
          signupResponse: loginResponse,
        ),
      );
    } catch (e) {
      emit(state.copyWith(submitStatus: ApiFetchStatus.failed));
    }
  }

  Future<void> _saveLoginResponseToLocal({
    required LoginResponse response,
  }) async {
    await locator<ISecureStorageService>()
        .write(key: SecureStorageKeys.token, value: response.data?.accessToken);
    await locator<ISecureStorageService>()
        .write(key: SecureStorageKeys.loginResponse, value: response.toJson());
  }
}
