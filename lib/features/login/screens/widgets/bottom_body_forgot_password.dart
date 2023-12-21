import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:sf_chat_im/features/login/Logic/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/utilities/extensions.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';
import 'package:sf_chat_im/shared/widgets/common_button.dart';

class BottomBodyForgotPassword extends StatelessWidget {
  const BottomBodyForgotPassword({
    required this.buttonController,
    required this.passwordController,
    required this.verificationCodeController,
    required this.codeController,
    required this.phoneController,
    required this.formKey,
    super.key,
  });

  final MultiStateButtonController buttonController;
  final TextEditingController passwordController;
  final TextEditingController verificationCodeController;
  final TextEditingController codeController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        22.verticalSpace,
        BlocSelector<ForgotPasswordCubit, ForgotPasswordState, bool>(
          selector: (state) {
            return state.isButtonActive;
          },
          builder: (context, isButtonActive) {
            return PrimaryButton(
              isEnabled: isButtonActive,
              controller: buttonController,
              width: 0.8.sw,
              height: 50.h,
              label: StringConstants.resetPassword,
              onPressed: () async {
                if (primaryFocus!.hasFocus) {
                  primaryFocus?.unfocus();
                }
                if (!formKey.currentState!.validate()) {
                  return;
                }
                bool isConnected = await context.isUserConnected();
                if (isConnected) {
                  await context.read<ForgotPasswordCubit>().forgetPassword(
                      telephone: phoneController.text,
                      areaCode:
                          context.read<ForgotPasswordCubit>().state.prefix,
                      code: verificationCodeController.text,
                      password: passwordController.text.toMD5String);
                } else {
                  showToast(StringConstants.noInternetConnection,
                      length: Toast.LENGTH_LONG);
                }
              },
            );
          },
        ),
        22.verticalSpace,
      ],
    );
  }
}
