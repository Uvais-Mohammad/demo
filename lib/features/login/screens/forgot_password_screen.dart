import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http_util_package/extensions/http_extensions.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:sf_chat_im/features/login/Logic/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:sf_chat_im/features/login/screens/widgets/bottom_body_forgot_password.dart';
import 'package:sf_chat_im/features/login/screens/widgets/login_signup_header.dart';
import 'package:sf_chat_im/features/login/screens/widgets/main_fields_forgot_password.dart';
import 'package:sf_chat_im/features/login/screens/widgets/sub_fields_forgot_password.dart';
import 'package:sf_chat_im/shared/constants/button_states.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';
import 'package:sf_chat_im/shared/widgets/common_loading_filled.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final phoneController = TextEditingController();
  final phoneNumberFocusNode = FocusNode();
  final passwordController = TextEditingController();
  final codeController = TextEditingController();
  final verificationCodeController = TextEditingController();
  final buttonController = MultiStateButtonController();
  final formKey = GlobalKey<FormState>();
  final graphicCodeFocusNode = FocusNode();
  final verificationCodeFocusNode = FocusNode();
  final primaryFocus = FocusScopeNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    phoneNumberFocusNode.addListener(() {
      if (!phoneNumberFocusNode.hasFocus) {
        if (phoneController.text.isNotEmpty) {
          context.read<ForgotPasswordCubit>().changePhoneNumber(
                phoneNumber: phoneController.text,
              );
        } else {
          context.read<ForgotPasswordCubit>().changePhoneNumber(
                phoneNumber: '',
              );
        }
      }
    });
    phoneController.addListener(() {
      context.read<ForgotPasswordCubit>().onUserFieldChanged1(
            phoneNumber: phoneController.text,
            password: passwordController.text,
            graphicCode: codeController.text,
            verificationCode: verificationCodeController.text,
          );
    });

    passwordController.addListener(() {
      context.read<ForgotPasswordCubit>().onUserFieldChanged1(
            phoneNumber: phoneController.text,
            password: passwordController.text,
            graphicCode: codeController.text,
            verificationCode: verificationCodeController.text,
          );
    });

    codeController.addListener(() {
      context.read<ForgotPasswordCubit>().onUserFieldChanged1(
            phoneNumber: phoneController.text,
            password: passwordController.text,
            graphicCode: codeController.text,
            verificationCode: verificationCodeController.text,
          );
    });

    verificationCodeController.addListener(() {
      context.read<ForgotPasswordCubit>().onUserFieldChanged1(
            phoneNumber: phoneController.text,
            password: passwordController.text,
            graphicCode: codeController.text,
            verificationCode: verificationCodeController.text,
          );
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (buttonController.buttonStateName.value != ButtonStates.submit) {
        buttonController.setButtonState = ButtonStates.submit;
      }
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    codeController.dispose();
    graphicCodeFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    verificationCodeFocusNode.dispose();
    verificationCodeController.dispose();
    formKey.currentState?.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MultiBlocListener(
            listeners: [
              BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                listener: (context, state) {
                  if (state.resetPasswordStatus == ApiFetchStatus.loading) {
                    buttonController.setButtonState = ButtonStates.loading;
                  }
                  if (state.resetPasswordStatus == ApiFetchStatus.success) {
                    showToast(StringConstants.resetPasswordSuccess);
                    buttonController.setButtonState = ButtonStates.success;
                    Future.delayed(
                      const Duration(milliseconds: 500),
                      () {
                        buttonController.setButtonState = ButtonStates.submit;
                        Navigator.of(context).pop();
                      },
                    );
                  }
                  if (state.resetPasswordStatus == ApiFetchStatus.failed) {
                    Future.delayed(
                      const Duration(milliseconds: 500),
                      () {
                        buttonController.setButtonState = ButtonStates.submit;
                      },
                    );
                  }
                },
              ),
              BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                listenWhen: (previous, current) {
                  return current.error.isNotNullOrEmpty;
                },
                listener: (context, state) {
                  showToast(state.error!);
                },
              ),
              BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                listenWhen: (p0, p1) {
                  return p0.verificationSendStatus != p1.verificationSendStatus;
                },
                listener: (context, state) async {
                  if (state.verificationSendStatus == ApiFetchStatus.success) {
                    showToast(
                        '${StringConstants.verificationCodeSent} ${state.prefix}${state.phoneNumber}');
                  }
                },
              ),
            ],
            child: Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  top: false,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 0.9.sh,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              LoginSignupHeader(
                                title: StringConstants.resetPassword,
                                isSignUpOrForgotPassword: true,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40)
                                        .r,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      AnimationConfiguration.toStaggeredList(
                                    duration: const Duration(milliseconds: 500),
                                    childAnimationBuilder: (widget) =>
                                        SlideAnimation(
                                      verticalOffset: 120,
                                      child: FadeInAnimation(
                                        child: widget,
                                      ),
                                    ),
                                    children: [
                                      MainFieldsForgotPassword(
                                        phoneController: phoneController,
                                        phoneNumberFocusNode:
                                            phoneNumberFocusNode,
                                        passwordController: passwordController,
                                        graphicCodeFocusNode:
                                            graphicCodeFocusNode,
                                        codeController: codeController,
                                        verificationCodeController:
                                            verificationCodeController,
                                      ),
                                      SubFieldsForgotPassword(
                                        codeController: codeController,
                                        phoneController: phoneController,
                                        primaryFocus: primaryFocus,
                                        passwordController: passwordController,
                                        verificationCodeFocusNode:
                                            verificationCodeFocusNode,
                                        verificationCodeController:
                                            verificationCodeController,
                                        graphicCodeFocusNode:
                                            graphicCodeFocusNode,
                                      ),
                                      BottomBodyForgotPassword(
                                        buttonController: buttonController,
                                        passwordController: passwordController,
                                        verificationCodeController:
                                            verificationCodeController,
                                        codeController: codeController,
                                        phoneController: phoneController,
                                        formKey: formKey,
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
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            builder: (context, state) {
              if (state.resetPasswordStatus == ApiFetchStatus.loading) {
                return CommonLoadingFilled();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
