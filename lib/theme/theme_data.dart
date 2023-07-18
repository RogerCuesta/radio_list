import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio/theme/color_palette.dart';
import 'package:flutter_radio/theme/text_theme.dart';

class RadioAppThemeData {
  final RadioAppColorPalette colorPalette;
  final RadioAppTextTheme radioAppTextTheme;

  RadioAppThemeData({
    required this.colorPalette,
    required RadioAppTextTheme Function(RadioAppColorPalette)
        radioAppTextThemeBuilder,
  }) : radioAppTextTheme = radioAppTextThemeBuilder(colorPalette);

  static RadioAppThemeData light() => RadioAppThemeData(
        colorPalette: RadioAppColorPalette(),
        radioAppTextThemeBuilder: (colors) => RadioAppTextTheme(
          titleLarge: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            fontSize: 20,
          ),
          bodyText: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
          ),
          tagText: TextStyle(
            color: colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
          titleCurrentplaying: TextStyle(
              color: colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: "Raleway",
              fontStyle: FontStyle.normal,
              fontSize: 24.0),
          titleCardRadios: TextStyle(
              color: colors.white,
              fontWeight: FontWeight.w700,
              fontFamily: "Raleway",
              fontStyle: FontStyle.normal,
              fontSize: 13.0),
          subTitleCardRaios: TextStyle(
              color: colors.grey,
              fontWeight: FontWeight.w600,
              fontFamily: "Raleway",
              fontStyle: FontStyle.normal,
              fontSize: 10.0),
          radioInfoText: TextStyle(
            color: colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}

extension MaterialThemeData on RadioAppThemeData {
  ThemeData get materialThemeData => ThemeData(
        primaryTextTheme: ThemeData.light().textTheme,
        appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            color: colorPalette.black,
            titleTextStyle: radioAppTextTheme.titleLarge),
        fontFamily: 'Raleway',
      );
}
