import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sf_chat_im/features/login/models/login_response.dart';
import 'package:sf_chat_im/features/signup/models/signup_parameter.dart';
import 'package:sf_chat_im/features/signup/repository/i_signup_repository.dart';
import 'package:sf_chat_im/shared/constants/extensions.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/enums/enums.dart';
import 'package:sf_chat_im/shared/services/secure_storage_service/i_secure_storage.dart';
import 'package:sf_chat_im/shared/services/secure_storage_service/secure_storage_keys.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:sf_chat_im/shared/services/shared_preference_service/i_shared_preference.dart';
import 'package:sf_chat_im/shared/services/shared_preference_service/shared_pref_keys.dart';
import 'package:sf_chat_im/shared/utilities/extensions.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(ISignUpRepository signUpRepository)
      : _signUpRepository = signUpRepository,
        super(const SignUpState());

  final ISignUpRepository _signUpRepository;
  final ISharedPreferenceService _sharedPreferenceService =
      locator<ISharedPreferenceService>();
  void changeAgreementAccepted({required bool isAgreementAccepted}) {
    emit(state.copyWith(isAgreementAccepted: isAgreementAccepted));
  }

  void changePhoneNumber({String? phoneNumber}) {
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        phoneNumberForImgCode:
            '$phoneNumber*${DateTime.now().millisecondsSinceEpoch}',
      ),
    );
  }

  void changePrefix({required int prefix}) {
    emit(state.copyWith(prefix: prefix));
  }

  void changeSex({required Sex sex}) {
    emit(state.copyWith(sex: sex));
  }

  void onUserFieldChanged1({
    required String verificationCode,
    String? phoneNumber,
    String? password,
    String? graphicCode,
    bool isAgreementAccepted = false,
  }) {
    final isButtonActive = phoneNumber.notNullNorEmpty &&
        password.notNullNorEmpty &&
        graphicCode.notNullNorEmpty &&
        isAgreementAccepted &&
        verificationCode.notNullNorEmpty;
    emit(
      state.copyWith(
        isButtonActive: isButtonActive,
      ),
    );
  }

  @override
  void onChange(Change<SignUpState> change) {
    super.onChange(change);
    print(change);
  }

  Future<void> sendVerificationCode({
    required String telephone,
    required int areaCode,
    required String imgCode,
    required String language,
  }) async {
    try {
      emit(state.copyWith(verificationSendStatus: SignupStatus.loading));
      await _signUpRepository.sendVerificationCode(
        telephone: telephone,
        areaCode: areaCode,
        imgCode: imgCode,
        language: language,
      );
      emit(
        state.copyWith(
          verificationSendStatus: SignupStatus.success,
          isAuthCodeVerified: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
      emit(state.copyWith(verificationSendStatus: SignupStatus.initial));
    }
  }

  Future<void> register(SignupParameter signupParameter) async {
    try {
      emit(state.copyWith(status: SignupStatus.loading));
      final signupResponse = await _signUpRepository.signUp(
        parameter: signupParameter,
      );
      final loginResponse = signupResponse.toLoginResponse();
      await _setUninstalledStatus(status: false);
      await _saveLoginResponseToLocal(response: loginResponse);
      await _setBasicInfoCompletedStatus(false);
      emit(
        state.copyWith(
          status: SignupStatus.success,
          loginResponse: loginResponse,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignupStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> checkUserExists({
    required String secret,
    required String value,
  }) async {
    emit(state.copyWith());
    if (value.isEmpty) {
      emit(state.copyWith(
          phoneNumberError: StringConstants.pleaseEnterPhoneNumber));
      return;
    }
    final result = await _signUpRepository.checkIsUserExists(
      value: value,
    );
    if (result != null) {
      emit(state.copyWith(phoneNumberError: result));
    } else {
      emit(state.copyWith(phoneNumberError: ''));
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

  Future<void> _setBasicInfoCompletedStatus(bool status) async {
    await _sharedPreferenceService.setBool(
      SharedPrefKeys.isBasicInfoCompleted,
      value: status,
    );
  }

  Future<void> _setUninstalledStatus({required bool status}) async {
    await _sharedPreferenceService.setBool(
      SharedPrefKeys.isUninstalled,
      value: status,
    );
  }

  Future<void> changeVerificationSendStatus({
    required SignupStatus status,
  }) async {
    emit(state.copyWith(verificationSendStatus: status));
  }
}
