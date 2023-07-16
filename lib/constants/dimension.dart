import 'package:flutter/cupertino.dart';

class Dimension {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? leftMargin;
  static double? rightMargin;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData!.size.height;
    screenWidth = _mediaQueryData!.size.width;
    leftMargin = _mediaQueryData!.size.width / 4;
    rightMargin = _mediaQueryData!.size.width / 4;
  }
}
