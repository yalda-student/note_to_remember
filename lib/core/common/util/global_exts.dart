import 'package:flutter/material.dart';

extension BuildContextExts on BuildContext {
  bool screenIsHorizontal() {
    if (MediaQuery.of(this).size.width < MediaQuery.of(this).size.height) {
      //use horizontal |
      return true;
    } else {
      //use vertical __
      return false;
    }
  }

  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;
}

extension StringExts on String {
  bool isLanguageRtl() {
    return this == (const Locale('fa', 'IR').languageCode);
  }
}
