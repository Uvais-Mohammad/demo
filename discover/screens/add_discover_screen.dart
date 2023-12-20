import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_util_package/extensions/http_extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:sf_chat_im/features/discover/blocs/bloc/discovery_bloc.dart';
import 'package:sf_chat_im/features/discover/models/add_discover_parameter.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/post_text_button.dart';
import 'package:sf_chat_im/features/profile/blocs/bloc/profile_bloc.dart';
import 'package:sf_chat_im/features/splash/cubit/splash_cubit.dart';
import 'package:sf_chat_im/shared/constants/assets.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/cubits/image_picker_cubit/local_image_picker_cubit.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';
import 'package:sf_chat_im/shared/widgets/common_icon_button.dart';
import 'package:sf_chat_im/shared/widgets/common_loading.dart';

class AddDiscoverScreen extends StatefulWidget {
  const AddDiscoverScreen({Key? key}) : super(key: key);

  @override
  State<AddDiscoverScreen> createState() => _AddDiscoverScreenState();
}

class _AddDiscoverScreenState extends State<AddDiscoverScreen> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DiscoveryBloc, DiscoveryState>(
          listener: (context, state) {
            if (state.uploadStatus == ApiFetchStatus.success) {
              context.read<LocalImagePickerCubit>().removeAllLocalImages();
              Future.delayed(Duration(seconds: 2), () {
                Navigator.pop(context);
              });
            }
          },
        ),
        BlocListener<DiscoveryBloc, DiscoveryState>(
          listenWhen: (previous, current) => current.error.isNotNullOrEmpty,
          listener: (context, state) {
            showToast(state.error ?? StringConstants.failedToLoadData);
          },
        ),
      ],
      child:
          BlocBuilder<DiscoveryBloc, DiscoveryState>(builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            await context.read<LocalImagePickerCubit>().removeAllLocalImages();
            return Future(() => true);
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: BackButton(
                  color: Colors.black,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    if (state.uploadStatus == ApiFetchStatus.loading ||
                        state.uploadStatus == ApiFetchStatus.success)
                      Container(
                        height: 0.8.sh,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        CustomColors.primary.withOpacity(0.02),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  width: 150.w,
                                  height: 150.w,
                                  child: state.uploadStatus !=
                                          ApiFetchStatus.loading
                                      ? Lottie.asset(
                                          Assets.successAnim,
                                          width: 100.w,
                                          repeat: false,
                                        )
                                      : CommonLoading(
                                          size: 60.w,
                                        ),
                                ),
                              ),
                              20.verticalSpace,
                              Text('${StringConstants.uploading}...')
                            ]),
                      )
                    else
                      ListView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          TextField(
                            maxLines: 10,
                            minLines: 1,
                            maxLength: 1200,
                            controller: textController,
                            textAlign: TextAlign.left,
                            style:
                                TextStyles.titleSmall.copyWith(fontSize: 20.sp),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              counterStyle: TextStyles.bodySmall.copyWith(
                                fontSize: 10.sp,
                                color: CustomColors.black.withOpacity(0.2),
                              ),
                              hintText: '${StringConstants.saySomething}...',
                              hintStyle: TextStyles.bodySmall.copyWith(
                                fontSize: 20.sp,
                                color: CustomColors.semiTertiary,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                              ).r,
                            ),
                          ),
                          SizedBox(height: 40.h),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0).w,
                            child: BlocBuilder<LocalImagePickerCubit,
                                LocalImagePickerState>(
                              builder: (context, state) {
                                return GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      (state.localImageFiles?.length ?? 0) + 1,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        (state.localImageFiles?.length ?? 0)) {
                                      return InkWell(
                                        onTap: () {
                                          showDiscoverPostBottomSheet(context);
                                        },
                                        child: Container(
                                          color: CustomColors.black
                                              .withOpacity(0.05),
                                          child: Icon(
                                            Icons.add,
                                            color: CustomColors.black
                                                .withOpacity(0.4),
                                          ),
                                        ),
                                      );
                                    } else {
                                      final file =
                                          state.localImageFiles![index];
                                      return Container(
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: CommonIconButton(
                                              color: Colors.white38,
                                              onPressed: () {
                                                context
                                                    .read<
                                                        LocalImagePickerCubit>()
                                                    .removeImage(index);
                                              },
                                              size: 30.w,
                                              icon: Assets.trash,
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: FileImage(File(file.path)),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              floatingActionButton: state.uploadStatus ==
                          ApiFetchStatus.loading ||
                      state.uploadStatus == ApiFetchStatus.success
                  ? null
                  : FloatingActionButton.extended(
                      onPressed: () {
                        final isImageEmpty = context
                                .read<LocalImagePickerCubit>()
                                .state
                                .localImageFiles
                                ?.isEmpty ??
                            true;
                        final userId = context.read<SplashCubit>().userId;
                        final nickName = context
                                .read<ProfileBloc>()
                                .state
                                .profileResponse
                                ?.data
                                ?.nickname ??
                            context
                                .read<SplashCubit>()
                                .state
                                .loginResponse
                                ?.data
                                ?.nickname;
                        // if (isImageEmpty && textController.text.isNotEmpty) {
                        //   context.read<DiscoveryBloc>().add(
                        //         PostText(
                        //           discoverParameter: DiscoverParameter.text(
                        //             text: textController.text,
                        //             nickName: nickName,
                        //           ),
                        //           userId: userId.toString(),
                        //         ),
                        //       );
                        // }
                        if (!isImageEmpty) {
                          context.read<DiscoveryBloc>().add(
                                PostImage(
                                  discoverParameter: DiscoverParameter.image(
                                    text: textController.text,
                                    nickName: nickName,
                                  ),
                                  localImageFiles: context
                                          .read<LocalImagePickerCubit>()
                                          .state
                                          .localImageFiles ??
                                      [],
                                  userId: userId.toString(),
                                ),
                              );
                        } else {
                          showToast(StringConstants.pleaseSelectOneImage);
                        }
                      },
                      label: Row(children: [
                        Text(
                          StringConstants.post,
                          style: TextStyles.bodyLarge
                              .copyWith(color: Colors.white, letterSpacing: 0),
                        ),
                        10.horizontalSpace,
                        SvgPicture.asset(
                          Assets.send,
                          color: Colors.white,
                          width: 18.r,
                        )
                      ]),
                    )),
        );
      }),
    );
  }

  void showDiscoverPostBottomSheet(BuildContext context) {
    _nav(ImageSource source) async {
      Navigator.pop(context);
      if (source == ImageSource.camera) {
        await context.read<LocalImagePickerCubit>().onPicImageReturn(
              ImageSource.camera,
            );
      } else {
        await context.read<LocalImagePickerCubit>().onPickMultipleImages();
      }
    }

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
