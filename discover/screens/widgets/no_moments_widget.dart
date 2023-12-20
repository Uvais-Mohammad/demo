import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';

class NoMomentWidget extends StatelessWidget {
  const NoMomentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 100).h,
        child: Center(
          child: Text(
            StringConstants.noMomentsYet,
            style: TextStyles.bodyMedium.copyWith(
              color: CustomColors.black.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
