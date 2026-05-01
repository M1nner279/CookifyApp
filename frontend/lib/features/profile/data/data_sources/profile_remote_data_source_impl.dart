import 'package:cookify/features/profile/data/consts/profile_end_points.dart';
import 'package:cookify/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:cookify/features/profile/data/models/user_model.dart';
import 'package:cookify/features/profile/data/requests/update_avatar_request.dart';
import 'package:dio/dio.dart';

final class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<UserModel> getUser() async {
    final response = await _dio.get(getUserEndPoint);

    return UserModel.fromJson(response.data);
  }

  @override
  Future<String> updateAvatar(UpdateAvatarRequest request) async {
    final fileName = request.avatarFile.path.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        request.avatarFile.path,
        filename: fileName,
      ),
    });
    final response = await _dio.post(updateAvatarEndPoint, data: formData);

    return response.data;
  }
}
