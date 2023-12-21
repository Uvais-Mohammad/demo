import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sf_chat_im/shared/constants/assets.dart';
import 'package:sf_chat_im/shared/widgets/common_icon_button.dart';

class InfoProfileImage extends StatelessWidget {
  const InfoProfileImage({super.key, this.child, this.onPressed});
  final Widget? child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(160.r),
            child: child ??
                SvgPicture.asset(
                  Assets.accountProfile,
                  width: 120.r,
                  height: 120.r,
                ),
          ),
          Positioned(
            bottom: 8.r,
            right: 8.r,
            child: CommonIconButton(
              onPressed: onPressed,
              size: 36.r,
              padding: EdgeInsets.all(7.r),
              icon: Assets.camera,
              iconColor: theme.colorScheme.primary,
              color: theme.colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
