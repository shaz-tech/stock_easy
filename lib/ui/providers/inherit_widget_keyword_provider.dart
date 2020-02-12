import 'package:flutter/material.dart';

class KeywordProvider extends InheritedWidget {
  final String keyword;

  const KeywordProvider({
    Key key,
    @required Widget child,
    @required this.keyword,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(KeywordProvider old) {
    return old.keyword != keyword;
  }

  static KeywordProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<KeywordProvider>();
  }
}
