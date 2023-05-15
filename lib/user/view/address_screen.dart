import 'package:flutter/material.dart';
import 'package:flutter_giraffe_app/common/colors/colors.dart';
import 'package:flutter_giraffe_app/common/layout/default_layout.dart';
import 'package:flutter_giraffe_app/user/model/address_model.dart';
import 'package:flutter_giraffe_app/user/provider/address_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AddressScreen extends ConsumerStatefulWidget {
  static String get routeName => 'address';

  const AddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddressScreen> {
  final _addressEditingController = TextEditingController();

  int _selectedIndex = 0;

  @override
  void dispose() {
    _addressEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddressResult? res = ref.watch(addressProvider);

    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _addressEditingController,
              style: const TextStyle(fontSize: 20.0),
              cursorColor: const Color(GREEN_ACCENT),
              onEditingComplete: () async {
                await submitKeyword(_addressEditingController.text);
              },
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(),
                hintText: '주소를 입력하세요.',
                hintStyle: const TextStyle(color: Colors.grey),
                isDense: true,
                suffixIcon: IconButton(
                  color: const Color(GREEN_ACCENT),
                  onPressed: () async {
                    await submitKeyword(_addressEditingController.text);
                  },
                  icon: const Icon(
                    Icons.search_outlined,
                    size: 30,
                  ),
                  splashColor: Colors.transparent,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton.icon(
              onPressed: () async {
                // await testAddressApi3();
                await _checkPermission();
                Position location = await Geolocator.getCurrentPosition();
                print(location);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              icon: const Icon(Icons.explore_outlined),
              label: const Text('현재 위치로 찾기'),
            ),
            const SizedBox(height: 16),
            Expanded(
              // 3가지의 경우
              // 1. 결과 안에 주소가 존재
              // 2. 결과 안에 주소가 없음
              // 3. keyword 가 null 일 때.
              child: (res != null)
                  ? // 1. 결과 안에 주소가 존재.
                  (res.juso.isNotEmpty)
                      ? ListView.builder(
                          itemCount: res!.juso.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(res.juso[index].jibunAddr),
                              subtitle: Text(res.juso[index].roadAddr),
                              selectedColor: const Color(GREEN_ACCENT),
                              selected: (index == _selectedIndex),
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                            );
                          },
                        )
                      : // 2. 결과 안에 주소가 없음.
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(height: 32.0),
                            Text(
                              '주소를 다시 입력해주세요.',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        )
                  :
                  // 3. keyword 가 null 일 때.
                  Container(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitKeyword(String keyword) async {
    if (keyword.length < 2) {
      await ref.read(addressProvider.notifier).getAddress(keyword: null);
    } else {
      await ref.read(addressProvider.notifier).getAddress(keyword: keyword);
    }
  }

  Future<String> _checkPermission() async {
    // 휴대폰 위치 권한 유/무 확인
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요.';
    }

    // 앱의 위치 서비스에 대한 권한
    // denied : 맨 처음 앱을 켰을 때의 기본 값 : Geolocator.requestPermission() 요청 해야함.
    // deniedForever : 이 앱에서 절대적으로 권한 요청이 불가
    // whileInUse : 앱 실행 중에만 권한 허용
    // always : 항상 허용
    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }

    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅에서 허가해주세요.';
    }

    return '위치 권한을 허가되었습니다.';
  }

  Future<void> testAddressApi3() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(37.3694071, 126.8110425);

    print(placemarks);
  }
}
