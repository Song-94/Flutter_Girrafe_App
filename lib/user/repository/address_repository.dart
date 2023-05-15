import 'package:dio/dio.dart' hide Headers;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flutter_giraffe_app/common/dio/dio.dart';
import 'package:flutter_giraffe_app/user/model/address_model.dart';
import 'package:flutter_giraffe_app/user/model/address_params.dart';

part 'address_repository.g.dart';

// sample
// https://business.juso.go.kr/addrlink/ addrLinkApi.do?
// currentPage=1&countPerPage=10&keyword=강남대로12길&confmKey=TESTJUSOGOKR&resultType=json

// final String? confmKey = dotenv.maybeGet('ADDRESS_API_KEY', fallback: null);

final addressRepositoryProvider = Provider<AddressRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository = AddressRepository(dio);

    return repository;
  },
);

@RestApi(baseUrl: 'https://business.juso.go.kr/addrlink/')
abstract class AddressRepository {
  factory AddressRepository(Dio dio, {String baseUrl}) = _AddressRepository;

  @GET('addrLinkApi.do')
  @Headers(
    <String, dynamic>{
      'content-type': 'application/json',
    },
  )
  Future<AddressForm> getAddress(
    @Queries() AddressParams addressParams,
  );
}
