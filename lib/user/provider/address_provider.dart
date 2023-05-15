import 'package:flutter_giraffe_app/user/model/address_model.dart';
import 'package:flutter_giraffe_app/user/model/address_params.dart';
import 'package:flutter_giraffe_app/user/repository/address_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addressProvider =
    StateNotifierProvider<AddressStateNotifier, AddressResult?>(
  (ref) {
    return AddressStateNotifier(ref: ref);
  },
);

// state == null : keyword 입력 시 아무것도 안 넣은 상태.
// state 갯수가 0 인 상태는 해당 하는 주소가 없는 상태.
class AddressStateNotifier extends StateNotifier<AddressResult?> {
  final Ref ref;

  AddressStateNotifier({
    required this.ref,
  }) : super(null);

  Future<void> getAddress({required String? keyword}) async {
    if (keyword == null) {
      state = null;
      return;
    }

    final params =
        ref.read(addressParamsProvider).changeKeyword(keyword: keyword);
    final result = await ref.read(addressRepositoryProvider).getAddress(params);

    state = result.results;
  }
}
