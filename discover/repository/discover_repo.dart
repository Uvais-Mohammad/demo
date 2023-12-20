import 'package:dio/dio.dart';
import 'package:http_util_package/http_util.dart';
import 'package:sf_chat_im/features/discover/models/add_discover_parameter.dart';
import 'package:sf_chat_im/features/discover/models/discover_comment.dart';
import 'package:sf_chat_im/features/discover/models/discover_list_response.dart';
import 'package:sf_chat_im/features/discover/repository/i_discover_repo.dart';
import 'package:sf_chat_im/features/splash/repository/i_splash_repo.dart';
import 'package:sf_chat_im/shared/api/app_urls.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/models/image_upload_response.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:sf_chat_im/shared/utilities/extensions.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';

final class DiscoverRepository implements IDiscoverRepository {
  final _appUrls = locator<AppUrls>();
  final http = HttpUtil();

  @override
  Future<DiscoverListResponse?> getDiscoverList({
    int? userId,
    String? messageId,
    int? pageSize,
    int? pageIndex,
    int? userType,
  }) async {
    final url = _appUrls.discoverList;
    try {
      final response = await http.postData(
        url,
        data: {}
          ..addIfNotNull('userId', userId)
          ..addIfNotNull('messageId', messageId)
          ..addIfNotNull('pageSize', pageSize)
          ..addIfNotNull('pageIndex', pageIndex)
          ..addIfNotNull('userType', userType)
          ..addAll(defaultParameterMap(url)),
        contentType: Headers.formUrlEncodedContentType,
      );
      return DiscoverListResponse.fromJson(response.responseBody);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<DiscoverData?> getDiscoverSingleItem({
    String? messageId,
  }) async {
    final url = _appUrls.discoverSingleItem;
    try {
      final response = await http.postData(
        url,
        data: {}
          ..addIfNotNull('messageId', messageId)
          ..addAll(defaultParameterMap(url)),
        contentType: Headers.formUrlEncodedContentType,
      );
      return DiscoverData.fromJson(response.responseBody['data']);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<DiscoverComment?> getCommentList({
    String? messageId,
  }) async {
    final url = _appUrls.commentList;
    try {
      final response = await http.postData(
        url,
        data: {}
          ..addIfNotNull('messageId', messageId)
          ..addAll(defaultParameterMap(url)),
        contentType: Headers.formUrlEncodedContentType,
      );
      return DiscoverComment.fromJson(response.responseBody);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ApiResponse> postText(
      {required DiscoverParameter discoverParameter}) async {
    final url = _appUrls.addDiscover;
    try {
      final response = await http.postData(
        url,
        data: discoverParameter.toJson()..addAll(defaultParameterMap(url)),
        contentType: Headers.formUrlEncodedContentType,
      );
      return ApiResponse(
        response.statusCode,
        response.responseBody['resultCode'] == 1,
        response.responseBody,
        response.responseBody['resultMsg'] ?? StringConstants.failedToLoadData,
      );
    } catch (e) {
      return ApiResponse(500, false, null, StringConstants.failedToLoadData);
    }
  }

  @override
  Future<ImageUploadResponse?> uploadImage({
    required String userId,
    required List<String> images,
  }) async {
    try {
      final uploadUrl = await locator<ISplashRepository>()
          .getConfigFromLocal()
          .then((value) => value?.data?.uploadUrl);
      final response = await HttpUtil().uploadFile(
        _appUrls.uploadMediaUrl(uploadUrl!),
        images,
        {'validTime': "-1", 'userId': userId},
      );
      if (response.isSuccess) {
        return ImageUploadResponse.fromJson(response.responseBody);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ImageUploadResponse?> uploadCoverImage({required String image}) async {
    try {
      final uploadUrl = await locator<ISplashRepository>()
          .getConfigFromLocal()
          .then((value) => value?.data?.uploadUrl);
      final response = await HttpUtil().uploadFile(
        _appUrls.uploadMediaUrl(uploadUrl!),
        [image],
        {'validTime': "-1"},
      );
      if (response.isSuccess) {
        return ImageUploadResponse.fromJson(response.responseBody);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ApiResponse> postImage(
      {required DiscoverParameter discoverParameter}) async {
    final url = _appUrls.addDiscover;
    try {
      final response = await http.postData(
        url,
        data: discoverParameter.toJson()..addAll(defaultParameterMap(url)),
        contentType: Headers.formUrlEncodedContentType,
      );
      return ApiResponse(
        response.statusCode,
        response.responseBody['resultCode'] == 1,
        response.responseBody,
        response.responseBody['resultMsg'] ?? StringConstants.failedToLoadData,
      );
    } catch (e) {
      return ApiResponse(500, false, null, StringConstants.failedToLoadData);
    }
  }

  @override
  Future<ApiResponse> updateCoverImage(String image) async {
    final url = _appUrls.updateProfile;
    try {
      final response = await http.postData(
        url,
        data: {'msgBackGroundUrl': image}..addAll(defaultParameterMap(url)),
        contentType: Headers.formUrlEncodedContentType,
      );
      return ApiResponse(
        response.statusCode,
        response.responseBody['resultCode'] == 1,
        response.responseBody,
        response.responseBody['resultMsg'] ?? StringConstants.failedToLoadData,
      );
    } catch (e) {
      return ApiResponse(500, false, null, StringConstants.failedToLoadData);
    }
  }

  @override
  Future<ApiResponse> like(String messageId) async {
    final url = _appUrls.like;
    try {
      final response = await http.postData(
        url,
        data: {'messageId': messageId}..addAll(defaultParameterMap(url)),
        contentType: Headers.formUrlEncodedContentType,
      );
      return ApiResponse(
        response.statusCode,
        response.responseBody['resultCode'] == 1,
        response.responseBody,
        response.responseBody['resultMsg'] ?? StringConstants.failedToLoadData,
      );
    } catch (e) {
      return ApiResponse(500, false, null, StringConstants.failedToLoadData);
    }
  }

  @override
  Future<ApiResponse> unlike(String messageId) async {
    final url = _appUrls.unlike;
    try {
      final response = await http.postData(
        url,
        data: {'messageId': messageId}..addAll(defaultParameterMap(url)),
        contentType: Headers.formUrlEncodedContentType,
      );
      return ApiResponse(
        response.statusCode,
        response.responseBody['resultCode'] == 1,
        response.responseBody,
        response.responseBody['resultMsg'] ?? StringConstants.failedToLoadData,
      );
    } catch (e) {
      return ApiResponse(500, false, null, StringConstants.failedToLoadData);
    }
  }

  @override
  Future<ApiResponse> addComment({
    required String messageId,
    required String body,
  }) async {
    final url = _appUrls.addComment;
    try {
      final response = await http.postData(
        url,
        data: {'messageId': messageId, 'body': body}
          ..addAll(defaultParameterMap(url)),
        contentType: Headers.formUrlEncodedContentType,
      );
      return ApiResponse(
        response.statusCode,
        response.responseBody['resultCode'] == 1,
        response.responseBody,
        response.responseBody['resultMsg'] ?? StringConstants.failedToLoadData,
      );
    } catch (e) {
      return ApiResponse(500, false, null, StringConstants.failedToLoadData);
    }
  }

  @override
  Future<ApiResponse> deleteComment(
      {required String commentId, required String messageId}) async {
    final url = _appUrls.deleteComment;
    try {
      final response = await http.postData(
        url,
        data: {
          'commentId': commentId,
          'messageId': messageId,
          'pageSize': 10 * 10
        }..addAll(defaultParameterMap(url)),
        contentType: Headers.formUrlEncodedContentType,
      );
      return ApiResponse(
        response.statusCode,
        response.responseBody['resultCode'] == 1,
        response.responseBody,
        response.responseBody['resultMsg'] ?? StringConstants.failedToLoadData,
      );
    } catch (e) {
      return ApiResponse(500, false, null, StringConstants.failedToLoadData);
    }
  }

  @override
  Future<ApiResponse> delete({required String messageId}) async {
    final url = _appUrls.deleteDiscover;
    try {
      final response = await http.postData(
        url,
        data: {'messageId': messageId}..addAll(defaultParameterMap(url)),
        contentType: Headers.formUrlEncodedContentType,
      );
      return ApiResponse(
        response.statusCode,
        response.responseBody['resultCode'] == 1,
        response.responseBody,
        response.responseBody['resultMsg'] ?? StringConstants.failedToLoadData,
      );
    } catch (e) {
      return ApiResponse(500, false, null, StringConstants.failedToLoadData);
    }
  }
}
