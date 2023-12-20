// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/features/chat/logic/chat_members_list_bloc/chat_members_listing_bloc.dart';
import 'package:sf_chat_im/features/discover/models/discover_list_response.dart';
import 'package:sf_chat_im/features/friends/blackFriends/blocs/bloc/black_friends_bloc.dart';
import 'package:sf_chat_im/features/friends/friendsList/blocs/add_friend/add_friend_bloc.dart';
import 'package:sf_chat_im/features/friends/friendsList/screens/friend_profile.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';
import 'package:sf_chat_im/shared/utilities/on_string.dart';
import 'package:sf_chat_im/shared/widgets/swipe_action.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleComment extends StatefulWidget {
  const SingleComment({
    super.key,
    required this.comment,
    required this.userId,
    required this.onDelete,
    this.padding,
  });

  final Comments comment;
  final String userId;
  final EdgeInsets? padding;
  final void Function() onDelete;

  @override
  State<SingleComment> createState() => _SingleCommentState();
}

class _SingleCommentState extends State<SingleComment> {
  final isSwiped = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return SwipeAction(
      onSwipeRight: () {
        isSwiped.value = false;
      },
      onSwipeLeft: () {
        if (widget.comment.userId.toString() == widget.userId) {
          isSwiped.value = true;
        }
      },
      child: Padding(
        padding: widget.padding ?? EdgeInsets.fromLTRB(30, 0, 30, 10).w,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
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
                                id: widget.userId.toString(),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        widget.comment.nickname ?? '',
                        style: TextStyles.chatTertiaryInv.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54),
                      ),
                    ),
                    Text(
                      widget.comment.time.toString().timeAgo(),
                      style: TextStyles.chatTertiaryInv.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black26),
                    ),
                  ],
                ),
                7.verticalSpace,
                Linkify(
                  text: (widget.comment.body ?? ''),
                  style: TextStyles.chatTertiaryInv.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                  onOpen: _onOpen,
                ),
                7.verticalSpace,
                Divider(
                  color: CustomColors.black.withOpacity(0.02),
                )
              ],
            ),
            ValueListenableBuilder(
                valueListenable: isSwiped,
                builder: (context, value, _) {
                  return AnimatedPositioned(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    right: value ? 0 : -130.w,
                    child: GestureDetector(
                      onTap: () {
                        isSwiped.value = false;
                        widget.onDelete();
                      },
                      child: Container(
                        color: Colors.red,
                        width: 100.w,
                        height: 50.h,
                        child: Center(
                          child: Text(
                            StringConstants.delete,
                            style: TextStyles.bodySmall
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

Future<void> _onOpen(LinkableElement link) async {
  if (!await launchUrl(Uri.parse(link.url))) {
    throw Exception('Could not launch ${link.url}');
  }
}
