import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:sf_chat_im/features/login/Logic/login_with_username_cubit/login_cubit.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/utilities/extensions.dart';
import 'package:sf_chat_im/shared/utilities/route_generator.dart';
import 'package:sf_chat_im/shared/widgets/common_button.dart';

import '../../../../shared/utilities/utils.dart';

class LoginBottomBody extends StatelessWidget {
  const LoginBottomBody({
    required this.buttonController,
    required this.usernameController,
    required this.passwordController,
    super.key,
  });

  final MultiStateButtonController buttonController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 22.h),
          child: Column(
            children: [
              BlocSelector<LoginCubit, LoginState, bool>(
                selector: (state) {
                  return state.isButtonActive;
                },
                builder: (context, isButtonActive) {
                  return PrimaryButton(
                    isEnabled: isButtonActive,
                    controller: buttonController,
                    width: 0.8.sw,
                    height: 50.h,
                    //TODO:l10n->Need to change
                    label: StringConstants.login,
                    onPressed: () async {
                      if (primaryFocus?.hasFocus ?? false) {
                        primaryFocus?.unfocus();
                      }
                      bool isConnected = await context.isUserConnected();
                      if (isConnected) {
                        await context.read<LoginCubit>().loginRequested(
                              userName: usernameController.text
                                  .trim()
                                  .removeZerosFromFirst(),
                              password: passwordController.text.trim(),
                              areaCode:
                                  context.read<LoginCubit>().state.areaCode,
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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteGenerator.routeSignUpScreen,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConstants.dontHaveAccount,
                      style: theme.textTheme.bodySmall,
                    ),
                    5.horizontalSpace,
                    ColoredBox(
                      color: Colors.transparent,
                      child: Text(
                        StringConstants.register,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
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
    );
  }
}
