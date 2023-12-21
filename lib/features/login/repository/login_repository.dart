import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:http_util_package/core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sf_chat_im/features/login/models/login_response.dart';
import 'package:sf_chat_im/features/login/models/login_user_model.dart';
import 'package:sf_chat_im/features/login/repository/i_login_repository.dart';
import 'package:sf_chat_im/shared/api/app_urls.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/services/secure_storage_service/i_secure_storage.dart';
import 'package:sf_chat_im/shared/services/secure_storage_service/secure_storage_keys.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:sf_chat_im/shared/services/shared_preference_service/i_shared_preference.dart';
import 'package:sf_chat_im/shared/services/shared_preference_service/shared_pref_keys.dart';
import 'package:sf_chat_im/shared/utilities/extensions.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';

final class LoginRepository implements ILoginRepository {
  final appUrl = locator<AppUrls>();

  @override
  Future<PreviousLoginUserData?> fetchPreviousLoginActivity() async {
    final deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo? androidInfo;
    IosDeviceInfo? iosInfo;
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else {
      iosInfo = await deviceInfo.iosInfo;
    }
    final response = await HttpUtil().postData(
      appUrl.getUserByMachineCode,
      requireToken: false,
      data: {
        'machineCode':
            Platform.isAndroid ? androidInfo?.id : iosInfo?.identifierForVendor,
      }..addAll(defaultParameterMap(appUrl.getUserByMachineCode)),
      contentType: Headers.formUrlEncodedContentType,
    );
    if (response.isSuccess) {
      PreviousLoginUserData? responses;
      try {
        responses = PreviousLoginUserData.fromJson(response.responseBody);
      } catch (e) {
        print(e);
      }
      return responses;
    }
    return null;
  }

  @override
  Future<void> saveCredentialsToSecureStorage({
    required String pass,
    required String username,
    required String areaCode,
  }) async {
    await locator<ISecureStorageService>().write(
      key: SecureStorageKeys.userCredentials,
      encode: false,
      value: jsonEncode({
        'areaCode': areaCode,
        'user_name': username,
        'password': pass,
      }),
    );
  }

  @override
  Future<(String username, String password, String areaCode)?>
      getCredentialsFromSecureStorage() async {
    final data = await locator<ISecureStorageService>().read(
      key: SecureStorageKeys.userCredentials,
    );
    if (data == null) return null;
    final Map<String, dynamic> response = json.decode(data);
    return (
      response['user_name'].toString(),
      response['password'].toString(),
      response['areaCode'].toString()
    );
  }

  @override
  Future<LoginResponse?> loginUser({
    required String username,
    required String password,
    required bool saveCredToLocal,
    required int areaCode,
  }) async {
    final currentPosition = await getCurrentPosition();
    Map<String, dynamic> data = {};
    if (currentPosition != null) {
      Placemark? address;
      try {
        address = await getAddressFromLatLng(currentPosition);
      } catch (e) {}
      data = {
        // ignore: use_raw_strings
        '_sourceType': 'ios(\\U9177Talk_1.0.11)',
        'appId': 'com.kuliao.talk.easy33',
        if (address != null) 'area': address.subAdministrativeArea,
        'areaCode': areaCode,
        if (address != null) 'city': address.street,
        'latitude': currentPosition.latitude,
        'longitude': currentPosition.longitude,
        'machineCode': await getUniqueDeviceId(),
        'model': await getDeviceModel(),
        'password': password.toMD5String,
        if (address != null) 'provinces': address.country,
        'secret': '01b753cf094ebb03259b2deafa7e3384',
        'serial': '9A2FCD17E5AB4FF0823683EBD00C4CB0',
        'time': '1686818259',
        'userName': username,
        'version': '1.0.11',
        'xmppVersion': '1',
      };
    } else {
      data = {
        // ignore: use_raw_strings
        '_sourceType': 'ios(\\U9177Talk_1.0.11)',
        'appId': 'com.kuliao.talk.easy33',
        'machineCode': await getUniqueDeviceId(),
        'areaCode': areaCode,
        'model': await getDeviceModel(),
        'password': password.toMD5String,
        'secret': '01b753cf094ebb03259b2deafa7e3384',
        'serial': '9A2FCD17E5AB4FF0823683EBD00C4CB0',
        'time': '1686818259',
        'userName': username,
        'version': '1.0.11',
        'xmppVersion': '1',
      };
    }

    final response = await HttpUtil().postData(
      appUrl.login,
      data: data,
      requireToken: false,
      contentType: Headers.formUrlEncodedContentType,
    );

    throwIf(
      !response.isSuccess,
      LoginException(response.message ?? StringConstants.noInternetConnection),
    );
    if (!response.isSuccess) return null;
    final loginResponse = LoginResponse.fromJson(response.responseBody);
    await setUninstalledStatus(status: false);
    await saveLoginResponseToLocal(response: loginResponse);
    if (saveCredToLocal) {
      await saveCredentialsToSecureStorage(
        pass: password,
        username: username,
        areaCode: areaCode.toString(),
      );
    } else {
      await locator<ISecureStorageService>()
          .delete(key: SecureStorageKeys.userCredentials);
    }

    return loginResponse;
  }

