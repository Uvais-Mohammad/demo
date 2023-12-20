import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sf_chat_im/features/discover/models/discover_list_response.dart';

class DiscoverImageViewer extends StatelessWidget {
  DiscoverImageViewer({
    this.localImage,
    this.images,
    this.index,
    super.key,
  });

  final String? localImage;
  final int? index;
  final List<Images>? images;

  final ValueNotifier<int> itemNumber = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: ColoredBox(
          color: Colors.black,
          child: Stack(
            children: [
              PageView.builder(
                controller: PageController(initialPage: index ?? 0),
                itemCount: images?.length ?? 0,
                onPageChanged: (v) {
                  itemNumber.value = v;
                },
                itemBuilder: (context, index) {
                  return Hero(
                      tag: images?[index].tUrl ?? '',
                      child: localImage != null
                          ? PhotoView(
                              loadingBuilder: (ctx, chunk) {
                                return Container();
                              },
                              imageProvider: FileImage(
                                  File(images?[index].localImage ?? '')),
                              minScale: PhotoViewComputedScale.contained,
                            )
                          : PhotoView(
                              loadingBuilder: (ctx, chunk) {
                                return PhotoView(
                                  loadingBuilder: (ctx, chunk) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    );
                                  },
                                  imageProvider: CachedNetworkImageProvider(
                                      images?[index].tUrl ?? ''),
                                  minScale: PhotoViewComputedScale.contained,
                                );
                              },
                              imageProvider: CachedNetworkImageProvider(
                                  images?[index].oUrl ?? ''),
                              minScale: PhotoViewComputedScale.contained,
                            ));
                },
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 42.r,
                        width: 42.r,
                        padding:
                            EdgeInsets.only(left: Platform.isIOS ? 4.r : 0),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: BackButton(
                          color: Colors.white,
                        ),
                      ),
                      // ValueListenableBuilder<int>(
                      //     valueListenable: itemNumber,
                      //     builder: (context, value, child) {
                      //       return CommonIconButton(
                      //         size: 42.r,
                      //         padding: const EdgeInsets.all(10).r,
                      //         iconColor: Colors.white,
                      //         color: Colors.black26,
                      //         onPressed: () {
                      //           GallerySaver.saveImage(
                      //                   images?[value].tUrl ?? '')
                      //               .then((bool? success) {
                      //             if (success ?? false) {
                      //               if (Platform.isIOS) {
                      //                 showToast(StringConstants.savedToPhotos);
                      //               } else {
                      //                 showToast(StringConstants.savedToGallery);
                      //               }
                      //             }
                      //           });
                      //         },
                      //         icon: 'assets/svg/download_icon.svg',
                      //       );
                      //     }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
