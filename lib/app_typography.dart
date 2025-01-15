import 'package:flutter/material.dart';

final fonts = AppTypography();
const fontFamilyMontseratt = "Montserrat";

TextStyle _defaultFont = const TextStyle(
  height: 1.25,
  fontFamily: fontFamilyMontseratt,
  fontWeight: FontWeight.w400,
  leadingDistribution: TextLeadingDistribution.even,
);

class AppTypography {
  TextStyle get headline36 => _defaultFont.copyWith(fontSize: 36, height: 40 / 36, fontWeight: FontWeight.w600);
  TextStyle get headline32 => _defaultFont.copyWith(fontSize: 32, height: 36 / 32, fontWeight: FontWeight.w600);
  TextStyle get headline28 => _defaultFont.copyWith(fontSize: 28, height: 32 / 28, fontWeight: FontWeight.w600);
  TextStyle get headline24 => _defaultFont.copyWith(fontSize: 24, height: 28 / 24, fontWeight: FontWeight.w600);
  TextStyle get title22 => _defaultFont.copyWith(fontSize: 22, height: 26 / 22, fontWeight: FontWeight.w600);

  TextStyle get h1 => _defaultFont.copyWith(fontSize: 20, height: 26 / 20, fontWeight: FontWeight.w600);

  TextStyle get h1start => _defaultFont.copyWith(fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w600);

  TextStyle get h2 => _defaultFont.copyWith(fontSize: 16, height: 22 / 16, fontWeight: FontWeight.w600);

  TextStyle get mainText => _defaultFont.copyWith(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w500);

  TextStyle get smallText => _defaultFont.copyWith(fontSize: 12, height: 18 / 12, fontWeight: FontWeight.w500);

  TextStyle get subText => _defaultFont.copyWith(fontSize: 10, height: 14 / 10, fontWeight: FontWeight.w600);

  TextStyle get xsText => _defaultFont.copyWith(fontSize: 8, height: 12 / 8, fontWeight: FontWeight.w600);

  TextStyle get buttonsS => _defaultFont.copyWith(fontSize: 14, height: 18 / 14, fontWeight: FontWeight.w600);

  TextStyle get buttonsL => _defaultFont.copyWith(fontSize: 16, height: 22 / 16, fontWeight: FontWeight.w600);
}
