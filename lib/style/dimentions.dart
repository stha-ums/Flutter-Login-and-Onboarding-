import 'package:flutter/cupertino.dart';

class Dimensions {
  static MediaQueryData _mediaQueryData;
  static double screenHeight;
  static double screenWidth;

  static double blockHeight;
  static double blockWidth;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;

  static double safeAreaHeight;
  static double safeAreaWidth;

  static double safeBlockHeight;
  static double safeBlockWidth;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    blockHeight = screenHeight / 200;
    blockWidth = screenWidth / 200;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    safeAreaHeight = screenHeight - _safeAreaVertical;
    safeAreaWidth = screenWidth - _safeAreaHorizontal;

    safeBlockHeight = (safeAreaHeight) / 200;
    safeBlockWidth = (safeAreaWidth) / 200;

    print(safeBlockHeight);
  }
}
