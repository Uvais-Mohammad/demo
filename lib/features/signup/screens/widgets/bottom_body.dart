import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:sf_chat_im/features/signup/cubit/signup/signup_cubit.dart';
import 'package:sf_chat_im/features/signup/models/signup_parameter.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/utilities/extensions.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';
import 'package:sf_chat_im/shared/widgets/common_button.dart';

class BottomBody extends StatelessWidget {
  const BottomBody({
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
    final theme = Theme.of(context);
    return Column(
      children: [
        22.verticalSpace,
        BlocSelector<SignUpCubit, SignUpState, bool>(
          selector: (state) {
            return state.isButtonActive;
          },
          builder: (context, isButtonActive) {
            return PrimaryButton(
              isEnabled: isButtonActive,
              controller: buttonController,
              width: 0.8.sw,
              height: 50.h,
              label: StringConstants.signUpBottom,
              onPressed: () async {
                if (primaryFocus!.hasFocus) {
                  primaryFocus?.unfocus();
                }
                if (!formKey.currentState!.validate()) {
                  return;
                }
                if (passwordController.text.contains(' ')) {
                  showToast(StringConstants.passwordInvalid);
                  return;
                }
                bool isConnected = await context.isUserConnected();
                if (isConnected) {
                  await context.read<SignUpCubit>().register(
                        SignupParameter(
                          password: passwordController.text.toMD5String,
                          areaCode: context.read<SignUpCubit>().state.prefix,
                          machineCode: await getUniqueDeviceId(),
                          model: await getDeviceModel(),
                          osVersion: '',
                          serial: '',
                          messageCode: verificationCodeController.text,
                          imgCode: codeController.text,
                          telephone: phoneController.text,
                          birthday:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                        ),
                      );
                } else {
                  showToast(StringConstants.noInternetConnection,
                      length: Toast.LENGTH_LONG);
                }
              },
            );
          },
        ),
        22.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO:l10n->add
            Text(
              StringConstants.alreadyHaveAccount,
              style: theme.textTheme.bodySmall,
            ),
            5.horizontalSpace,
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: ColoredBox(
                color: Colors.transparent,
                child: Text(
                  //TODO:l10n->add
                  StringConstants.signIn,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
