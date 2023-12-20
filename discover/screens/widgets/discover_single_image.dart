import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sf_chat_im/features/discover/models/discover_list_response.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/discovery_image_viewer.dart';

class DiscoverSingleImage extends StatelessWidget {
  const DiscoverSingleImage({
    super.key,
    required this.index,
    required this.images,
    required this.size,
  });

  final int index;
  final List<Images> images;
  final double size;

  @override
  Widget build(BuildContext context) {
    final thumbImage = images[index].tUrl ?? '';
    final localImage = images[index].localImage;

    return GestureDetector(
      onTap: () {
        Navigator.push<dynamic>(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => DiscoverImageViewer(
                images: images, localImage: localImage, index: index),
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
        );
      },
      child: localImage != null
          ? Padding(
              padding: EdgeInsets.only(right: 2).r,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6.r)),
                width: size,
                height: size,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: Image.file(
                    File(localImage),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: Colors.black.withOpacity(0.05)),
                        width: size,
                        height: size,
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
                      );
                    },
                  ),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(right: 2).r,
              child: CachedNetworkImage(
                fadeInDuration: Duration(milliseconds: 0),
                fadeOutDuration: Duration(milliseconds: 0),
                imageBuilder: (context, imageProvider) {
                  return Hero(
                    tag: thumbImage,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r)),
                      width: size,
                      height: size,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        color: Colors.black.withOpacity(0.05)),
                    width: size,
                    height: size,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.grey),
                            backgroundColor: Colors.white,
                            strokeWidth: 1,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                fit: BoxFit.cover,
                imageUrl: thumbImage,
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: Colors.black.withOpacity(0.05)),
                  width: size,
                  height: size,
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
            ),
    );
  }
}
