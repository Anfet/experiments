import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';
import 'colors_light.dart';

final AppTheme lightTheme = AppTheme(colors: ColorsLight());
final themes = ValueNotifier<AppTheme>(lightTheme);

AppTheme get theme => themes.value;

@immutable
class AppTheme {
  final AppColors colors;
  final AppStyles styles;

  AppTheme({required this.colors}) : styles = AppStyles(colors: colors);
}

abstract class ThemeDataProvider {
  ThemeData from(AppColors colors, AppStyles styles);
}

typedef ThemeWidgetBuilder = Widget Function(BuildContext context, AppTheme theme);

class ThemeBuilder extends StatelessWidget {
  final ThemeWidgetBuilder builder;

  const ThemeBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themes,
      builder: (context, theme, child) => builder(context, theme),
    );
  }
}

extension TextStyleTypographyExt on TextStyle {
  TextStyle textOnPrimary() => copyWith(color: theme.colors.blockBg);

  TextStyle textPrimary() => copyWith(color: theme.colors.headlines);

  TextStyle accentBlue() => copyWith(color: theme.colors.brandBlue);

  TextStyle accentOrange() => copyWith(color: theme.colors.brandedOrange);

  TextStyle mono() => this;

  TextStyle textSecondary() => copyWith(color: theme.colors.lightText);

  TextStyle headlines() => copyWith(color: theme.colors.headlines);
}
