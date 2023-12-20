// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sf_chat_im/features/discover/blocs/bloc/discovery_bloc.dart';
import 'package:sf_chat_im/features/discover/models/discover_list_response.dart';
import 'package:sf_chat_im/features/discover/screens/discover_detail_screen.dart';
import 'package:sf_chat_im/features/discover/screens/discover_screen.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/comment_box.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/comment_button.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/discover_single_image.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/discovery_image_viewer.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/single_comment.dart';
import 'package:sf_chat_im/features/profile/blocs/bloc/profile_bloc.dart';
import 'package:sf_chat_im/features/profile/screens/widgets/profile_image.dart';
import 'package:sf_chat_im/features/splash/cubit/splash_cubit.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';
import 'package:sf_chat_im/shared/utilities/functions.dart';
import 'package:sf_chat_im/shared/utilities/on_string.dart';
import 'package:sf_chat_im/shared/widgets/common_icon_button.dart';



class DiscoverItems extends StatelessWidget {
  const DiscoverItems({
    super.key,
    required this.thumbImages,
    this.width,
  });

  final List<Images> thumbImages;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final size = width ?? 1.sw - 100.r;
    final total = thumbImages.length;
    switch (total) {
      case 1:
        return Container(
          width: size,
          height: size,
          child: DiscoverSingleImage(
            index: 0,
            images: thumbImages,
            size: size,
          ),
        );
      case 2:
        return Row(
          children: [
            Container(
              width: size / 2,
              height: size / 3 * 2,
              child: DiscoverSingleImage(
                index: 0,
                images: thumbImages,
                size: size,
              ),
            ),
            Container(
              width: size / 2,
              height: size / 3 * 2,
              child: DiscoverSingleImage(
                index: 1,
                images: thumbImages,
                size: size,
              ),
            ),
          ],
        );
      case 3:
        return Row(
          children: [
            Container(
              width: size / 2,
              height: size / 3 * 2,
              child: DiscoverSingleImage(
                index: 0,
                images: thumbImages,
                size: size,
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 1).r,
                  width: size / 2,
                  height: size / 3,
                  child: DiscoverSingleImage(
                    index: 1,
                    images: thumbImages,
                    size: size,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 1).r,
                  width: size / 2,
                  height: size / 3,
                  child: DiscoverSingleImage(
                    index: 2,
                    images: thumbImages,
                    size: size,
                  ),
                ),
              ],
            ),
          ],
        );
      case 4:
        return Row(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 1).r,
                  width: size / 2,
                  height: size / 3,
                  child: DiscoverSingleImage(
                    index: 0,
                    images: thumbImages,
                    size: size,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 1).r,
                  width: size / 2,
                  height: size / 3,
                  child: DiscoverSingleImage(
                    index: 2,
                    images: thumbImages,
                    size: size,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 1).r,
                  width: size / 2,
                  height: size / 3,
                  child: DiscoverSingleImage(
                    index: 1,
                    images: thumbImages,
                    size: size,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 1).r,
                  width: size / 2,
                  height: size / 3,
                  child: DiscoverSingleImage(
                    index: 3,
                    images: thumbImages,
                    size: size,
                  ),
                ),
              ],
            ),
          ],
        );

      default:
        return Row(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 1).r,
                  width: size / 2,
                  height: size / 3,
                  child: DiscoverSingleImage(
                    index: 0,
                    images: thumbImages,
                    size: size,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 1).r,
                  width: size / 2,
                  height: size / 3,
                  child: DiscoverSingleImage(
                    index: 2,
                    images: thumbImages,
                    size: size,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 1).r,
                  width: size / 2,
                  height: size / 3,
                  child: DiscoverSingleImage(
                    index: 1,
                    images: thumbImages,
                    size: size,
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 1).r,
                      width: size / 2,
                      height: size / 3,
                      child: DiscoverSingleImage(
                        index: 3,
                        images: thumbImages,
                        size: size,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push<dynamic>(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => DiscoverImageViewer(
                              images: thumbImages,
                              localImage: thumbImages[3].localImage,
                              index: 3),
                          transitionDuration: Duration(milliseconds: 500),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 1, top: 1).r,
                        child: Container(
                          padding: EdgeInsets.only(right: 1, top: 1).r,
                          width: size / 2 - 2.r,
                          height: size / 3 - 1.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                ]),
                          ),
                          child: Center(
                            child: Text(
                              '+${thumbImages.length - 4}',
                              style: TextStyles.bodyLarge.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 42.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
    }
  }
}



