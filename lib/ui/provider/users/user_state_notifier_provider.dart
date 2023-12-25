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

  Future<void> getUsers() async {
    try {
      final users = await _userRepository.getUsers(_page, 10);
      state = AsyncValue.data(users);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<bool> loadMore() async {
    try {
      _page++;
      final users = await _userRepository.getUsers(_page, 10);
      if (users.isEmpty) {
        return false;
      }
      state = AsyncValue.data([...state.value!, ...users]);
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _page = 1;
  }
}
