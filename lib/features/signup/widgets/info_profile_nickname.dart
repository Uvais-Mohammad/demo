import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';

class InfoProfileNickname extends StatelessWidget {
  const InfoProfileNickname({
    required this.nicknameController,
    this.onChanged,
    super.key,
  });

  final TextEditingController nicknameController;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '*',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: CustomColors.carmine),
                  ),
                  Text(
                    StringConstants.nickname,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(
                width: 0.5.sw,
                child: TextFormField(
                  onChanged: onChanged,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.end,
                  maxLength: 32,
                  // inputFormatters: [NoSpaceFormatter()],
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
                  style: theme.textTheme.titleSmall,
                  controller: nicknameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    counter: Offstage(),
                    hintStyle: TextStyles.bodySmall.copyWith(
                        color: CustomColors.textColor.withOpacity(0.4)),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 15,
                      bottom: 11,
                      top: 11,
                      right: 15,
                    ),
                    hintText: StringConstants.pleaseEnterNickname,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
