import 'dart:math';

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Color get randomColor => Colors.primaries[Random().nextInt(17)];

  Container get randomColorContainer =>
      Container(height: 20, width: double.infinity, color: randomColor);

  Size get kSize => MediaQuery.of(this).size;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  ThemeData get themeData => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;
}

extension NavigationExtension on BuildContext {
  NavigatorState get navigation => Navigator.of(this);

  Future<void> pop() async {
    await navigation.maybePop();
  }

  Future<Object?> push(Widget widget) async {
    return navigation.push(MaterialPageRoute(builder: (context) => widget));
  }

  Future<void> pushAndRemoveUntil(Widget widget) async {
    await navigation.pushAndRemoveUntil(
      MaterialPageRoute<Widget>(
        builder: (context) => widget,
        maintainState: false,
      ),
      (Route<dynamic> route) => false,
    );
  }
}

extension SnackBarExtension on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}
