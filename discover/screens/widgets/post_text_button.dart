import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';

class PostTextButton extends StatelessWidget {
  const PostTextButton({
    super.key,
    required this.pick,
    required this.text,
    required this.subText,
  });

  final void Function() pick;
  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 100.h,
      child: TextButton(
        onPressed: pick,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyles.bodyLarge,
            ),
            Text(
              subText,
              style: TextStyles.bodySmall
                  .copyWith(color: CustomColors.black.withOpacity(0.2)),
            ),
          ],
        ),
      ),
    );
  }
}
