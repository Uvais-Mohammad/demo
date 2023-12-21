import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http_util_package/extensions/http_extensions.dart';
import 'package:sf_chat_im/features/signup/cubit/signup/signup_cubit.dart';
import 'package:sf_chat_im/features/wallets/screens/widgets/otp_timer.dart';
import 'package:sf_chat_im/shared/api/app_urls.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';
import 'package:sf_chat_im/shared/widgets/common_button.dart';
import 'package:sf_chat_im/shared/widgets/common_icon_button.dart';
import 'package:sf_chat_im/shared/widgets/common_text_field.dart';

class SubFields extends StatelessWidget {
  const SubFields({
    required this.codeController,
    required this.phoneController,
    required this.passwordController,
    required this.verificationCodeController,
    required this.graphicCodeFocusNode,
    required this.verificationCodeFocusNode,
    required this.isAgreementAccepted,
    super.key,
  });

  final TextEditingController codeController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController verificationCodeController;
  final FocusNode graphicCodeFocusNode;
  final FocusNode verificationCodeFocusNode;
  final bool isAgreementAccepted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
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
                          onFieldSubmitted: (p0) => primaryFocus?.requestFocus(
                            verificationCodeFocusNode,
                          ),
                          // onChanged: (p0) {
                          //   context.read<SignUpCubit>().onUserFieldChanged1(
                          //         phoneNumber: phoneController.text,
                          //         password: passwordController.text,
                          //         graphicCode: codeController.text,
                          //         isAgreementAccepted: isAgreementAccepted,
                          //         verificationCode:
                          //             verificationCodeController.text,
                          //       );
                          // },
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
                                    locator<AppUrls>().getImageCodeForSignUp(
                                      phoneNumber: state.phoneNumberForImgCode
                                              ?.split('*')
                                              .first ??
                                          '',
                                      prefix: state.prefix,
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
                  //TODO:l10n->add
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
                          onFieldSubmitted: (p0) => primaryFocus?.requestFocus(
                            verificationCodeFocusNode,
                          ),
                          textInputType: TextInputType.number,
                          textInputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          // onChanged: (p0) {
                          //   context.read<SignUpCubit>().onUserFieldChanged1(
                          //         phoneNumber: phoneController.text,
                          //         password: passwordController.text,
                          //         graphicCode: codeController.text,
                          //         isAgreementAccepted: isAgreementAccepted,
                          //         verificationCode:
                          //             verificationCodeController.text,
                          //       );
                          // },
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
                        onPressed: () {
                          if (context
                                      .read<SignUpCubit>()
                                      .state
                                      .verificationSendStatus ==
                                  SignupStatus.success ||
                              context
                                      .read<SignUpCubit>()
                                      .state
                                      .verificationSendStatus ==
                                  SignupStatus.loading) {
                            return;
                          }
                          final phoneNumberError = context
                              .read<SignUpCubit>()
                              .state
                              .phoneNumberError;
                          if (phoneNumberError.isNotNullOrEmpty) {
                            showToast(phoneNumberError ?? '');
                          } else if (codeController.text.isEmpty) {
                            showToast(StringConstants.enterValidGraphicsCode);
                          } else {
                            verificationCodeController.clear();
                            context.read<SignUpCubit>().sendVerificationCode(
                                  areaCode:
                                      context.read<SignUpCubit>().state.prefix,
                                  imgCode: codeController.text,
                                  language: 'zh',
                                  telephone: phoneController.text,
                                );
                          }
                        },
                        child: BlocSelector<SignUpCubit, SignUpState,
                            SignupStatus>(
                          selector: (state) {
                            return state.verificationSendStatus;
                          },
                          builder: (context, state) {
                            if (state == SignupStatus.loading) {
                              return SizedBox(
                                width: 20.r,
                                height: 20.r,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              );
                            }
                            if (state == SignupStatus.success) {
                              return OtpTimer(
                                width: 30.w,
                                height: 30.h,
                                seconds: 60,
                                textStyle: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                ),
                                onEnd: () {
                                  context
                                      .read<SignUpCubit>()
                                      .changeVerificationSendStatus(
                                        status: SignupStatus.initial,
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
}

void reloadCaptcha(
  BuildContext context, {
  required String userNameOrPhoneNumber,
}) {
  if (userNameOrPhoneNumber.isNotEmpty) {
    imageCache
      ..clear()
      ..clearLiveImages();
    context.read<SignUpCubit>().changePhoneNumber(
          phoneNumber: userNameOrPhoneNumber,
        );
  } else {
    showToast(StringConstants.captchaLoad);
  }
}
