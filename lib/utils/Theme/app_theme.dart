import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_app_demo/utils/color_utils.dart';
import 'package:web_app_demo/utils/iamge_utils.dart';
import 'app_text_style.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: FontUtils.cerebriSans,
    scaffoldBackgroundColor: ColorUtils.white,
    primaryColor: ColorUtils.primary,
    secondaryHeaderColor: ColorUtils.secondary,
    iconTheme: const IconThemeData(color: ColorUtils.black),

    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: ColorUtils.black,
      collapsedIconColor: ColorUtils
          .black, // Set the ExpansionTile icon color to black for light mode
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.zero,
      // Style for label text
      labelStyle: TextStyle(
        color: ColorUtils.grey99, // Label color
      ),
      // Style for hint text
      hintStyle: TextStyle(
        fontSize: 18.sp,
        color: ColorUtils.grey99, // Hint text color
      ),
      // Style for error text
      errorStyle: TextStyle(
        fontSize: 12.0,
        color: Colors.red, // Error text color
      ),
      // Customizing borders for TextField
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorUtils.unselectedBorderColor,
        ), // Default border color
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorUtils.unselectedBorderColor,
        ), // Default border color
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorUtils.unselectedBorderColor,
        ), // Default border color
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorUtils.black21,
          width: 2.0,
        ), // Black focused bottom border
      ),
      // Error border
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: ColorUtils.primary,
      secondary: ColorUtils.secondary,
      outline: ColorUtils.grey99,
      onSurface: ColorUtils.white,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        return ColorUtils.primary; // Default color
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.hovered)) {
          return ColorUtils.grey99.withValues(alpha: 0.2); // Hover effect
        }
        return Colors.transparent; // Default overlay
      }),
    ),
    // textTheme: TextTheme(
    //   bodyLarge: fontStyleBold.copyWith(decoration: TextDecoration.none),
    //   bodyMedium: fontStyleSemiBold.copyWith(decoration: TextDecoration.none),
    //   bodySmall: fontStyleRegular.copyWith(decoration: TextDecoration.none),
    //   titleLarge: fontStyleBold.copyWith(
    //       color: ColorUtils.white, decoration: TextDecoration.none),
    //   // Extra heading text
    //   titleMedium: fontStyleSemiBold.copyWith(
    //       color: ColorUtils.white, decoration: TextDecoration.none),
    //   // Extra heading text
    //   titleSmall: fontStyleRegular.copyWith(
    //       color: ColorUtils.white,
    //       decoration: TextDecoration.none), // Extra heading text
    // ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorUtils.secondary,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarIconBrightness:
            Brightness.dark, // Dark icons (for light background)
        statusBarBrightness: Brightness.light, // For iOS devices
      ),
    ),
    dividerTheme: DividerThemeData(color: ColorUtils.grey99),
    checkboxTheme: CheckboxThemeData(
      // Using WidgetStateProperty for state-dependent colors
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorUtils.primary;
        }
        return Colors.white;
      }),
      // Using StatePropertyAll for simple values
      checkColor: const WidgetStatePropertyAll<Color>(Colors.white),
      // Shape of the checkbox
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      // Border color
      side: BorderSide(color: ColorUtils.primary, width: 2),
      // Using WidgetStateProperty for cursor
      mouseCursor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.forbidden;
        }
        return SystemMouseCursors.click;
      }),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: FontUtils.cerebriSans,
    scaffoldBackgroundColor: ColorUtils.darkThemeBg,
    cardColor: ColorUtils.darkThemeBg,
    // cardColor: const Color(0xff474747),
    primaryColor: ColorUtils.primary,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      // backgroundColor: Color(0xff464646),
      backgroundColor: ColorUtils.darkThemeBg,
    ),
    iconTheme: const IconThemeData(color: ColorUtils.white),
    inputDecorationTheme: InputDecorationTheme(),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: ColorUtils.white,
      collapsedIconColor: ColorUtils
          .white, // Set the ExpansionTile icon color to black for light mode
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorUtils.grey99,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarIconBrightness:
            Brightness.dark, // Dark icons (for light background)
        statusBarBrightness: Brightness.light, // For iOS devices
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: ColorUtils.primary,
      secondary: ColorUtils.secondary,
      outline: ColorUtils.grey99,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return ColorUtils.white; // Color when selected
        }
        return ColorUtils.white; // Default color
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.hovered)) {
          return ColorUtils.grey99.withValues(alpha: 0.2); // Hover effect
        }
        return Colors.transparent; // Default overlay
      }),
    ),
    textTheme: TextTheme(
      bodyLarge: fontStyleBold.copyWith(decoration: TextDecoration.none),
      bodyMedium: fontStyleSemiBold.copyWith(decoration: TextDecoration.none),
      bodySmall: fontStyleRegular.copyWith(decoration: TextDecoration.none),
      titleLarge: fontStyleBold.copyWith(
        color: ColorUtils.white,
        decoration: TextDecoration.none,
      ),
      // Extra heading text
      titleMedium: fontStyleSemiBold.copyWith(
        color: ColorUtils.white,
        decoration: TextDecoration.none,
      ),
      // Extra heading text
      titleSmall: fontStyleRegular.copyWith(
        color: ColorUtils.white,
        decoration: TextDecoration.none,
      ), // Extra heading text
    ),
  );
}
