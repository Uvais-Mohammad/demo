import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_util_package/extensions/http_extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sf_chat_im/features/discover/blocs/bloc/discovery_bloc.dart';
import 'package:sf_chat_im/features/discover/blocs/cover_image_cubit/cover_image_cubit.dart';
import 'package:sf_chat_im/features/discover/models/discover_list_response.dart';
import 'package:sf_chat_im/features/discover/screens/add_discover_screen.dart';
import 'package:sf_chat_im/features/discover/screens/discover_detail_screen.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/comment_box.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/discovery_widget.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/no_moments_widget.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/pagination_loader.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/post_text_button.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/show_comment_bottom_sheet.dart';
import 'package:sf_chat_im/features/profile/blocs/bloc/profile_bloc.dart';
import 'package:sf_chat_im/features/profile/models/profile_response.dart';
import 'package:sf_chat_im/features/profile/screens/widgets/profile_image.dart';
import 'package:sf_chat_im/features/splash/cubit/splash_cubit.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/cubits/image_picker_cubit/local_image_picker_cubit.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';
import 'package:sf_chat_im/shared/utilities/functions.dart';
import 'package:sf_chat_im/shared/utilities/on_string.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';
import 'package:sf_chat_im/shared/widgets/common_icon_button.dart';
import 'package:sf_chat_im/shared/widgets/common_loading_filled.dart';
import 'package:sf_chat_im/shared/widgets/common_shimmer.dart';
import 'package:sf_chat_im/shared/widgets/custom_refresh_indicator.dart' as CR;

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);
  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _scrollController = AutoScrollController();
  final scrollNotifier = ValueNotifier<double>(0.0);
  final showLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    double lastThreshold = -10;
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      double scrolledPercentage = offset / 250 * 100;
      if (scrolledPercentage >= 0 && scrolledPercentage <= 100) {
        int currentThreshold = (scrolledPercentage / 10).floor() * 10;
        if (currentThreshold != lastThreshold) {
          scrollNotifier.value = scrolledPercentage;
          lastThreshold = currentThreshold.toDouble(); // Update last threshold
        }
      }

      final nextPageTrigger = _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels >= nextPageTrigger) {
        context
            .read<DiscoveryBloc>()
            .add(const FetchDiscoveryList(isLoadMore: true));
      }
    });

    context.read<DiscoveryBloc>().add(const FetchDiscoveryList());
    final userId = context
            .read<SplashCubit>()
            .state
            .loginResponse
            ?.data
            ?.userId
            .toString() ??
        '';
    context.read<ProfileBloc>().add(FetchProfile(userId: userId));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiscoveryBloc, DiscoveryState>(
      listenWhen: (previous, current) =>
          previous.scrollToIndex != current.scrollToIndex,
      listener: (context, state) {
        if (state.scrollToIndex != null) {
          _scrollController.scrollToIndex(state.scrollToIndex!,
              preferPosition: AutoScrollPosition.middle);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            CR.RefreshIndicator(
              onRefresh: () {
                context.read<DiscoveryBloc>().add(const FetchDiscoveryList());
                return Future(() => null);
              },
              child: ScrollConfiguration(
                behavior: MaterialScrollBehavior().copyWith(overscroll: false),
                child: CustomScrollView(
                  cacheExtent: 10000,
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: 250,
                      flexibleSpace: BlocSelector<ProfileBloc, ProfileState,
                          ProfileResponse?>(
                        selector: (state) {
                          return state.profileResponse;
                        },
                        builder: (context, profileResponse) {
                          if (profileResponse?.data == null) {
                            return Container(
                                height: 250.h, child: CommonShimmer());
                          }
                          final profileData = profileResponse!.data;
                          final nickname = profileData?.nickname ?? '';
                          final userId = profileData?.userId.toString() ?? '';
                          return FlexibleSpaceBar(
                            background: BlocProvider(
                                create: (context) => CoverImageCubit(),
                                child: _CoverImage()),
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(right: 12, bottom: 0).r,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    10.horizontalSpace,
                                    Flexible(
                                      child: Text(
                                        nickname,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyles.titleMedium.copyWith(
                                          color: Colors.white,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                              color: CustomColors.black
                                                  .withOpacity(0.2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    10.horizontalSpace,
                                    ProfileImage(
                                      br: 8.r,
                                      size: 50.w,
                                      userId: userId,
                                    ),
                                  ]),
                            ),
                          );
                        },
                      ),
                    ),
                    BlocConsumer<DiscoveryBloc, DiscoveryState>(
                      listener: (context, state) {
                        if (state.apiFetchStatus == ApiFetchStatus.failed) {
                          showToast(
                              state.error ?? StringConstants.failedToLoadData);
                        }
                      },
                      builder: (context, state) {
                        if (state.apiFetchStatus == ApiFetchStatus.loading) {
                          return SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 100).h,
                              child: Center(
                                child: Container(
                                  width: 80.w,
                                  height: 80.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.03),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 45.w,
                                        height: 45.w,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.grey),
                                          backgroundColor: Colors.white,
                                          strokeWidth: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        if (state.apiFetchStatus == ApiFetchStatus.success) {
                          if (state.discoverList?.data != null &&
                              (state.discoverList?.data ?? []).isEmpty) {
                            return NoMomentWidget();
                          }
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return AutoScrollTag(
                                  key: ValueKey(index),
                                  controller: _scrollController,
                                  index: index,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DiscoverItem(
                                          discoverData:
                                              state.discoverList!.data![index]),
                                      if (state.discoverList?.data?.length ==
                                              index + 1 &&
                                          state.loadMoreStatus ==
                                              ApiFetchStatus.loading)
                                        PaginationLoader()
                                    ],
                                  ),
                                );
                              },
                              childCount: state.discoverList?.data?.length ?? 0,
                            ),
                          );
                        }

                        return SliverToBoxAdapter(
                          child: SizedBox.shrink(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: SafeArea(
                bottom: false,
                child: ValueListenableBuilder(
                    valueListenable: scrollNotifier,
                    builder: (context, scrollPosition, child) {
                      final black = CustomColors.black.withOpacity(0.9);
                      double position = 0;
                      position = scrollPosition / 100;
                      position = (position > 0.5 ? position - 0.5 : 0) * 2;
                      return BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: position * 30, sigmaY: position * 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10).r,
                              child: SizedBox(
                                width: 40.sp,
                                height: 40.sp,
                              ),
                            ),
                            Text(
                              StringConstants.moments,
                              style: TextStyles.titleMedium.copyWith(
                                  color: Color.lerp(
                                      Colors.transparent, black, position)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10).r,
                              child: CommonIconButton(
                                size: 40.sp,
                                onPressed: () {
                                  showDiscoverPostBottomSheet(context);
                                },
                                icon: 'assets/svg/add_square.svg',
                                iconColor:
                                    Color.lerp(Colors.white, black, position),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: showLoading,
              builder: (_, showLoadingValue, child) {
                return showLoadingValue
                    ? CommonLoadingFilled()
                    : SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }

  void _nav(ImageSource source) async {
    showLoading.value = true;
    Navigator.pop(context);
    bool navToPost = false;
    final isLoading = context.read<DiscoveryBloc>().state.uploadStatus ==
        ApiFetchStatus.loading;
    if (!isLoading) {
      if (source == ImageSource.camera) {
        navToPost =
            await context.read<LocalImagePickerCubit>().onPicImageReturn(
                      ImageSource.camera,
                    ) ??
                false;
      } else {
        navToPost = await context
                .read<LocalImagePickerCubit>()
                .onPickMultipleImages() ??
            false;
      }
      context.read<DiscoveryBloc>().add(const ResetUploadStatus());
    } else {
      navToPost = true;
    }

    if (navToPost)
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: context.read<DiscoveryBloc>(),
              ),
              BlocProvider.value(
                value: context.read<LocalImagePickerCubit>(),
              ),
              BlocProvider.value(
                value: context.read<ProfileBloc>(),
              ),
            ],
            child: AddDiscoverScreen(),
          ),
        ),
      );
    showLoading.value = false;
  }

  void showDiscoverPostBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          height: 200.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PostTextButton(
                  pick: () {
                    _nav(ImageSource.camera);
                  },
                  text: StringConstants.camera,
                  subText: StringConstants.takePhoto),
              PostTextButton(
                  pick: () {
                    _nav(ImageSource.gallery);
                  },
                  text: StringConstants.photo,
                  subText: StringConstants.choosePhoto),
            ],
          ),
        );
      },
    );
  }
}

