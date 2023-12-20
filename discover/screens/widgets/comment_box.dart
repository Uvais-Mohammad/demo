// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/features/chat/logic/chat_members_list_bloc/chat_members_listing_bloc.dart';
import 'package:sf_chat_im/features/discover/models/discover_list_response.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/show_comment_bottom_sheet.dart';
import 'package:sf_chat_im/features/friends/blackFriends/blocs/bloc/black_friends_bloc.dart';
import 'package:sf_chat_im/features/friends/friendsList/blocs/add_friend/add_friend_bloc.dart';
import 'package:sf_chat_im/features/friends/friendsList/screens/friend_profile.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({
    super.key,
    required this.comments,
    required this.msgId,
    required this.userId,
    this.commentLimit,
  });

  final List<Comments> comments;
  final String msgId;
  final String userId;
  final int? commentLimit;

  @override
  Widget build(BuildContext context) {
    List<Widget> commentWidgets = [];

    for (var i = 0; i < comments.length && i < 3; i++) {
      var comment = comments[i];
      commentWidgets.add(
        Padding(
          padding: const EdgeInsets.all(8.0).r,
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: (comment.nickname ?? '') + ' ',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => AddFriendBloc(),
                                ),
                                BlocProvider(
                                  create: (context) => BlackFriendsBloc(),
                                ),
                                BlocProvider(
                                  create: (context) => ChatMembersListBloc(),
                                ),
                              ],
                              child: FriendProfileScreen(
                                id: userId.toString(),
                              ),
                            ),
                          ),
                        );
                      },
                    style: TextStyles.chatTertiary.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: comment.body,
                    style: TextStyles.chatTertiary.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87)),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6).h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black.withOpacity(0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: commentWidgets,
                ),
              ),
              if (comments.length > 3)
                TextButton(
                  onPressed: () {
                    showCommentBottomSheet(
                        context: context, comments: comments, msgId: msgId);
                  },
                  child: Text(
                    StringConstants.seeMore,
                    style: TextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w300,
                        color: CustomColors.black.withOpacity(0.3)),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
