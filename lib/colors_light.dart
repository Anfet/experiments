import 'package:flutter/material.dart';

import '../app_colors.dart';

class ColorsLight implements AppColors {
  @override
  Color get brandBlue => const Color(0xFF3A5DAE);

  @override
  Color get brandBlueAccent => const Color(0xFF2B4EA0);

  @override
  Color get mainBg => const Color(0xFFEBF6FC);

  @override
  Color get blockBg => const Color(0xFFFFFFFF);

  @override
  Color get accents => const Color(0xFFD6EEFB);

  @override
  Color get accents1 => const Color(0xFFC5DFED);

  @override
  Color get brandedOrange => const Color(0xFFEA733D);

  @override
  Color get brandedOrangeInactive => brandedOrange.withOpacity(.5); //const Color(0xFFFBBE9F);

  @override
  Color get blueButton => const Color(0xFF56B7E6);

  @override
  Color get blueButtonInactive => blueButton.withOpacity(.4);

  @override
  Color get headlines => const Color(0xFF1C2B4F);

  @override
  Color get text => const Color(0xFF475B7A);

  @override
  Color get lightText => const Color(0xFF8DA1C0);

  @override
  Color get activeElements => const Color(0xFF466593);

  @override
  Color get lightRed => const Color(0xFFFFBEBE);

  @override
  Color get red => const Color(0xFFEF3A3A);

  @override
  Color get lightIcon => const Color(0xFF677B9A);

  @override
  Color get lightLightRed => const Color(0xFFFFF4F4);

  @override
  Color get gray => const Color(0xFFA9A9A9);

  @override
  Color get green => const Color(0xFF299C65);

  @override
  Color get lightGray => const Color(0xFFD8D8D8);

  @override
  Color get lightGreen => const Color(0xFF6FD7A5);

  @override
  Color get lightLightGray => const Color(0xFFF6F6F6);

  @override
  Color get lightLightGreen => const Color(0xFFEFFDF3);

  @override
  Color get lightLightViolet => const Color(0xFFF6F0FF);

  @override
  Color get lightViolet => const Color(0xFFDBB1FF);

  @override
  Color get violet => const Color(0xFF9953D0);

  @override
  Color get grayLight => const Color(0xFF8796AD);

  @override
  Color get darkBg => const Color(0xFF2D455B);

  @override
  Color get white => const Color(0xFFFFFFFF);

  @override
  Color get dark => const Color(0xff2D455B);

}
