import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_giraffe_app/user/function/phone_number_formatter.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _numberEditingController = TextEditingController();
  final _verifyEditingController = TextEditingController();
  final _numberNotifierButton = ValueNotifier<bool>(false);
  VerificationStatus _verificationStatus = VerificationStatus.none;

  @override
  void dispose() {
    _numberEditingController.dispose();
    _verifyEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    controller: _numberEditingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      // only number.
                      PhoneNumberFormatter(),
                      LengthLimitingTextInputFormatter(13),
                    ],
                    decoration: const InputDecoration(
                      hintText: '전화번호를 기입해주세요.',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                    onChanged: (val) {
                      if (_verificationStatus == VerificationStatus.none) {
                        if (val.length == 12) {
                          _numberNotifierButton.value = false;
                        }
                        if (val.length > 12) {
                          _numberNotifierButton.value = true;
                        }
                      }
                    },
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _numberNotifierButton,
                builder: (BuildContext context, value, child) {
                  print('ValueListenableBuilder change : '
                      '${_numberEditingController.text.length}');
                  return ElevatedButton(
                    onPressed: (value &&
                            _verificationStatus == VerificationStatus.none)
                        ? () {
                            setState(
                              () {
                                _verificationStatus =
                                    VerificationStatus.codeSent;
                              },
                            );
                          }
                        : null,
                    child: const Text(
                      '발송',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _verificationStatus == VerificationStatus.none ? 0 : 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextFormField(
                      controller: _verifyEditingController,
                      decoration: const InputDecoration(
                        hintText: '인증코드를 기입해주세요.',
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    '인증',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// 검증상태 관리
enum VerificationStatus { none, codeSent, verifying, verificationDone }
