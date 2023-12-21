import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/features/signup/cubit/signup/signup_cubit.dart';
import 'package:sf_chat_im/shared/cubits/country_cubit/country_cubit.dart';
import 'package:sf_chat_im/shared/enums/country_model.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/widgets/area_code_selector.dart';

class AreaCodeSignup extends StatelessWidget {
  const AreaCodeSignup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      child: BlocBuilder<CountryCubit, List<CountryModel>>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r)),
                ),
                context: context,
                builder: (BuildContext ctx) {
                  int selectedIndex = state.indexWhere((element) =>
                      element.prefix ==
                      context.read<SignUpCubit>().state.prefix);
                  return AreaCodeSelector(
                    selectedIndex: selectedIndex,
                    items: state,
                    onTap: (v) {
                      context.read<SignUpCubit>().changePrefix(
                            prefix: v,
                          );
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
            child: Container(
              width: 100,
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: CustomColors.secondary,
              ),
              child: Center(
                child: BlocSelector<SignUpCubit, SignUpState, int>(
                  selector: (state) {
                    return state.prefix;
                  },
                  builder: (context, prefix) {
                    return Text('+${prefix}');
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
