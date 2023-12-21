import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/features/profile/screens/widgets/profile_image.dart';

class LoggedUserCard extends StatelessWidget {
  const LoggedUserCard({
    required this.name,
    required this.userId,
    super.key,
    // this.image,
    this.onPressed,
    this.isLastIndex,
  });

  final String name;
  final String userId;
  // final String? image;
  final bool? isLastIndex;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10).r,
            child: Row(
              children: [
                Divider(
                  height: 16.r,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(48.r),
                  child: ProfileImage(
                    size: 50,
                    userId: userId,
                  ),
                ),
                8.horizontalSpace,
                Text(
                  name,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        if (!isLastIndex!) const Divider(),
      ],
    );
  }
}
