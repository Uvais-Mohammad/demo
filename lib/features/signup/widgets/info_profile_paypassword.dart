import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';

class InfoProfilePayPassword extends StatelessWidget {
  const InfoProfilePayPassword({
    required this.payPasswordController,
    this.onChanged,
    super.key,
  });

  final TextEditingController payPasswordController;
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
                    StringConstants.payPassword,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(
                width: 0.5.sw,
                child: TextFormField(
                  maxLength: 6,
                  onChanged: onChanged,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.end,
                  style: theme.textTheme.titleSmall,
                  controller: payPasswordController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
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
                    hintText: StringConstants.pleaseEnterPayPassword,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 10.r,
          ),
        ],
      ),
    );
  }
}
