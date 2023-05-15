import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_giraffe_app/user/function/phone_number_formatter.dart';

class LoginForm extends StatefulWidget {
  final Function(String id) loginDone;

  const LoginForm({
    required this.loginDone,
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _numberEditingController = TextEditingController(text: '010-1234-5678');
  final _verifyEditingController = TextEditingController();

  final _verificationStatus =
      ValueNotifier<VerificationStatus>(VerificationStatus.none);

  @override
  void dispose() {
    _numberEditingController.dispose();
    _verifyEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const animatedDuration = Duration(milliseconds: 300);

    return ValueListenableBuilder(
      valueListenable: _verificationStatus,
      builder: (context, value, child) {
        print('_verificationStatus change : ${value.name}');

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
                          if (_verificationStatus.value ==
                              VerificationStatus.none) {
                            if (val.length == 12) {
                              _verificationStatus.value =
                                  VerificationStatus.none;
                            }
                            if (val.length > 12) {
                              _verificationStatus.value =
                                  VerificationStatus.ready;
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed:
                        (_verificationStatus.value == VerificationStatus.ready)
                            ? () {
                                _verificationStatus.value =
                                    VerificationStatus.codeSent;
                              }
                            : null,
                    child: const Text(
                      '발송',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              duration: animatedDuration,
              opacity: (_verificationStatus.value == VerificationStatus.none) ||
                      (_verificationStatus.value == VerificationStatus.ready)
                  ? 0
                  : 1,
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
                    IgnorePointer(
                      ignoring: (_verificationStatus.value ==
                          VerificationStatus.verifying),
                      child: ElevatedButton(
                        onPressed: () async {
                          await attemptVerify();
                        },
                        child: (_verificationStatus.value ==
                                VerificationStatus.verifying)
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : const Text(
                                '인증',
                                textAlign: TextAlign.center,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> attemptVerify() async {
    _verificationStatus.value = VerificationStatus.verifying;

    print('delay');
    await Future.delayed(const Duration(seconds: 3));
    print('delay done');

    widget.loginDone(_numberEditingController.text);

    _verificationStatus.value = VerificationStatus.verificationDone;
  }
}

// 검증상태 관리
enum VerificationStatus { none, ready, codeSent, verifying, verificationDone }
