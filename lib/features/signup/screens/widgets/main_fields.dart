import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http_util_package/extensions/http_extensions.dart';
import 'package:sf_chat_im/features/signup/cubit/signup/signup_cubit.dart';
import 'package:sf_chat_im/features/signup/screens/widgets/area_code_signup.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/utilities/input_formatters.dart';
import 'package:sf_chat_im/shared/widgets/common_text_field.dart';

class MainFields extends StatelessWidget {
  const MainFields({
    required this.phoneController,
    required this.phoneNumberFocusNode,
    required this.passwordController,
    required this.primaryFocus,
    required this.graphicCodeFocusNode,
    required this.codeController,
    required this.isAgreementAccepted,
    required this.verificationCodeController,
    required this.phoneOnChanged,
    super.key,
  });

  final TextEditingController phoneController;
  final FocusNode phoneNumberFocusNode;
  final TextEditingController passwordController;
  final FocusScopeNode primaryFocus;
  final FocusNode graphicCodeFocusNode;
  final TextEditingController codeController;
  final bool isAgreementAccepted;
  final TextEditingController verificationCodeController;
  final void Function(String) phoneOnChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.verticalSpace,
        Text(
          StringConstants.mobilePhone,
          style: theme.textTheme.bodySmall,
        ),
        8.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AreaCodeSignup(),
            10.horizontalSpace,
            Expanded(
              flex: 7,
              child: BlocSelector<SignUpCubit, SignUpState, String?>(
                selector: (state) {
                  return state.phoneNumberError;
                },
                builder: (context, state) {
                  return PrimaryTextField(
                    maxLength: 13,
                    hintText: StringConstants.signInHintText,
                    controller: phoneController,
                    onChanged: phoneOnChanged,
                    focusNode: phoneNumberFocusNode,
                    validator: (v) => state.isNotNullOrEmpty ? state : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textInputType: TextInputType.phone,
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
            context.read<SignUpCubit>().onUserFieldChanged1(
                  phoneNumber: phoneController.text,
                  password: passwordController.text,
                  graphicCode: codeController.text,
                  isAgreementAccepted: isAgreementAccepted,
                  verificationCode: verificationCodeController.text,
                );
          },
          enableObscure: true,
          prefixIcon: SvgPicture.asset(
            'assets/svg/locked.svg',
          ),
        ),
      ],
    );
  }
}
