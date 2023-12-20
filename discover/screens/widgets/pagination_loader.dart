import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginationLoader extends StatelessWidget {
  const PaginationLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: 20.h),
      child: SizedBox(
          width: 20.r,
          height: 20.r,
          child: FittedBox(
            child: CircularProgressIndicator
                .adaptive(
              valueColor:
                  AlwaysStoppedAnimation<
                      Color>(Colors.grey),
              backgroundColor: Colors.white,
              strokeWidth: 5.r,
            ),
          )),
    );
  }
}