import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:sf_chat_im/features/login/Logic/login_with_username_cubit/login_cubit.dart';
import 'package:sf_chat_im/features/login/Logic/previous_login_activity_cubit/previous_login_activity_cubit.dart';
import 'package:sf_chat_im/features/login/models/login_user_model.dart';
import 'package:sf_chat_im/features/login/repository/login_repository.dart';
import 'package:sf_chat_im/features/login/screens/widgets/area_code_login.dart';
import 'package:sf_chat_im/features/login/screens/widgets/initial_popup.dart';
import 'package:sf_chat_im/features/login/screens/widgets/logged_user_card.dart';
import 'package:sf_chat_im/features/login/screens/widgets/login_bottom_body.dart';
import 'package:sf_chat_im/features/login/screens/widgets/login_signup_header.dart';
import 'package:sf_chat_im/features/main/screens/main_screen.dart';
import 'package:sf_chat_im/features/splash/cubit/splash_cubit.dart';
import 'package:sf_chat_im/shared/constants/button_states.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:sf_chat_im/shared/utilities/input_formatters.dart';
import 'package:sf_chat_im/shared/utilities/route_generator.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';
import 'package:sf_chat_im/shared/widgets/common_loading_filled.dart';
import 'package:sf_chat_im/shared/widgets/common_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final buttonController = MultiStateButtonController();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {
      context
          .read<LoginCubit>()
          .onUserFieldChanged(usernameController.text, passwordController.text);
    });
    passwordController.addListener(() {
      context
          .read<LoginCubit>()
          .onUserFieldChanged(usernameController.text, passwordController.text);
    });

    getAndSetSavedCredentials();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<PreviousLoginActivityCubit>().fetchPreviousLoginActivity();
      if (buttonController.buttonStateName.value != ButtonStates.submit) {
        buttonController.setButtonState = ButtonStates.submit;
      }
    });
  }

  Future<void> getAndSetSavedCredentials() async {
    final credentials =
        await locator<LoginRepository>().getCredentialsFromSecureStorage();
    if (credentials == null) return;
    usernameController.text = credentials.$1;
    passwordController.text = credentials.$2;
    context.read<LoginCubit>().changeAreaCode(int.parse(credentials.$3));
  }

  void showLoggedUserPopup(
    BuildContext context, {
    PreviousLoginUserData? previousLoginUserData,
  }) {
    final theme = Theme.of(context);
    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (ctx1, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
          child: AlertDialogInitial(
            parentContext: context,
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Text(
                    StringConstants.accountSelection,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Divider(
                  height: 16.r,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: previousLoginUserData!.data.length,
                  itemBuilder: (context, index) {
                    final isLastIndex =
                        index == previousLoginUserData.data.length - 1;
                    return LoggedUserCard(
                      isLastIndex: isLastIndex,
                      name: previousLoginUserData.data[index].telephone,
                      userId:
                          previousLoginUserData.data[index].userId.toString(),
                      onPressed: () async {
                        context.read<LoginCubit>().requestSingleSignIn(
                              username:
                                  previousLoginUserData.data[index].telephone,
                              password:
                                  previousLoginUserData.data[index].password,
                            );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<PreviousLoginActivityCubit, PreviousLoginActivityState>(
          listenWhen: (previous, current) =>
              previous.previousLoginActivityFetchStatus !=
              current.previousLoginActivityFetchStatus,
          listener: (context, state) {
            if (state.previousLoginActivityFetchStatus ==
                ApiFetchStatus.success) {
              if (state.previousLoginActivity!.data.isNotEmpty) {
                Future.delayed(const Duration(milliseconds: 5000), () {
                  showLoggedUserPopup(
                    context,
                    previousLoginUserData: state.previousLoginActivity,
                  );
                });
              }
            }
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) async {
            if (state is LoginFailed) {
              buttonController.setButtonState = ButtonStates.submit;
              showToast(state.message);
            } else if (state is LoginSuccess) {
              await context
                  .read<SplashCubit>()
                  .updateLoginResponse(state.loginResponse);
              if (!state.isNickNameUpdated) {
                showToast(StringConstants.pleaseCompleteProfile);
                await Navigator.pushReplacementNamed(
                  context,
                  RouteGenerator.routeBasicInfoScreen,
                );
                return;
              }
              showToast(StringConstants.loginSuccessful);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (ctx) => const MainScreen(),
                ),
              );
              // Future.delayed(const Duration(milliseconds: 500), () {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute<dynamic>(
              //       builder: (ctx) => const MainScreen(),
              //     ),
              //   );
              // });
            } else if (state is LoginInProgress) {
              // buttonController.setButtonState = ButtonStates.loading;
            } else if (state is SingleSignOnRequested) {
              Navigator.pop(context);
              // buttonController.setButtonState = ButtonStates.loading;
              usernameController.text = state.username;
              passwordController.text = '**********';

              await context.read<LoginCubit>().loginRequested(
                    userName: usernameController.text.trim(),
                    password: state.password,
                    areaCode: state.areaCode,
                  );
            }
          },
        ),
      ],
      child: Stack(
        children: [
          Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                top: false,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 0.9.sh,
                  ),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: LoginSignupHeader(
                                title: StringConstants.signIn,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40).r,
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
                                    //TODO:l10n->remove email
                                    Text(
                                      StringConstants.mobile,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: Row(
                                        children: [
                                          AreaCodeLogin(),
                                          10.horizontalSpace,
                                          Expanded(
                                            flex: 3,
                                            child: BlocBuilder<LoginCubit,
                                                LoginState>(
                                              builder: (context, state) {
                                                return PrimaryTextField(
                                                  enabled:
                                                      state is! LoginInProgress,
                                                  hintText: StringConstants
                                                      .signInHintText,
                                                  prefixIcon: SvgPicture.asset(
                                                    'assets/svg/user.svg',
                                                  ),
                                                  controller:
                                                      usernameController,
                                                  onEditingComplete: () {
                                                    passwordFocusNode
                                                        .requestFocus();
                                                  },
                                                  textInputType:
                                                      TextInputType.phone,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 22.h),
                                      child: Text(
                                        StringConstants.signUpPassword,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child:
                                          BlocBuilder<LoginCubit, LoginState>(
                                        builder: (context, state) {
                                          return PrimaryTextField(
                                            enabled: state is! LoginInProgress,
                                            hintText: StringConstants
                                                .signUpHintPassword,
                                            controller: passwordController,
                                            textInputFormatter: [
                                              NoSpaceFormatter(),
                                            ],
                                            enableObscure: true,
                                            focusNode: passwordFocusNode,
                                            prefixIcon: SvgPicture.asset(
                                              'assets/svg/locked.svg',
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    //remember password
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            RouteGenerator.routeForgotPassword,
                                          );
                                        },
                                        child: Text(
                                          StringConstants
                                              .forgotPasswordQuestion,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: theme.colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        children: [
                                          BlocSelector<LoginCubit, LoginState,
                                              bool>(
                                            selector: (state) {
                                              return state.rememberPassword;
                                            },
                                            builder: (context, isAgreed) {
                                              return Checkbox.adaptive(
                                                value: isAgreed,
                                                activeColor: theme.primaryColor,
                                                fillColor: isAgreed
                                                    ? MaterialStateProperty.all<
                                                        Color>(
                                                        theme.primaryColor,
                                                      )
                                                    : MaterialStateProperty.all<
                                                        Color>(
                                                        theme.colorScheme
                                                            .tertiary,
                                                      ),
                                                onChanged: (v) {
                                                  context
                                                      .read<LoginCubit>()
                                                      .changeRememberPasswordState(
                                                        value: v ?? false,
                                                      );
                                                },
                                              );
                                            },
                                          ),
                                          Text(
                                            StringConstants.signUpRememberPass,
                                            style: theme.textTheme.bodySmall,
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
                          child: LoginBottomBody(
                            buttonController: buttonController,
                            usernameController: usernameController,
                            passwordController: passwordController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginInProgress) {
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
