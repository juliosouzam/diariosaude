import 'package:diariosaude/themes/colors/theme_colors.dart';
import 'package:flutter/material.dart';

class Helpers {
  static Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: ThemeColors.foreignground,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }
}
