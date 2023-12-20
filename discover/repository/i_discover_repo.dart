import 'package:http_util_package/models/api_response_model.dart';
import 'package:sf_chat_im/features/discover/models/add_discover_parameter.dart';
import 'package:sf_chat_im/features/discover/models/discover_comment.dart';
import 'package:sf_chat_im/features/discover/models/discover_list_response.dart';
import 'package:sf_chat_im/shared/models/image_upload_response.dart';

abstract interface class IDiscoverRepository {
  Future<DiscoverListResponse?> getDiscoverList({
    int? userId,
    String? messageId,
    int? pageSize,
    int? pageIndex,
    int? userType,
  });
  Future<ApiResponse> delete({required String messageId});
  Future<DiscoverData?> getDiscoverSingleItem({required String messageId});
  Future<DiscoverComment?> getCommentList({required String messageId});
  Future<ApiResponse> postText({required DiscoverParameter discoverParameter});
  Future<ApiResponse> postImage({required DiscoverParameter discoverParameter});
  Future<ImageUploadResponse?> uploadImage(
      {required String userId, required List<String> images});
  Future<ImageUploadResponse?> uploadCoverImage({required String image});

  Future<ApiResponse> updateCoverImage(String image);
  Future<ApiResponse> like(String messageId);
  Future<ApiResponse> unlike(String messageId);
  Future<ApiResponse> addComment({
    required String messageId,
    required String body,
  });
  Future<ApiResponse> deleteComment({
    required String commentId,
    required String messageId,
  });
}
