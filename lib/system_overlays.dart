import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_theme.dart';

@immutable
class SystemOverlays {
  final AppColors colors;

  SystemOverlays(this.colors);

  ///[Brightness.dark] - черные иконки
  ///
  ///[systemNavigationBarIconBrightness] - работает **только** в когда есть иконки. т.е. 3х-кнопочная навигация в дроиде
  ///**не меняет** цвет навигационной полоски при навигации жестами
  ///
  ///[systemNavigationBarColor] - цвет **всей** полосы навигации
  ///
  ///[systemNavigationBarDividerColor] - цвет **всей** полосы навигации но уже с повыше дроида. полностью прозрачным быть не может. но можно
  ///поставить альфу = 1, и уже будет нормально. Этот элемент на 1 px больше чем [systemNavigationBarColor]. лучше всегда держать их вместе
  ///
  /// установить цвет полоски при жестовой навигации - **невозможно**. она адаптивно подстраивается по цвет экрана по какой-то хитрой схеме
  late final SystemUiOverlayStyle darkIconsOverlay = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.white.withAlpha(2),
    systemNavigationBarColor: Colors.black.withAlpha(2),
    systemNavigationBarDividerColor: Colors.black.withAlpha(2),
    systemNavigationBarContrastEnforced: true,
    systemStatusBarContrastEnforced: true,
  );

  SystemUiOverlayStyle get lightIconsOverlay => SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.white.withAlpha(2),
        systemNavigationBarColor: Colors.black.withAlpha(2),
        systemNavigationBarDividerColor: Colors.black.withAlpha(2),
        systemNavigationBarContrastEnforced: true,
        systemStatusBarContrastEnforced: true,
      );

  SystemUiOverlayStyle get mainScreenOverlay => darkIconsOverlay.copyWith(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      );

  SystemUiOverlayStyle get accentScreenOverlay => lightIconsOverlay.copyWith(
        systemNavigationBarColor: theme.colors.brandBlue,
        systemNavigationBarDividerColor: theme.colors.brandBlue,
      );
}
