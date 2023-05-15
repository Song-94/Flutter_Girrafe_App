import 'package:flutter_giraffe_app/user/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserStateNotifier, UserModelBase?>(
  (ref) {
    return UserStateNotifier();
  },
);

class UserStateNotifier extends StateNotifier<UserModelBase?> {
  UserStateNotifier() : super(UserModelLoading()) {
    getLoginInfo();
  }

  String id = '';

  void getLoginInfo() {
    state = null;
  }

  void login({
    required String id,
  }) {
    state = UserModel(
      id: id,
    );
  }

  void logout() {
    state = null;
  }
}
