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