  @override
  Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await handleLocationPermission();

      if (!hasPermission) {
        // throw LocationException(StringConstants.locationPermissionDenied);
        return null;
      }
      return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      // throw LocationException(
      //   StringConstants.enableLocationPermission,
      // );
      return null;
    }
  }

  @override
  Future<Placemark> getAddressFromLatLng(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      return placemarks[0];
    } catch (e) {
      if (e is PlatformException) {
        throw LocationException(StringConstants.noInternetConnection);
      }
      throw LocationException(
        StringConstants.enableLocationPermission,
      );
    }
  }

  @override
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Permission.location.isGranted;
    if (!serviceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationException(StringConstants.locationPermissionDenied);
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw LocationException(
          StringConstants.locationPermissionDeniedPermanently,
        );
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        serviceEnabled = true;
        return serviceEnabled;
      }
      throw LocationException(
          StringConstants.locationPermissionDeniedAllowText);
    }
    return true;
  }

  @override
  Future<LoginResponse?> getLoginResponseFromLocal() async {
    final response = await locator<ISecureStorageService>()
        .read(key: SecureStorageKeys.loginResponse);
    if (response == null) return null;
    return LoginResponse.fromJson(json.decode(response));
  }

  @override
  Future<void> saveLoginResponseToLocal({
    required LoginResponse response,
  }) async {
    await locator<ISecureStorageService>()
        .write(key: SecureStorageKeys.token, value: response.data?.accessToken);
    await locator<ISecureStorageService>()
        .write(key: SecureStorageKeys.loginResponse, value: response.toJson());
  }

  Future<void> setUninstalledStatus({required bool status}) async {
    await locator<ISharedPreferenceService>().setBool(
      SharedPrefKeys.isUninstalled,
      value: status,
    );
  }

  @override
  Future<bool> sendVerificationCodeForResetPassword({
    required String telephone,
    required int areaCode,
    required String imgCode,
    required String language,
  }) async {
    final response = await HttpUtil().getData(
      '''${appUrl.sendVerificationCodeForForgotPassword}?language=zh&user_phone=$telephone&areaCode=$areaCode&imgCode=$imgCode&version=1&isRegister=0''',
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
  Future<bool> resetPassword({
    required String telephone,
    required int areaCode,
    required String code,
    required String password,
  }) async {
    final response = await HttpUtil().postData(
      appUrl.forgetPassword,
      data: {
        'areaCode': areaCode,
        'randcode': code,
        'newPassword': password,
        'user_phone': telephone,
        'type': 0,
      }..addAll(defaultParameterMap(appUrl.forgetPassword)),
      requireToken: false,
      contentType: Headers.formUrlEncodedContentType,
    );
    throwIf(
      !response.isSuccess,
      response.message ?? StringConstants.resetPasswordFailed,
    );
    return true;
  }
}

class LoginException implements Exception {
  LoginException(this.message);

  final String message;
}

class LocationException implements Exception {
  LocationException(this.message);

  final String message;
}
