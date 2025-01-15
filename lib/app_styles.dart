import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

import 'app_colors.dart';
import 'app_theme.dart';
import 'app_typography.dart';
import 'system_overlays.dart';

class AppStyles {
  final AppColors colors;

  AppStyles({required this.colors});

  ThemeData get themeData {
    final defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colors.lightText),
    );
    return ThemeData.light(useMaterial3: false).copyWith(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: colors.brandBlue,
        onPrimary: colors.mainBg,
        secondary: colors.brandBlueAccent,
        onSecondary: colors.mainBg,
        error: colors.red,
        onError: colors.mainBg,
        background: colors.mainBg,
        onBackground: colors.text,
        surface: colors.mainBg,
        onSurface: colors.text,
      ),
      scaffoldBackgroundColor: colors.mainBg,
      cardTheme: CardTheme(color: colors.mainBg),
      brightness: Brightness.light,
      cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: colors.mainBg,
        barBackgroundColor: colors.brandBlue,
        primaryColor: colors.brandBlue,
        primaryContrastingColor: colors.text,
        textTheme: CupertinoTextThemeData(
          textStyle: fonts.mainText.textPrimary(),
          primaryColor: colors.text,
          navActionTextStyle: fonts.smallText.textPrimary(),
          actionTextStyle: fonts.smallText.textPrimary(),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: fonts.headline36.textPrimary(),
        displayMedium: fonts.headline32.textPrimary(),
        displaySmall: fonts.headline28.textPrimary(),
        headlineLarge: fonts.headline28.textPrimary(),
        headlineMedium: fonts.headline24.textPrimary(),
        headlineSmall: fonts.title22.textPrimary(),
        titleLarge: fonts.title22.textPrimary(),
        titleMedium: fonts.h1.textPrimary(),
        titleSmall: fonts.h2.textPrimary(),
        bodyLarge: fonts.h2.textPrimary(),
        bodyMedium: fonts.mainText.textPrimary(),
        bodySmall: fonts.smallText.textPrimary(),
        labelLarge: fonts.smallText.textPrimary(),
        labelMedium: fonts.subText.textPrimary(),
        labelSmall: fonts.xsText.textPrimary(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonOrange),
      expansionTileTheme: ExpansionTileThemeData(iconColor: colors.accents, collapsedIconColor: colors.accents),
      textButtonTheme: TextButtonThemeData(style: flatButton),
      filledButtonTheme: FilledButtonThemeData(style: buttonOrange),
      outlinedButtonTheme: OutlinedButtonThemeData(style: buttonMainBgOutline),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.mainBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: defaultInputBorder,
        focusedBorder: defaultInputBorder.copyWith(borderSide: BorderSide(color: colors.headlines)),
        enabledBorder: defaultInputBorder,
        errorBorder: defaultInputBorder.copyWith(borderSide: BorderSide(color: colors.red)),
        focusedErrorBorder: defaultInputBorder.copyWith(borderSide: BorderSide(color: colors.red)),
        hintStyle: fonts.smallText.copyWith(color: colors.accents),
        errorStyle: fonts.subText.copyWith(color: colors.red),
      ),
      iconTheme: IconThemeData(size: 24, color: colors.text),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: colors.mainBg,
        centerTitle: true,
        foregroundColor: colors.headlines,
        titleSpacing: 0,
        systemOverlayStyle: systemOverlays.darkIconsOverlay,
        toolbarHeight: 48,
        titleTextStyle: fonts.mainText.bold().copyWith(color: colors.headlines),
        toolbarTextStyle: fonts.mainText.bold().copyWith(color: colors.headlines),
        actionsIconTheme: IconThemeData(color: colors.headlines, size: 24),
        iconTheme: IconThemeData(size: 24, color: colors.headlines),
      ),
      splashColor: colors.brandBlue.withOpacity(.1),
      focusColor: colors.brandBlue.withOpacity(.1),
      highlightColor: colors.brandBlue.withOpacity(.1),
      dialogBackgroundColor: colors.mainBg,
      dialogTheme: DialogTheme(
        backgroundColor: colors.mainBg,
        elevation: 4,
        contentTextStyle: fonts.mainText.copyWith(color: colors.text),
        titleTextStyle: fonts.headline24.copyWith(color: colors.text),
        alignment: Alignment.center,
        iconColor: colors.brandBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colors.text,
        titleTextStyle: fonts.mainText.medium(),
        textColor: colors.text,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.mainBg,
        elevation: 0,
        selectedIconTheme: IconThemeData(color: colors.brandBlue, size: 24),
        selectedItemColor: colors.brandBlue,
        selectedLabelStyle: fonts.smallText.medium(),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedIconTheme: IconThemeData(color: colors.activeElements, size: 24),
        unselectedItemColor: colors.activeElements,
        unselectedLabelStyle: fonts.smallText.medium(),
      ),
    );
  }

  late final SystemOverlays systemOverlays = SystemOverlays(colors);

  late final ButtonStyle flatButton = ButtonStyle(
    elevation: const MaterialStatePropertyAll(0),
    backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      return colors.headlines;
    }),
    overlayColor: MaterialStatePropertyAll(colors.headlines.withOpacity(.1)),
    textStyle: MaterialStatePropertyAll(fonts.buttonsS),
    alignment: Alignment.center,
    minimumSize: const MaterialStatePropertyAll(Size(90, 40)),
    maximumSize: const MaterialStatePropertyAll(Size.infinite),
    // padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10, horizontal: 12)),
    padding: const MaterialStatePropertyAll(EdgeInsets.zero),
    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  );

  late final ButtonStyle buttonOrange = flatButton.copyWith(
    elevation: const MaterialStatePropertyAll(0),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return colors.brandedOrangeInactive;
      }
      return colors.brandedOrange;
    }),
    foregroundColor: MaterialStatePropertyAll(colors.blockBg),
    textStyle: MaterialStatePropertyAll(fonts.buttonsS),
  );

  late final ButtonStyle buttonBlue = flatButton.copyWith(
    elevation: const MaterialStatePropertyAll(0),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return colors.blueButtonInactive;
      }
      return colors.blueButton;
    }),
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return colors.blockBg.withOpacity(.5);
      }
      return colors.blockBg;
    }),
    textStyle: MaterialStatePropertyAll(fonts.buttonsS),
  );

  late final ButtonStyle buttonAccents = flatButton.copyWith(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      return colors.accents;
    }),
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return colors.lightText;
      }
      return colors.activeElements;
    }),
  );

  ButtonStyle get buttonDark => flatButton.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colors.dark.withOpacity(.5);
          }
          return colors.dark;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          return colors.accents1;
        }),
      );

  late final ButtonStyle buttonMainBg = flatButton.copyWith(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return colors.mainBg.withOpacity(.5);
      }
      return colors.mainBg;
    }),
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return colors.lightText;
      }
      return colors.brandBlue;
    }),
  );

  ButtonStyle get buttonMainBgOutline => flatButton.copyWith(
        shape: MaterialStateProperty.resolveWith(
          (states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                width: 1,
                color: states.contains(MaterialState.disabled) ? theme.colors.accents : theme.colors.lightText,
              ),
            );
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled) ? theme.colors.lightText : theme.colors.activeElements,
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
      );

  ButtonStyle get buttonHeadlinesOutline => flatButton.copyWith(
        shape: MaterialStateProperty.resolveWith(
          (states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                width: 1,
                color: states.contains(MaterialState.disabled) ? theme.colors.lightText.withOpacity(.5) : theme.colors.headlines,
              ),
            );
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled) ? theme.colors.lightText.withOpacity(.5) : theme.colors.headlines,
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
      );

  ButtonStyle get buttonBlueOutline => flatButton.copyWith(
        shape: MaterialStateProperty.resolveWith(
          (states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                width: 1,
                color: states.contains(MaterialState.disabled) ? theme.colors.lightText.withOpacity(.5) : theme.colors.blueButton,
              ),
            );
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled) ? theme.colors.lightText.withOpacity(.5) : theme.colors.blueButton,
        ),
      );

  ButtonStyle get buttonlightBlue => buttonBlue.copyWith(
        backgroundColor: MaterialStatePropertyAll(theme.colors.accents),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
        foregroundColor: MaterialStatePropertyAll(theme.colors.activeElements),
      );

  UnderlineInputBorder get textFieldBorder => UnderlineInputBorder(
        borderSide: BorderSide(color: theme.colors.mainBg, width: 1),
      );

  UnderlineInputBorder get errorTextFieldBorder => UnderlineInputBorder(
        borderSide: BorderSide(color: theme.colors.red, width: 1),
      );

  InputDecoration get textFieldDecoration => InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 8, top: 8),
        fillColor: theme.colors.mainBg,
        errorBorder: errorTextFieldBorder,
        focusedBorder: textFieldBorder,
        focusedErrorBorder: errorTextFieldBorder,
        disabledBorder: textFieldBorder,
        enabledBorder: textFieldBorder,
        border: textFieldBorder,
        errorStyle: fonts.mainText.copyWith(
          color: theme.colors.red,
        ),
        hintStyle: fonts.mainText.copyWith(
          color: theme.colors.lightText,
        ),
      );

  InputDecoration get userTextFieldDecoration => InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        fillColor: theme.colors.mainBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colors.accents1, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colors.accents1, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colors.accents1, width: 1),
        ),
      );

  InputDecoration get userTextFieldErrorDecoration => InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        fillColor: theme.colors.lightLightRed,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colors.red, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colors.red, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.colors.red, width: 1),
        ),
      );

  ButtonStyle get buttonOnBlueOutline => flatButton.copyWith(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(width: 1, color: theme.colors.blueButton),
          ),
        ),
        foregroundColor: MaterialStatePropertyAll(theme.colors.blueButton),
      );
}
