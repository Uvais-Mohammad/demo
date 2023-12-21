import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http_util_package/extensions/http_extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:sf_chat_im/features/chat/logic/profile_image_cubit/profile_image_cubit.dart';
import 'package:sf_chat_im/features/main/screens/main_screen.dart';
import 'package:sf_chat_im/features/signup/cubit/basic_info/basic_info_cubit.dart';
import 'package:sf_chat_im/features/signup/screens/widgets/pay_password.dart';
import 'package:sf_chat_im/features/signup/widgets/info_profile_gender.dart';
import 'package:sf_chat_im/features/signup/widgets/info_profile_image.dart';
import 'package:sf_chat_im/features/signup/widgets/info_profile_nickname.dart';
import 'package:sf_chat_im/features/splash/cubit/splash_cubit.dart';
import 'package:sf_chat_im/shared/constants/assets.dart';
import 'package:sf_chat_im/shared/constants/button_states.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/cubits/image_picker_cubit/local_image_picker_cubit.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/enums/enums.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';
import 'package:sf_chat_im/shared/widgets/common_button.dart';
import 'package:sf_chat_im/shared/widgets/common_loading.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({
    super.key,
  });

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  final ImagePicker picker = ImagePicker();
  final nickNameController = TextEditingController();
  final buttonController = MultiStateButtonController();
  final newPasswordPinController = TextEditingController();
  final confirmPasswordPinController = TextEditingController();
  Sex selectedSex = Sex.Male;
  final deviceInfoPlugin = DeviceInfoPlugin();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (buttonController.buttonStateName.value != ButtonStates.submit) {
        buttonController.setButtonState = ButtonStates.submit;
      }
      userId = context.read<SplashCubit>().state.loginResponse?.data?.userId;
    });
  }

  late int? userId;

  @override
  void dispose() {
    nickNameController.dispose();
    newPasswordPinController.dispose();
    confirmPasswordPinController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userId =
        context.read<SplashCubit>().state.loginResponse?.data?.userId;
    return MultiBlocListener(
      listeners: [
        BlocListener<BasicInfoCubit, BasicInfoState>(
          listener: (context, state) {
            if (state.submitStatus == ApiFetchStatus.success) {
              buttonController.setButtonState = ButtonStates.success;
              context
                  .read<SplashCubit>()
                  .updateLoginResponse(state.signupResponse);
              showToast(StringConstants.successfullyRegistered);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (ctx) => const MainScreen(),
                ),
                (route) => false,
              );
            } else if (state.submitStatus == ApiFetchStatus.failed) {
              buttonController.setButtonState = ButtonStates.error;
              Future.delayed(
                const Duration(milliseconds: 500),
                () {
                  buttonController.setButtonState = ButtonStates.submit;
                },
              );
            } else if (state.submitStatus == ApiFetchStatus.loading) {
              buttonController.setButtonState = ButtonStates.loading;
            }
          },
        ),
        BlocListener<BasicInfoCubit, BasicInfoState>(
          listener: (context, state) {
            if (state.imageUploadStatus == ApiFetchStatus.failed) {
              showToast(state.error ?? StringConstants.imageUploadFailed);
            }
          },
        ),
        BlocListener<LocalImagePickerCubit, LocalImagePickerState>(
          listenWhen: (previous, current) =>
              previous.localImagePickStatus != current.localImagePickStatus,
          listener: (context, state) async {
            if (state.localImagePickStatus == ApiFetchStatus.success &&
                state.localImageFile != null) {
              final userId =
                  context.read<SplashCubit>().state.loginResponse?.data?.userId;
              await context.read<BasicInfoCubit>().setProfileImage(
                    image: state.localImageFile!,
                    userId: userId.toString(),
                  );
            } else if (state.localImagePickStatus == ApiFetchStatus.failed) {
              if (state.errorMessage.isNotNullOrEmpty) {
                showToast(
                    state.errorMessage ?? StringConstants.permissionDenied);
              }
            }
          },
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            ProfileImageCubit()..getProfileIMage(userId: userId.toString()),
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: theme.colorScheme.primary,
                ),
              ),
              body: Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                CustomColors.primarySoft,
                                theme.colorScheme.primary,
                              ],
                            ),
                          ),
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                Assets.patternWhite,
                                width: 1.sw,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 60.r,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await imageOnPressed(context);
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 60.r,
                                      width: 120.r,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(50.r),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..translate(0.0, -60.r),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await imageOnPressed(context);
                                            },
                                            child: BlocSelector<
                                                BasicInfoCubit,
                                                BasicInfoState,
                                                (XFile?, ApiFetchStatus)>(
                                              selector: (state) => (
                                                state.image,
                                                state.imageUploadStatus
                                              ),
                                              builder: (context, state) {
                                                print(state.$2);
                                                return InfoProfileImage(
                                                  onPressed: () async {
                                                    await imageOnPressed(
                                                        context);
                                                  },
                                                  child: state.$2 ==
                                                          ApiFetchStatus.loading
                                                      ? Container(
                                                          color: theme
                                                              .colorScheme
                                                              .secondary,
                                                          width: 120.r,
                                                          height: 120.r,
                                                          child:
                                                              const CommonLoading(),
                                                        )
                                                      : state.$1 != null
                                                          ? SizedBox(
                                                              width: 120.r,
                                                              height: 120.r,
                                                              child: Image.file(
                                                                File(
                                                                  state
                                                                      .$1!.path,
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : null,
                                                );
                                              },
                                            ),
                                          ),
                                          16.verticalSpace,
                                          InfoProfileNickname(
                                            nicknameController:
                                                nickNameController,
                                            onChanged: (p0) => context
                                                .read<BasicInfoCubit>()
                                                .onUserFieldChanged(
                                                  nickName: p0,
                                                  payPassword:
                                                      newPasswordPinController
                                                          .text,
                                                  payPasswordConfirm:
                                                      confirmPasswordPinController
                                                          .text,
                                                ),
                                          ),
                                          BlocSelector<BasicInfoCubit,
                                              BasicInfoState, Sex?>(
                                            selector: (state) => state.sex,
                                            builder: (context, sex) {
                                              return InfoProfileGender(
                                                onSelected: (bool selected) {},
                                                selectedIndex: (sex != null)
                                                    ? (sex == Sex.Male ? 0 : 1)
                                                    : 0,
                                              );
                                            },
                                          ),
                                          10.verticalSpace,
                                          Divider(
                                            height: 10.r,
                                          ),
                                          20.verticalSpace,
                                          PayPassword(
                                            newPasswordPinController:
                                                newPasswordPinController,
                                            nickNameController:
                                                nickNameController,
                                            confirmPasswordPinController:
                                                confirmPasswordPinController,
                                            formKey: _formKey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        BlocSelector<BasicInfoCubit, BasicInfoState, bool>(
                          selector: (state) {
                            return state.isButtonActive;
                          },
                          builder: (context, state) {
                            return PrimaryButton(
                              isEnabled: state,
                              controller: buttonController,
                              width: 0.8.sw,
                              height: 50.h,
                              label: StringConstants.signUp,
                              onPressed: () async {
                                if (primaryFocus?.hasFocus ?? false) {
                                  primaryFocus?.unfocus();
                                }
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                await context
                                    .read<BasicInfoCubit>()
                                    .submitBasicInfo(
                                      nickName: nickNameController.text,
                                      payPassword:
                                          newPasswordPinController.text,
                                      gender: context
                                          .read<BasicInfoCubit>()
                                          .state
                                          .sex
                                          .index,
                                      signupResponse: context
                                          .read<SplashCubit>()
                                          .state
                                          .loginResponse!,
                                    );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> imageOnPressed(BuildContext context) async {
    context.read<LocalImagePickerCubit>().onPicImage(ImageSource.gallery, 20);
  }
}
