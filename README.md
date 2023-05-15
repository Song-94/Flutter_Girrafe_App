# flutter_giraffe_app

create by song.

## Note.

1. 텍스트에 노란색 밑줄이 생기는 이유

- https://terry1213.github.io/flutter/flutter-decoding-flutter-yellow-underline-text/#:~:text=%EC%9B%90%EC%9D%B8%EC%9D%84%20%EC%95%8C%EA%B3%A0%20%EB%82%98%EB%8B%88%20%ED%95%B4%EA%B2%B0,%EC%8A%A4%ED%83%80%EC%9D%BC%EC%9D%84%20%EC%A7%80%EC%A0%95%ED%95%B4%EC%A3%BC%EB%A9%B4%20%EB%90%9C%EB%8B%A4

2. Constraints

- https://velog.io/@fepanbr/Flutter-Constraints-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0

3. Material UI Icon: Google Style Icons

- https://fonts.google.com/icons?selected=Material+Icons

4. Cuppertino Icon:  Apple Style Icons

- https://pub.dev/packages/cupertino_icons

# Resolve System Errors

## TextInputClient.performPrivateCommand: Null check operator used on a null value

- The following _CastError was thrown during method call TextInputClient.performPrivateCommand: Null
  check operator used on a null value

- Resolve In flutter\lib\src\widgets\editable_text.dart, if I change
  EditableTextState.performPrivateCommand to

- https://github.com/flutter/flutter/issues/112046

<pre>
<code>
  @override
    void performPrivateCommand(String action, Map<String, dynamic> data) {
    if (widget.onAppPrivateCommand != null) widget.onAppPrivateCommand!(action, data);
  }
</code>
</pre>

5. DioError (DioErrorType.other):
   type 'String' is not a subtype of type 'Map<String, dynamic>?' in type cast

- https://dokit.tistory.com/15

6. JsonSerializable 주의 사항

- 모델 인자는 무조건 스트링을 하던지, 아니면 JsonKey 로 변환해서 넣던지
- baseUrl 의 끝은 항상 '/' 로 끝나야 한다.

<pre>
<code>
@JsonSerializable()
class JsonObject extends Object {
  @JsonKey(fromJson: _stringToInt, toJson: _stringFromInt)
  final int number;

  JsonObject(this.number);

  factory JsonObject.fromJson(Map<String, dynamic> json) => _$JsonObjectFromJson(json);

  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();
}
</code>
</pre>

7. Different ways to print an object in Dart and Flutter
- https://www.cloudhadoop.com/dart-print-object/

8. Press Button, Remove Animate effects.
- Colors.transparent
- https://codewithandrea.com/tips/disable-widget-splash-effect-flutter/

9. reverse-geocoding
- https://pub.dev/packages/geocoding