class _CoverImage extends StatefulWidget {
  const _CoverImage({
    super.key,
  });

  @override
  State<_CoverImage> createState() => _CoverImageState();
}

class _CoverImageState extends State<_CoverImage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userId = context
          .read<SplashCubit>()
          .state
          .loginResponse
          ?.data
          ?.userId
          .toString();
      context.read<ProfileBloc>().add(FetchProfile(userId: userId.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CoverImageCubit, CoverImageState>(
      listenWhen: (previous, current) =>
          previous.localImagePickStatus != current.localImagePickStatus,
      listener: (context, state) {
        if (state.localImagePickStatus == ApiFetchStatus.failed) {
          if (state.errorMessage.isNotNullOrEmpty) {
            showToast(state.errorMessage ?? StringConstants.permissionDenied);
          }
        }
        if (state.uploadImageStatus == ApiFetchStatus.failed) {
          if (state.errorMessage.isNotNullOrEmpty) {
            showToast(state.errorMessage ?? StringConstants.permissionDenied);
          }
        }
      },
      child: InkWell(
        onTap: () {
          context.read<CoverImageCubit>().onPicImage(ImageSource.gallery);
        },
        child: BlocSelector<CoverImageCubit, CoverImageState,
            (XFile?, ApiFetchStatus)>(selector: (state) {
          return (state.localImageFile, state.uploadImageStatus);
        }, builder: (context, imageState) {
          if (imageState.$2 == ApiFetchStatus.success) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), // Adjust the opacity as needed
                BlendMode.darken,
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(imageState.$1?.path ?? '')),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else {
            if (imageState.$1 != null) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1), // Adjust the opacity as needed
                  BlendMode.darken,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imageState.$1?.path ?? '')),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 45.w,
                          height: 45.w,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            backgroundColor: Colors.white30,
                            strokeWidth: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return _CoverFromProfile();
            }
          }
        }),
      ),
    );
  }
}

