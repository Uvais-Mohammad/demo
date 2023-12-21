import 'package:sf_chat_im/features/signup/models/signup_model.dart';
import 'package:sf_chat_im/features/signup/models/signup_parameter.dart';

abstract interface class ISignUpRepository {
  Future<bool> sendVerificationCode({
    required String telephone,
    required int areaCode,
    required String imgCode,
    required String language,
  });
  Future<SignupResponse> signUp({
    required SignupParameter parameter,
  });
  Future<bool> uploadAvatar({
    required String fileName,
    required String userId,
  });
  Future<String?> checkIsUserExists({
    required String value,
    String keyword = 'telephone',
  });

  Future<bool> update({
    required String nickName,
    required int gender,
    required String payPassword,
  });
}
