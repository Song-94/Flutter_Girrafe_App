import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_params.g.dart';

final addressParamsProvider = Provider<AddressParams>(
  (ref) {
    final String? confmKey = dotenv.maybeGet('ADDRESS_API_KEY', fallback: null);
    return AddressParams(confmKey: confmKey);
  },
);

@JsonSerializable()
class AddressParams {
  final String resultType;
  final int currentPage;
  final int countPerPage;

  final String? hstryYn;
  final String? firstSort;
  final String? addInfoYn;

  final String? keyword;
  final String? confmKey;

  const AddressParams({
    this.resultType = 'json',
    this.currentPage = 1,
    this.countPerPage = 10,
    this.hstryYn,
    this.firstSort,
    this.addInfoYn,
    this.keyword,
    required this.confmKey,
  });

  AddressParams changeKeyword({required String? keyword}) {
    return AddressParams(confmKey: confmKey, keyword: keyword);
  }

  Map<String, dynamic> toJson() => _$AddressParamsToJson(this);
}
