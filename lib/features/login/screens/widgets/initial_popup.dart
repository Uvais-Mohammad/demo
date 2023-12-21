import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sf_chat_im/shared/utilities/extensions.dart';

class AlertDialogInitial extends StatelessWidget {
  const AlertDialogInitial({
    required this.parentContext,
    super.key,
    this.child,
    this.width,
  });

  final Widget? child;
  final double? width;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: <Widget>[
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: width ?? context.sw(),
                      padding: EdgeInsets.all(30.r),
                      margin: EdgeInsets.all(30.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0, 10),
                            blurRadius: 10.r,
                          ),
                        ],
                      ),
                      child: child,
                    ),
                    10.verticalSpace,
                    GestureDetector(
                      onTap: () async {
                        await Navigator.maybePop(parentContext);
                      },
                      child: SvgPicture.asset(
                        'assets/svg/closecircle.svg',
                        width: 50.w,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