class DiscoverDetailItem extends StatelessWidget {
  final DiscoverData discoverData;
  final EdgeInsets? padding;
  final int? commentLimit;
  final ScrollController scrollController;
  const DiscoverDetailItem({
    Key? key,
    required this.discoverData,
    required this.scrollController,
    this.padding,
    this.commentLimit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final thumbImages = discoverData.body?.images ?? [];
    final msgId = discoverData.msgId;
    final comments = discoverData.comments ?? [];
    final isMyPost = discoverData.userId ==
        context.read<SplashCubit>().state.loginResponse?.data?.userId;
    final praisesCount = discoverData.count?.praise ?? 0;
    final commentsCount = discoverData.count?.comment ?? 0;
    final isPraise = discoverData.isPraise == 1;
    final userId = discoverData.userId.toString();
    final nickName = discoverData.nickname ?? '';
    final bodyText = discoverData.body?.text ?? '';
    final time = discoverData.time ?? '';
    final theme = Theme.of(context);
    final commentingStatus = discoverData.commentingStatus;

    if (bodyText.isEmpty && thumbImages.isEmpty) {
      return SizedBox.shrink();
    }

    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        child: Padding(
          padding: padding ?? EdgeInsets.fromLTRB(20, 40, 0, 0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileImage(
                        userId: userId,
                        size: 30.r,
                      ),
                      SizedBox(width: 8.r),
                      Flexible(
                        child: Text(nickName,
                            style: TextStyles.bodyMedium.copyWith(
                                color: CustomColors.primary,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  if (isMyPost)
                    Padding(
                        padding: const EdgeInsets.only(left: 20).w,
                        child: CommonIconButton(
                          onPressed: () {
                            if (msgId != null) {
                              CommonFunctions.showCustomAlertDialog(
                                stressConfirm: true,
                                context: context,
                                style: theme.textTheme.titleSmall?.copyWith(
                                    color: theme.colorScheme.primary),
                                message: StringConstants.doYouDeleteThisPost,
                                onConfirm: () {
                                  context.read<DiscoveryBloc>().add(
                                        DeleteDiscovery(
                                          messageId: msgId,
                                        ),
                                      );
                                },
                              );
                            }
                          },
                          padding: EdgeInsets.zero,
                          icon: 'assets/svg/trash1.svg',
                          size: 20.sp,
                          iconColor: CustomColors.black.withOpacity(0.2),
                        )),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  22.verticalSpace,
                  if (bodyText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10).h,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(bodyText,
                                style: TextStyles.chatTertiary.copyWith(
                                    color: CustomColors.black.withOpacity(0.9),
                                    fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(
                            width: 20.w,
                          )
                        ],
                      ),
                    ),
                  if (thumbImages.isNotEmpty)
                    DiscoverItems(
                      thumbImages: thumbImages,
                      width: 1.sw - 40.r,
                    ),
                  10.verticalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 1.sw - 40.r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                LikeButton(
                                    msgId: msgId,
                                    isPraise: isPraise,
                                    praisesCount: praisesCount),
                                10.horizontalSpace,
                                CommentButton(
                                  msgId: msgId,
                                  commentsCount: commentsCount,
                                  comments: comments,
                                  commentingStatus: commentingStatus,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              child: Text(time.toString().timeAgo(),
                                  style: TextStyles.chatTertiaryInv.copyWith(
                                    color: CustomColors.black.withOpacity(0.3),
                                    letterSpacing: -0.5,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  if (comments.isNotEmpty)
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    CustomColors.black.withOpacity(0.005),
                                    CustomColors.black.withOpacity(0.02)
                                  ])),
                          child: SingleComment(
                            padding: EdgeInsets.fromLTRB(10, 12, 10, 12).r,
                            comment: comments[i],
                            userId: context
                                    .read<SplashCubit>()
                                    .state
                                    .loginResponse
                                    ?.data
                                    ?.userId
                                    .toString() ??
                                '',
                            onDelete: () {
                              if (comments[i].msgId != null &&
                                  comments[i].commentId != null) {
                                context.read<DiscoveryBloc>().add(
                                      DeleteComment(
                                        messageId: comments[i].msgId!,
                                        commentId: comments[i].commentId!,
                                      ),
                                    );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  60.verticalSpace
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
