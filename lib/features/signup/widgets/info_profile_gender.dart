import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sf_chat_im/features/signup/cubit/basic_info/basic_info_cubit.dart';
import 'package:sf_chat_im/shared/constants/assets.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/enums/enums.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';

class InfoProfileGender extends StatelessWidget {
  const InfoProfileGender({
    required this.onSelected,
    required this.selectedIndex,
    super.key,
  });
  final void Function(bool) onSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final genders = <String>[
      StringConstants.male,
      StringConstants.female,
    ];

    final icons = <String>[
      Assets.male,
      Assets.female,
    ];

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
                    StringConstants.gender,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              Wrap(
                children: [
                  for (var i = 0; i < genders.length; i++)
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.r,
                        right: 10.r,
                      ),
                      child: ChoiceChip(
                        avatar: SvgPicture.asset(
                          icons[i],
                          color: selectedIndex == i
                              ? theme.colorScheme.secondary
                              : theme.colorScheme.primary,
                        ),
                        label: Text(
                          genders[i],
                          style: selectedIndex == i
                              ? theme.textTheme.bodySmall
                                  ?.copyWith(color: theme.colorScheme.tertiary)
                              : theme.textTheme.bodySmall,
                        ),
                        selected: selectedIndex == i,
                        selectedColor: theme.colorScheme.primary,
                        onSelected: (isSelected) {
                          context
                              .read<BasicInfoCubit>()
                              .setSex(sex: i == 0 ? Sex.Male : Sex.Female);
                        },
                        backgroundColor: theme.colorScheme.secondary,
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
