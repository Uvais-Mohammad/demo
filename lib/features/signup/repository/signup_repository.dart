import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http_util_package/core.dart';
import 'package:sf_chat_im/features/signup/models/signup_model.dart';
import 'package:sf_chat_im/features/signup/models/signup_parameter.dart';
import 'package:sf_chat_im/features/signup/repository/i_signup_repository.dart';
import 'package:sf_chat_im/features/splash/repository/i_splash_repo.dart';
import 'package:sf_chat_im/shared/api/app_urls.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:sf_chat_im/shared/utilities/extensions.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';

final class SignUpRepository implements ISignUpRepository {
  final appUrl = locator<AppUrls>();
  @override
  Future<bool> sendVerificationCode({
    required String telephone,
    required int areaCode,
    required String imgCode,
    required String language,
  }) async {
    final response = await HttpUtil().getData(
      '''${appUrl.sendVerificationCodeForSignup}?language=$language&telephone=$telephone&areaCode=$areaCode&imgCode=$imgCode&version=1&isRegister=1''',
      requireToken: false,
    );
    throwIf(
      response.responseBody['resultCode'] != 1,
      response.responseBody['resultMsg'] ??
          StringConstants.sendVerificationCodeFailed,
    );
    return true;
  }

  @override
  Future<SignupResponse> signUp({
    required SignupParameter parameter,
  }) async {
    final response = await HttpUtil().getData(
      '${appUrl.register}?userType=${parameter.userType}&password=${parameter.password}&areaCode=${parameter.areaCode}&birthday=${parameter.birthday}&countryId=${parameter.countryId}&provinceId=${parameter.provinceId}&cityId=${parameter.cityId}&areaId=${parameter.areaId}&machineCode=${parameter.machineCode}&isSmsRegister=${parameter.isSmsRegister}&apiVersion=${parameter.apiVersion}&model=${parameter.apiVersion}&osVersion=${parameter.osVersion}&serial=${parameter.serial}&messageCode=${parameter.messageCode}&imgCode=${parameter.imgCode}&registerType=${parameter.registerType}&telephone=${parameter.telephone}',
      requireToken: false,
    );
    throwIf(
        !response.isSuccess,
        response.responseBody['resultMsg'] ??
            StringConstants.registrationFailed);
    return SignupResponse.fromJson(response.responseBody);
  }

  @override
  Future<bool> uploadAvatar({
    required String fileName,
    required String userId,
  }) async {
    final uploadUrl = await locator<ISplashRepository>()
        .getConfigFromLocal()
        .then((value) => value?.data?.uploadUrl);
    final response = await HttpUtil().uploadFile(
      appUrl.uploadAvatar(uploadUrl!),
      requireToken: false,
      [fileName],
      {
        'userId': userId,
      },
    );
    throwIf(
      response.responseBody['resultCode'] != 1,
      response.responseBody['resultMsg'] ?? StringConstants.uploadAvatarFailed,
    );
    return true;
  }

  @override
  Future<String?> checkIsUserExists({
    required String value,
    String keyword = 'telephone',
  }) async {
    final response = await HttpUtil().postData(
      appUrl.userEquals,
      requireToken: false,
      contentType: Headers.formUrlEncodedContentType,
      data: {
        'value': value,
        'keyWord': keyword,
      }..addAll(defaultParameterMap(appUrl.userEquals)),
    );
    if (response.isSuccess) return null;
    return response.responseBody['resultMsg'];
  }

  @override
  Future<bool> update({
    required String nickName,
    required int gender,
    required String payPassword,
  }) async {
    final response = await HttpUtil().postData(
      appUrl.updateBasicInfo,
      data: {
        'nickname': nickName,
        'sex': gender,
        'payPassWord': payPassword.toMD5String,
      }..addAll(defaultParameterMap(appUrl.updateBasicInfo)),
      contentType: Headers.formUrlEncodedContentType,
    );
    throwIf(
      !response.isSuccess,
      response.responseBody['resultMsg'] ?? StringConstants.updatingFailed,
    );
    return true;
  }
}
