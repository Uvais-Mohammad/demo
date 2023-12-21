import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/features/signup/cubit/basic_info/basic_info_cubit.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/utilities/validator.dart';
import 'package:sf_chat_im/shared/widgets/common_pin_field.dart';

class PayPassword extends StatelessWidget {
  const PayPassword({
    required this.newPasswordPinController,
    required this.nickNameController,
    required this.confirmPasswordPinController,
    this.formKey,
    super.key,
  });

  final TextEditingController newPasswordPinController;
  final TextEditingController nickNameController;
  final TextEditingController confirmPasswordPinController;
  final GlobalKey<FormState>? formKey;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '*',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: CustomColors.carmine),
            ),
            Text(
              StringConstants.payPassword,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        20.verticalSpace,
        CommonPinFiledText(
          obscureText: true,
          controller: newPasswordPinController,
          validator: (v) {
            return Validator.validateWalletPassword(
              newPasswordPinController.text,
            );
          },
          onChanged: (p0) {
            if (newPasswordPinController.text.length == 6) {
              formKey?.currentState?.validate();
              context.read<BasicInfoCubit>().onUserFieldChanged(
                    nickName: nickNameController.text,
                    payPassword: p0,
                    payPasswordConfirm: confirmPasswordPinController.text,
                  );
            } else {
              context.read<BasicInfoCubit>().onUserFieldChanged(
                    nickName: nickNameController.text,
                    payPassword: '',
                    payPasswordConfirm: confirmPasswordPinController.text,
                  );
            }
          },
        ),
        20.verticalSpace,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '*',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: CustomColors.carmine),
            ),
            Text(
              StringConstants.confirmPayPassword,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        20.verticalSpace,
        CommonPinFiledText(
          obscureText: true,
          controller: confirmPasswordPinController,
          validator: (v) {
            return Validator.validateConfirmPassword(
              newPasswordPinController.text,
              confirmPasswordPinController.text,
            );
          },
          onChanged: (p0) {
            if (confirmPasswordPinController.text.length == 6) {
              formKey?.currentState?.validate();
              context.read<BasicInfoCubit>().onUserFieldChanged(
                    nickName: nickNameController.text,
                    payPassword: newPasswordPinController.text,
                    payPasswordConfirm: p0,
                  );
            } else {
              context.read<BasicInfoCubit>().onUserFieldChanged(
                    nickName: nickNameController.text,
                    payPassword: newPasswordPinController.text,
                    payPasswordConfirm: '',
                  );
            }
          },
        ),
      ],
    );
  }
}