class _CoverFromProfile extends StatelessWidget {
  const _CoverFromProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileBloc, ProfileState,
        (ProfileResponse?, ApiFetchStatus)>(selector: (state) {
      return (state.profileResponse, state.apiFetchStatus);
    }, builder: (context, profileState) {
      if (profileState.$2 == ApiFetchStatus.loading) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: Colors.black.withOpacity(0.05)),
          width: 150.w,
          height: 250.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  backgroundColor: Colors.white30,
                  strokeWidth: 1,
                ),
              ),
            ],
          ),
        );
      }
      if (profileState.$1?.data?.msgBackGroundUrl != null) {
        final image = profileState.$1?.data?.msgBackGroundUrl ?? '';
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.1), // Adjust the opacity as needed
            BlendMode.darken,
          ),
          child: CachedNetworkImage(
            fadeInDuration: Duration(seconds: 0),
            fadeOutDuration: Duration(seconds: 0),
            imageBuilder: (context, imageProvider) {
              return Image(
                image: imageProvider,
                fit: BoxFit.cover,
              );
            },
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: Colors.black.withOpacity(0.05)),
              width: 150.w,
              height: 250.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      backgroundColor: Colors.white,
                      strokeWidth: 1,
                    ),
                  ),
                ],
              ),
            ),
            fit: BoxFit.cover,
            imageUrl: image,
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: Colors.black.withOpacity(0.05)),
              width: 150.w,
              height: 250.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/report2.svg',
                    width: 40.r,
                    height: 40.r,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            CustomColors.primaryDark.withOpacity(0.9),
            CustomColors.primaryDark.withOpacity(1),
          ])),
          child: Center(
            child: Text(
              StringConstants.tapToSet,
              style: TextStyles.bodySmall.copyWith(
                color: Colors.white24,
              ),
            ),
          ),
        );
      }
    });
  }
}

