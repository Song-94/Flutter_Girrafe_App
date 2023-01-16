import 'package:flutter/material.dart';
import 'package:flutter_giraffe_app/common/colors/colors.dart';
import 'package:flutter_giraffe_app/common/layout/default_layout.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressScreen extends StatelessWidget {
  static String get routeName => 'address';

  const AddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.search,
                    color: Color(GREEN_MAIN),
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 24,
                  minHeight: 24,
                ),
                enabledBorder: UnderlineInputBorder(),
                // focusedErrorBorder: UnderlineInputBorder(),
                hintText: '도로명으로 검색하세요.',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              icon: const Icon(Icons.explore_outlined),
              label: const Text('현재 위치로 찾기'),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SvgPicture.asset(
                    'assets/common/address_leading.svg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.fill,
                  ),
                  title: Text('title : $index'),
                  subtitle: Text('subtitle : $index'),
                  trailing: const Icon(Icons.done),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
