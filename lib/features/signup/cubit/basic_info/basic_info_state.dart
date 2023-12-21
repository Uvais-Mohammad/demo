// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'basic_info_cubit.dart';

class BasicInfoState extends Equatable {
  const BasicInfoState({
    this.isButtonActive = false,
    this.sex = Sex.Male,
    this.image,
    this.submitStatus = ApiFetchStatus.idle,
    this.imageUploadStatus = ApiFetchStatus.idle,
    this.signupResponse,
    this.error,
  });

  final XFile? image;
  final ApiFetchStatus imageUploadStatus;
  final bool isButtonActive;
  final ApiFetchStatus submitStatus;
  final Sex sex;
  final LoginResponse? signupResponse;
  final String? error;
  @override
  List<Object?> get props => [
        isButtonActive,
        sex,
        image,
        imageUploadStatus,
        submitStatus,
        signupResponse
      ];

  BasicInfoState copyWith({
    bool? isButtonActive,
    XFile? image,
    Sex? sex,
    ApiFetchStatus? imageUploadStatus,
    ApiFetchStatus? submitStatus,
    LoginResponse? signupResponse,
    String? error,
  }) {
    return BasicInfoState(
      isButtonActive: isButtonActive ?? this.isButtonActive,
      image: image ?? this.image,
      sex: sex ?? this.sex,
      imageUploadStatus: imageUploadStatus ?? this.imageUploadStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      signupResponse: signupResponse ?? this.signupResponse,
      error: error ?? this.error,
    );
  }
}
