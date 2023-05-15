// 아무것도 없을 때.
abstract class UserModelBase {}

// 로그인 중.
class UserModelLoading extends UserModelBase {}

// 로그인 에러.
class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

// 로그인 된 상태.
class UserModel extends UserModelBase {
  final String id;

  UserModel({
    required this.id,
  });
}