class DiscoverItem extends StatelessWidget {
  final DiscoverData discoverData;
  final EdgeInsets? padding;
  final int? commentLimit;
  const DiscoverItem({
    Key? key,
    required this.discoverData,
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

    return InkWell(
      onTap: () {
        Navigator.push<dynamic>(
          context,
          MaterialPageRoute(
            builder: (ctx) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<DiscoveryBloc>(),
                ),
                BlocProvider.value(
                  value: context.read<ProfileBloc>(),
                ),
              ],
              child: DiscoverDetailScreen(
                messageId: msgId,
              ),
            ),
          ),
        );
      },
      child: Container(
        child: Padding(
          padding: padding ?? EdgeInsets.fromLTRB(20, 40, 0, 0).r,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileImage(
                userId: userId,
                size: 50.r,
              ),
              SizedBox(width: 10.r),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(nickName,
                              style: TextStyles.bodyMedium.copyWith(
                                  color: CustomColors.primary,
                                  fontWeight: FontWeight.w700)),
                        ),
                        if (isMyPost)
                          Padding(
                              padding: const EdgeInsets.only(right: 20).w,
                              child: CommonIconButton(
                                onPressed: () {
                                  if (msgId != null) {
                                    CommonFunctions.showCustomAlertDialog(
                                      stressConfirm: true,
                                      context: context,
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                              color: theme.colorScheme.primary),
                                      message:
                                          StringConstants.doYouDeleteThisPost,
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
                    8.verticalSpace,
                    if (bodyText.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10).h,
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(bodyText,
                                  style: TextStyles.chatTertiary.copyWith(
                                      color:
                                          CustomColors.black.withOpacity(0.9),
                                      fontWeight: FontWeight.w400)),
                            ),
                            SizedBox(
                              width: 20.w,
                            )
                          ],
                        ),
                      ),
                    if (thumbImages.isNotEmpty)
                      Row(
                        children: [
                          DiscoverItems(thumbImages: thumbImages),
                        ],
                      ),
                    10.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 1.sw - 80.r,
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
                                      color:
                                          CustomColors.black.withOpacity(0.3),
                                      letterSpacing: -0.5,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        if (comments.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: CommentBox(
                              comments: comments,
                              msgId: msgId ?? '',
                              userId: userId,
                              commentLimit: commentLimit,
                            ),
                          ),
                      ],
                    ),
                    15.verticalSpace,
                    Divider(
                      height: 1,
                      color: CustomColors.black.withOpacity(0.03),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
    required this.msgId,
    required this.isPraise,
    required this.praisesCount,
  });

  final String? msgId;
  final bool isPraise;
  final int praisesCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        if (msgId != null) {
          context.read<DiscoveryBloc>().add(
                LikeUnlike(
                  messageId: msgId!,
                ),
              );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0).r,
        child: Row(
          children: [
            SvgPicture.asset(
              !isPraise ? 'assets/svg/heart.svg' : 'assets/svg/heart-fill.svg',
              width: 28.sp,
            ),
            4.horizontalSpace,
            Text(
              (praisesCount != 0 && praisesCount > 0)
                  ? '$praisesCount ${praisesCount == 1 ? StringConstants.like : StringConstants.likes}'
                  : StringConstants.like,
              style: TextStyles.bodySmall.copyWith(color: Colors.black38),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentButton extends StatelessWidget {
  const CommentButton({
    super.key,
    required this.msgId,
    required this.commentsCount,
    required this.comments,
    this.commentingStatus = ApiFetchStatus.idle,
  });

  final String? msgId;
  final int commentsCount;
  final List<Comments> comments;
  final ApiFetchStatus? commentingStatus;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        if (msgId != null) {
          showCommentBottomSheet(
              context: context, comments: comments, msgId: msgId!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0).r,
        child: Row(
          children: [
            commentingStatus == ApiFetchStatus.loading
                ? Padding(
                    padding: EdgeInsets.all(4.sp),
                    child: SizedBox(
                      width: 20.sp,
                      height: 20.sp,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                        backgroundColor: Colors.white,
                        strokeWidth: 1,
                      ),
                    ),
                  )
                : SvgPicture.asset(
                    'assets/svg/comment3.svg',
                    width: 28.sp,
                  ),
            4.horizontalSpace,
            Text(
              (commentsCount != 0 && commentsCount > 0)
                  ? '$commentsCount ${commentsCount == 1 ? StringConstants.comment : StringConstants.comments}'
                  : StringConstants.comment,
              style: TextStyles.bodySmall.copyWith(color: Colors.black38),
            ),
          ],
        ),
      ),
    );
  }
}
