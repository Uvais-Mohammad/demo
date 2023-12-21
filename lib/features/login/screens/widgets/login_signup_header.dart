import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/features/splash/screens/widgets/splash_animation.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';

class LoginSignupHeader extends StatelessWidget {
  const LoginSignupHeader({
    required this.title,
    super.key,
    this.isSignUpOrForgotPassword = false,
  });

  final String title;
  final bool isSignUpOrForgotPassword;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(child: 20.verticalSpace),
          Stack(
            children: [
              Row(
                children: [
                  BackButton(
                    color: isSignUpOrForgotPassword
                        ? null
                        : theme.colorScheme.secondary,
                    onPressed: () => isSignUpOrForgotPassword
                        ? Navigator.pop(context)
                        : null,
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.r),
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: LogoBody(
              isStatic: true,
              size: 120.w,
            ),
          ),
          Text(
            StringConstants.introduction,
            style: TextStyles.bodyVerySmall
                .copyWith(color: theme.colorScheme.primary.withOpacity(0.3)),
          ),
          20.verticalSpace,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.r),
              ),
              color: theme.scaffoldBackgroundColor,
            ),
            child: Container(
              height: 20.h,
            ),
          ),
        ],
      ),
    );
  }
}
