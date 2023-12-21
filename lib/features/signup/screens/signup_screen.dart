import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:sf_chat_im/features/login/screens/widgets/login_signup_header.dart';
import 'package:sf_chat_im/features/signup/cubit/signup/signup_cubit.dart';
import 'package:sf_chat_im/features/signup/screens/privacy_policy_screen.dart';
import 'package:sf_chat_im/features/signup/screens/user_agreement_screen.dart';
import 'package:sf_chat_im/features/signup/screens/widgets/bottom_body.dart';
import 'package:sf_chat_im/features/signup/screens/widgets/main_fields.dart';
import 'package:sf_chat_im/features/signup/screens/widgets/sub_fields.dart';
import 'package:sf_chat_im/features/splash/cubit/splash_cubit.dart';
import 'package:sf_chat_im/shared/constants/button_states.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/utilities/route_generator.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final codeController = TextEditingController();
  final buttonController = MultiStateButtonController();
  final verificationCodeController = TextEditingController();
  // final payPasswordController = TextEditingController();
  final phoneNumberFocusNode = FocusNode();
  final graphicCodeFocusNode = FocusNode();
  final verificationCodeFocusNode = FocusNode();
  // final payPasswordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isAgreementAccepted = false;
  bool isScreenActive = true;
  Timer? _debounce;
  final deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    phoneNumberFocusNode.addListener(() {
      if (!phoneNumberFocusNode.hasFocus) {
        if (phoneController.text.isNotEmpty) {
          context.read<SignUpCubit>().changePhoneNumber(
                phoneNumber: phoneController.text,
              );
        } else {
          context.read<SignUpCubit>().changePhoneNumber(
                phoneNumber: '',
              );
        }
      }
    });
    phoneController.addListener(() {
      context.read<SignUpCubit>().onUserFieldChanged1(
            phoneNumber: phoneController.text,
            password: passwordController.text,
            graphicCode: codeController.text,
            isAgreementAccepted: isAgreementAccepted,
            verificationCode: verificationCodeController.text,
          );
    });
    passwordController.addListener(() {
      context.read<SignUpCubit>().onUserFieldChanged1(
            phoneNumber: phoneController.text,
            password: passwordController.text,
            graphicCode: codeController.text,
            isAgreementAccepted: isAgreementAccepted,
            verificationCode: verificationCodeController.text,
          );
    });
    codeController.addListener(() {
      context.read<SignUpCubit>().onUserFieldChanged1(
            phoneNumber: phoneController.text,
            password: passwordController.text,
            graphicCode: codeController.text,
            isAgreementAccepted: isAgreementAccepted,
            verificationCode: verificationCodeController.text,
          );
    });
    verificationCodeController.addListener(() {
      context.read<SignUpCubit>().onUserFieldChanged1(
            phoneNumber: phoneController.text,
            password: passwordController.text,
            graphicCode: codeController.text,
            isAgreementAccepted: isAgreementAccepted,
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

  void phoneOnChanged(String p0) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(
        const Duration(
          milliseconds: 500,
        ), () {
      imageCache
        ..clear()
        ..clearLiveImages();
      context.read<SignUpCubit>().checkUserExists(
            secret: 'secret',
            value: phoneController.text,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryFocus = FocusScope.of(context);
    isScreenActive = true;
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.error != null) {
              showToast(state.error!);
            }
          },
        ),
        BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            switch (state.status) {
              case SignupStatus.loading:
                buttonController.setButtonState = ButtonStates.loading;
              case SignupStatus.success:
                context
                    .read<SplashCubit>()
                    .updateLoginResponse(state.loginResponse);
                showToast(StringConstants.signUpSuccessful);
                buttonController.setButtonState = ButtonStates.success;
                Future.delayed(
                  const Duration(milliseconds: 500),
                  () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteGenerator.routeBasicInfoScreen,
                      (route) => false,
                    );
                  },
                );
              case SignupStatus.failure:
                buttonController.setButtonState = ButtonStates.error;
                buttonController.setButtonState = ButtonStates.submit;
              case SignupStatus.initial:
                buttonController.setButtonState = ButtonStates.submit;
            }
          },
        ),
        BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (p0, p1) {
            return p0.verificationSendStatus != p1.verificationSendStatus;
          },
          listener: (context, state) async {
            if (state.verificationSendStatus == SignupStatus.success) {
              showToast(
                  '${StringConstants.verificationCodeSent} ${state.prefix}${state.phoneNumber}');
            }
          },
        )
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoginSignupHeader(
                          title: StringConstants.signUpTitle,
                          isSignUpOrForgotPassword: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 500),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                verticalOffset: 120,
                                child: FadeInAnimation(
                                  child: widget,
                                ),
                              ),
                              children: [
                                MainFields(
                                  phoneOnChanged: phoneOnChanged,
                                  phoneController: phoneController,
                                  phoneNumberFocusNode: phoneNumberFocusNode,
                                  passwordController: passwordController,
                                  primaryFocus: primaryFocus,
                                  graphicCodeFocusNode: graphicCodeFocusNode,
                                  codeController: codeController,
                                  isAgreementAccepted: isAgreementAccepted,
                                  verificationCodeController:
                                      verificationCodeController,
                                ),
                                SubFields(
                                  codeController: codeController,
                                  phoneController: phoneController,
                                  passwordController: passwordController,
                                  verificationCodeController:
                                      verificationCodeController,
                                  graphicCodeFocusNode: graphicCodeFocusNode,
                                  verificationCodeFocusNode:
                                      verificationCodeFocusNode,
                                  isAgreementAccepted: isAgreementAccepted,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      BlocSelector<SignUpCubit, SignUpState,
                                          bool>(
                                        selector: (state) {
                                          return state.isAgreementAccepted;
                                        },
                                        builder: (context, state) {
                                          return SizedBox(
                                            width: 30.r,
                                            height: 30.r,
                                            child: Checkbox.adaptive(
                                              value: state,
                                              activeColor: theme.primaryColor,
                                              fillColor: state
                                                  ? MaterialStateProperty.all<
                                                      Color>(
                                                      theme.primaryColor,
                                                    )
                                                  : MaterialStateProperty.all<
                                                      Color>(
                                                      theme
                                                          .colorScheme.tertiary,
                                                    ),
                                              onChanged: (v) {
                                                context
                                                    .read<SignUpCubit>()
                                                    .changeAgreementAccepted(
                                                      isAgreementAccepted:
                                                          v ?? false,
                                                    );
                                                context
                                                    .read<SignUpCubit>()
                                                    .onUserFieldChanged1(
                                                      phoneNumber:
                                                          phoneController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      graphicCode:
                                                          codeController.text,
                                                      isAgreementAccepted:
                                                          v ?? false,
                                                      verificationCode:
                                                          verificationCodeController
                                                              .text,
                                                    );
                                                isAgreementAccepted =
                                                    v ?? false;
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      10.horizontalSpace,
                                      //TODO:l10n->need to change
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: StringConstants.acceptText1,
                                              style: theme.textTheme.bodySmall,
                                            ),
                                            TextSpan(
                                              text: StringConstants.acceptText2,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color:
                                                    theme.colorScheme.primary,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () =>
                                                    Navigator.push<dynamic>(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const UserAgreementScreen(),
                                                      ),
                                                    ),
                                            ),
                                            TextSpan(
                                              text: ' & ',
                                              style: theme.textTheme.bodySmall,
                                            ),
                                            TextSpan(
                                              text: StringConstants.acceptText3,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color:
                                                    theme.colorScheme.primary,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () =>
                                                    Navigator.push<dynamic>(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const PrivacyPolicyScreen(),
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40).r,
                      child: BottomBody(
                        buttonController: buttonController,
                        passwordController: passwordController,
                        verificationCodeController: verificationCodeController,
                        codeController: codeController,
                        phoneController: phoneController,
                        formKey: formKey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
