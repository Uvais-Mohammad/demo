// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/features/discover/blocs/bloc/discovery_bloc.dart';
import 'package:sf_chat_im/features/discover/models/discover_list_response.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/single_comment.dart';
import 'package:sf_chat_im/features/splash/cubit/splash_cubit.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';
import 'package:sf_chat_im/shared/widgets/common_icon_button.dart';
import 'package:sf_chat_im/shared/widgets/common_text_field.dart';

void showCommentBottomSheet(
    {required BuildContext context,
    required List<Comments> comments,
    required String msgId}) {
  final controller = TextEditingController();
  showModalBottomSheet<void>(
    isScrollControlled: true,
    showDragHandle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    context: context,
    builder: (BuildContext ctx) {
      final userId = context
              .read<SplashCubit>()
              .state
              .loginResponse
              ?.data
              ?.userId
              .toString() ??
          '';
      final nickName = context
              .read<SplashCubit>()
              .state
              .loginResponse
              ?.data
              ?.nickname
              .toString() ??
          '';
      return Container(
        height: 0.85.sh,
        child: ListView(
          children: [
            Center(
              child: Text(
                StringConstants.comments,
                style: TextStyles.bodyMedium,
              ),
            ),
            SizedBox(
              height: 18.w,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 18, 30, 30).w,
              child: PrimaryTextField(
                controller: controller,
                textInputType: TextInputType.multiline,
                maxLines: null,
                maxLength: 1000,
                onFieldSubmitted: (v) {
                  if (v.isNotEmpty) {
                    context.read<DiscoveryBloc>().add(
                          AddComment(
                            messageId: msgId,
                            comment: v,
                            toUserId: int.tryParse(userId) ?? 0,
                            nickName: nickName,
                          ),
                        );
                    Navigator.pop(context);
                  }
                },
                borderRadius: 6,
                fillColor: CustomColors.secondaryLight.withOpacity(0.2),
                hintText: StringConstants.addAComment,
                suffixIcon: CommonIconButton(
                  padding: EdgeInsets.all(2),
                  icon: 'assets/svg/send.svg',
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      context.read<DiscoveryBloc>().add(
                            AddComment(
                              messageId: msgId,
                              comment: controller.text,
                              toUserId: int.tryParse(userId) ?? 0,
                              nickName: nickName,
                            ),
                          );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
            for (var i = 0; i < comments.length; i++)
              SingleComment(
                comment: comments[i],
                userId: userId,
                onDelete: () {
                  if (comments[i].msgId != null &&
                      comments[i].commentId != null) {
                    context.read<DiscoveryBloc>().add(
                          DeleteComment(
                            messageId: comments[i].msgId!,
                            commentId: comments[i].commentId!,
                          ),
                        );
                    Navigator.pop(context);
                  }
                },
              ),
            80.verticalSpace,
          ],
        ),
      );
    },
  );
}
