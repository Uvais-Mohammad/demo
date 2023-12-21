// ignore_for_file: one_member_abstracts

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sf_chat_im/features/login/models/login_response.dart';
import 'package:sf_chat_im/features/login/models/login_user_model.dart';

abstract interface class ILoginRepository {
  Future<PreviousLoginUserData?> fetchPreviousLoginActivity();

  Future<LoginResponse?> loginUser({
    required String username,
    required String password,
    required int areaCode,
    required bool saveCredToLocal,
  });

  Future<void> saveCredentialsToSecureStorage({
    required String pass,
    required String username,
    required String areaCode,
  });

  Future<(String username, String password, String areaCode)?>
      getCredentialsFromSecureStorage();

  Future<Position?> getCurrentPosition();

  Future<Placemark> getAddressFromLatLng(Position position);

  Future<bool> handleLocationPermission();

  Future<void> saveLoginResponseToLocal({required LoginResponse response});

  Future<LoginResponse?> getLoginResponseFromLocal();

  Future<bool> sendVerificationCodeForResetPassword({
    required String telephone,
    required int areaCode,
    required String imgCode,
    required String language,
  });

  Future<bool> resetPassword({
    required String telephone,
    required int areaCode,
    required String code,
    required String password,
  });
}
