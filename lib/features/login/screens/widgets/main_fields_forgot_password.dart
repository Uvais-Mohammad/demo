import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/features/login/screens/widgets/area_code_forgot_password.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/widgets/common_text_field.dart';

class MainFieldsForgotPassword extends StatelessWidget {
  const MainFieldsForgotPassword({
    required this.phoneController,
    required this.phoneNumberFocusNode,
    required this.passwordController,
    required this.graphicCodeFocusNode,
    required this.codeController,
    required this.verificationCodeController,
    super.key,
  });

  final TextEditingController phoneController;
  final FocusNode phoneNumberFocusNode;
  final TextEditingController passwordController;

  final FocusNode graphicCodeFocusNode;
  final TextEditingController codeController;
  final TextEditingController verificationCodeController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConstants.mobilePhone,
          style: theme.textTheme.bodySmall,
        ),
        8.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AreaCodeForgotPassword(),
            10.horizontalSpace,
            Expanded(
              flex: 7,
              child: PrimaryTextField(
                maxLength: 13,
                hintText: StringConstants.signInHintText,
                controller: phoneController,
                focusNode: phoneNumberFocusNode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputType: TextInputType.phone,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
