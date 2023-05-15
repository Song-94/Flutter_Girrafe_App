import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_giraffe_app/user/model/address_params.dart';
import 'package:flutter_giraffe_app/user/repository/address_repository.dart';
import 'package:logger/logger.dart';
import 'package:geocoding/geocoding.dart';

void main() async {
  // await testAddressApi2();
  // await testAddressApi();
  await testAddressApi3();
}

Future testAddressApi() async {
  final logger = Logger();

  await dotenv.load(fileName: "env/.api_env");

  final dio = Dio();
  final repository = AddressRepository(dio);
  final String? confmKey = dotenv.maybeGet('ADDRESS_API_KEY', fallback: null);

  final addressParams = AddressParams(
    confmKey: confmKey ?? '',
    keyword: '강남대로12길',
  );

  print(addressParams.toJson());

  final result = await repository.getAddress(addressParams);

  print(result.results.juso.length);
}

Future testAddressApi2() async {
  final logger = Logger();

  String url =
      "https://business.juso.go.kr/addrlink/addrLinkApi.do?resultType=json&currentPage=1&countPerPage=10&confmKey=devU01TX0FVVEgyMDIzMDExOTE3MjYyOTExMzQ0NjU=&keyword=강남대로12길";
  final dio = Dio();
  Response response = await dio.get(url);

  logger.d(response.data);
}

// TwoSomePlace
// LocationData<lat: 37.3694071, long: 126.8110425>

Future<void> testAddressApi3() async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(37.3694071, 126.8110425);

  print(placemarks);
}
