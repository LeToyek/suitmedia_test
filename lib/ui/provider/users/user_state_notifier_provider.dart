import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_test/domain/model/user_model.dart';
import 'package:suitmedia_test/domain/repository/user_repository.dart';

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<List<UserModel>>>((ref) {
  return UserNotifier(ref.watch(userRepositoryProvider))..getUsers();
});

class UserNotifier extends StateNotifier<AsyncValue<List<UserModel>>> {
  final UserRepository _userRepository;
  UserNotifier(this._userRepository)
      : super(
          const AsyncValue.loading(),
        );

  int _page = 1;
  bool isExist = true;

  Future<void> getUsers() async {
    try {
      final users = await _userRepository.getUsers(_page, 10);
      state = AsyncValue.data(users);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loadMore() async {
    try {
      _page++;
      final res = await _userRepository.getUsers(_page, 10);
      isExist = res.isNotEmpty;
      state = AsyncValue.data([...state.value!, ...res]);
    } on DioException catch (e) {
      String message = "";
      switch (e.type) {
        case DioExceptionType.connectionError:
          message = "No Internet Connection";
          break;
        default:
          message = "Something went wrong";
      }
      state = AsyncValue.error(message, StackTrace.current);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _page = 1;
  }
}
