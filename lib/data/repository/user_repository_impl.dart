import 'package:dio/dio.dart';
import 'package:suitmedia_test/domain/model/user_model.dart';
import 'package:suitmedia_test/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio _dio;

  UserRepositoryImpl(this._dio);

  @override
  Future<List<UserModel>> getUsers(int? page, int? perPage) async {
    try {
      final res = await _dio
          .get("/users", queryParameters: {"page": page, "per_page": perPage});
      final data = res.data['data'] as List;
      final listUser = data
          .map<UserModel>((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return listUser;
    } catch (e) {
      rethrow;
    }
  }
}
