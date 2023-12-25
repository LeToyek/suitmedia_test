import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_test/data/repository/user_repository_impl.dart';
import 'package:suitmedia_test/domain/model/user_model.dart';
import 'package:suitmedia_test/domain/service/dio_provider.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers(int? page, int? perPage);
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref.watch(dioProvider));
});
