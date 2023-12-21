import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sf_chat_im/features/login/Logic/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:sf_chat_im/features/wallets/screens/widgets/otp_timer.dart';
import 'package:sf_chat_im/shared/api/app_urls.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';
import 'package:sf_chat_im/shared/utilities/extensions.dart';
import 'package:sf_chat_im/shared/utilities/input_formatters.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';
import 'package:sf_chat_im/shared/widgets/common_button.dart';
import 'package:sf_chat_im/shared/widgets/common_icon_button.dart';
import 'package:sf_chat_im/shared/widgets/common_text_field.dart';

class SubFieldsForgotPassword extends StatelessWidget {
  const SubFieldsForgotPassword({
    required this.codeController,
    required this.phoneController,
    required this.passwordController,
    required this.verificationCodeController,
    required this.verificationCodeFocusNode,
    required this.graphicCodeFocusNode,
    required this.primaryFocus,
    super.key,
  });

  final TextEditingController codeController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController verificationCodeController;
  final FocusNode verificationCodeFocusNode;
  final FocusNode graphicCodeFocusNode;
  final FocusScopeNode primaryFocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        imageCache
          ..clear()
          ..clearLiveImages();
        if (state.phoneNumber != null && state.phoneNumber!.isNotEmpty) {
          return AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  16.verticalSpace,
                  Text(
                    StringConstants.graphicsCode,
                    style: theme.textTheme.bodySmall,
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryTextField(
                          hintText: StringConstants.graphicsCode,
                          controller: codeController,
                          focusNode: graphicCodeFocusNode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (p0) => FocusScope.of(context)
                              .requestFocus(verificationCodeFocusNode),
                          prefixIcon: SvgPicture.asset(
                            'assets/svg/locked.svg',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Container(
                          height: 45.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100.w,
                                child: Padding(
                                  padding: const EdgeInsets.all(8).r,
                                  child: Image.network(
                                    locator<AppUrls>()
                                        .getImageCodeForForgotPassword(
                                      prefix: state.prefix,
                                      phoneNumber: state.phoneNumberForImgCode
                                              ?.split('*')
                                              .first ??
                                          '',
                                    ),
                                    key: ValueKey(
                                      state.phoneNumberForImgCode,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40.r,
                                height: 45.h,
                                child: CommonIconButton(
                                  iconColor: theme.colorScheme.primary
                                      .withOpacity(0.3),
                                  onPressed: () => reloadCaptcha(
                                    context,
                                    userNameOrPhoneNumber: phoneController.text,
                                  ),
                                  icon: 'assets/svg/refresh.svg',
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(
                                      12.r,
                                    ),
                                  ),
                                  color: theme.colorScheme.secondary,
                                  padding: EdgeInsets.all(12.r),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Text(
                    StringConstants.verificationCode,
                    style: theme.textTheme.bodySmall,
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryTextField(
                          hintText: StringConstants.enterVerificationCode,
                          controller: verificationCodeController,
                          focusNode: verificationCodeFocusNode,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          textInputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          prefixIcon: SvgPicture.asset(
                            'assets/svg/locked.svg',
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      CustomButton(
                        borderRadius: BorderRadius.circular(10.r),
                        height: 45.h,
                        width: 144.w,
                        onPressed: () async {
                          bool isConnected = await context.isUserConnected();
                          if (isConnected) {
                            if (context
                                        .read<ForgotPasswordCubit>()
                                        .state
                                        .verificationSendStatus ==
                                    ApiFetchStatus.success ||
                                context
                                        .read<ForgotPasswordCubit>()
                                        .state
                                        .verificationSendStatus ==
                                    ApiFetchStatus.loading) {
                              return;
                            }
                            verificationCodeController.clear();
                            context
                                .read<ForgotPasswordCubit>()
                                .sendVerificationCode(
                                  areaCode: context
                                      .read<ForgotPasswordCubit>()
                                      .state
                                      .prefix,
                                  imgCode: codeController.text,
                                  language: 'zh',
                                  telephone: phoneController.text,
                                );
                          } else {
                            showToast(StringConstants.noInternetConnection,
                                length: Toast.LENGTH_LONG);
                          }
                        },
                        child: BlocSelector<ForgotPasswordCubit,
                            ForgotPasswordState, ApiFetchStatus>(
                          selector: (state) {
                            return state.verificationSendStatus;
                          },
                          builder: (context, state) {
                            if (state == ApiFetchStatus.loading) {
                              return SizedBox(
                                width: 20.r,
                                height: 20.r,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              );
                            }
                            if (state == ApiFetchStatus.success) {
                              return OtpTimer(
                                width: 30.w,
                                height: 30.h,
                                seconds: 60,
                                textStyle: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                ),
                                onEnd: () {
                                  context
                                      .read<ForgotPasswordCubit>()
                                      .changeVerificationSendStatus(
                                        status: ApiFetchStatus.idle,
                                      );
                                },
                              );
                            }
                            return Text(
                              StringConstants.signUpSend,
                              style: TextStyles.regular12
                                  .copyWith(color: Colors.white),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Text(
                    StringConstants.signUpPassword,
                    style: theme.textTheme.bodySmall,
                  ),
                  8.verticalSpace,
                  PrimaryTextField(
                    hintText: StringConstants.signUpHintPassword,
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    textInputFormatter: [
                      NoSpaceFormatter(),
                    ],
                    onFieldSubmitted: (p0) =>
                        primaryFocus.requestFocus(graphicCodeFocusNode),
                    onChanged: (p0) {
                      context.read<ForgotPasswordCubit>().onUserFieldChanged1(
                            phoneNumber: phoneController.text,
                            password: passwordController.text,
                            graphicCode: codeController.text,
                            verificationCode: verificationCodeController.text,
                          );
                    },
                    enableObscure: true,
                    prefixIcon: SvgPicture.asset(
                      'assets/svg/locked.svg',
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // return const CommonLoading();
          return const SizedBox();
        }
      },
    );
  }

  void reloadCaptcha(
    BuildContext context, {
    required String userNameOrPhoneNumber,
  }) {
    if (userNameOrPhoneNumber.isNotEmpty) {
      context.read<ForgotPasswordCubit>().changePhoneNumber(
            phoneNumber: userNameOrPhoneNumber,
          );
    } else {
      showToast(StringConstants.captchaLoad);
    }
  }
}
