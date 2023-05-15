import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressForm {
  final AddressResult results;

  AddressForm({
    required this.results,
  });

  factory AddressForm.fromJson(Map<String, dynamic> json) =>
      _$AddressFormFromJson(json);
}

@JsonSerializable()
class AddressResult {
  final AddressCommon common;
  final List<AddressJuso> juso;

  AddressResult({
    required this.common,
    required this.juso,
  });

  factory AddressResult.fromJson(Map<String, dynamic> json) =>
      _$AddressResultFromJson(json);
}

@JsonSerializable()
class AddressCommon {
  final String errorMessage;
  final String countPerPage;
  final String totalCount;
  final String errorCode;
  final String currentPage;

  AddressCommon({
    required this.errorMessage,
    required this.countPerPage,
    required this.totalCount,
    required this.errorCode,
    required this.currentPage,
  });

  factory AddressCommon.fromJson(Map<String, dynamic> json) =>
      _$AddressCommonFromJson(json);
}

@JsonSerializable()
class AddressJuso {
  final String detBdNmList;
  final String engAddr;
  final String rn;
  final String emdNm;
  final String zipNo;
  final String roadAddrPart2;
  final String emdNo;
  final String sggNm;
  final String jibunAddr;
  final String siNm;
  final String roadAddrPart1;
  final String bdNm;
  final String admCd;
  final String udrtYn;
  final String lnbrMnnm;
  final String roadAddr;
  final String lnbrSlno;
  final String buldMnnm;
  final String bdKdcd;
  final String liNm;
  final String rnMgtSn;
  final String mtYn;
  final String bdMgtSn;
  final String buldSlno;

  AddressJuso({
    required this.detBdNmList,
    required this.engAddr,
    required this.rn,
    required this.emdNm,
    required this.zipNo,
    required this.roadAddrPart2,
    required this.emdNo,
    required this.sggNm,
    required this.jibunAddr,
    required this.siNm,
    required this.roadAddrPart1,
    required this.bdNm,
    required this.admCd,
    required this.udrtYn,
    required this.lnbrMnnm,
    required this.roadAddr,
    required this.lnbrSlno,
    required this.buldMnnm,
    required this.bdKdcd,
    required this.liNm,
    required this.rnMgtSn,
    required this.mtYn,
    required this.bdMgtSn,
    required this.buldSlno,
  });

  factory AddressJuso.fromJson(Map<String, dynamic> json) =>
      _$AddressJusoFromJson(json);
}
