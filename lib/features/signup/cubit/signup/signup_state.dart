part of 'signup_cubit.dart';

enum SignupStatus {
  initial,
  loading,
  success,
  failure,
}

class SignUpState extends Equatable {
  const SignUpState({
    this.isAgreementAccepted = false,
    this.phoneNumber,
    this.phoneNumberForImgCode,
    this.prefix = 971,
    this.isButtonActive = false,
    this.error,
    this.status = SignupStatus.initial,
    this.verificationSendStatus = SignupStatus.initial,
    this.phoneNumberError,
    this.loginResponse,
  });

  final bool isAgreementAccepted;
  final String? phoneNumber;
  final String? phoneNumberForImgCode;
  final int prefix;
  final bool isButtonActive;
  final String? error;
  final SignupStatus status;
  final SignupStatus verificationSendStatus;
  final String? phoneNumberError;
  final LoginResponse? loginResponse;
  @override
  List<Object?> get props => [
        isAgreementAccepted,
        phoneNumber,
        prefix,
        isButtonActive,
        verificationSendStatus,
        error,
        status,
        phoneNumberForImgCode,
        phoneNumberError,
        loginResponse,
      ];

  SignUpState copyWith({
    bool? isAgreementAccepted,
    String? phoneNumber,
    int? prefix,
    bool? isButtonActive,
    XFile? image,
    Sex? sex,
    String? error,
    bool? isAuthCodeVerified,
    SignupStatus? status,
    SignupStatus? verificationSendStatus,
    String? phoneNumberError,
    LoginResponse? loginResponse,
    String? phoneNumberForImgCode,
  }) {
    return SignUpState(
      isAgreementAccepted: isAgreementAccepted ?? this.isAgreementAccepted,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      prefix: prefix ?? this.prefix,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      error: error,
      status: status ?? this.status,
      verificationSendStatus:
          verificationSendStatus ?? this.verificationSendStatus,
      phoneNumberError: phoneNumberError ?? this.phoneNumberError,
      loginResponse: loginResponse ?? this.loginResponse,
      phoneNumberForImgCode:
          phoneNumberForImgCode ?? this.phoneNumberForImgCode,
    );
  }
}
