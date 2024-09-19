import 'package:flutter/material.dart';
import 'package:hotel_management/utils/kroute.dart';

class KTheme {
  factory KTheme() => _commonFunctions;

  KTheme._internal();
  static final KTheme _commonFunctions = KTheme._internal();

  // #####################################################################
  // #####################################################################

  // NEW THEME

  static const Color fg = Color(0xffe63946);
  static const Color lightFg = Color(0xfff1faee);
  static const Color bg = Color.fromARGB(255, 39, 87, 29);
  static const Color lightBg = Color.fromARGB(255, 73, 157, 69);
  static const Color superLightBg = Color.fromARGB(255, 169, 220, 168);

  // App bar style
  static const Color globalAppBarBG = Color(0xffEB1555);

  // Body style
  static const Color globalScaffoldBG = Color(0xff090E21);
  static const Color globalScaffoldFG = Color(0xff1D1E33);

  // BUTTONS, SLIDERS ETC
  static const Color activeBg = Color(0xff090E21);
  static const Color inactiveBg = Color(0xff1D1E33);

  // Bottom Navigation bar style
  static const Color globalBottomNavBG = Color(0xffEB1555);
  static const Color globalBottomNavActiveTab = Colors.white;
  static const Color globalBottomNavInActiveTab = Colors.white54;

  static const Color appBg = Color(0xff980000);
  static const Color appFg = Colors.amber;
  static const Color appFg2 = Colors.deepOrange;
  static const Color appFg3 = Color(0xffF8F8FF);

  static const Color splashColor = Color(0xffEB1555);
  static const Color ghostWhite = Color(0xffF8F8FF);
  static const Color disableBg = Color(0xff111328);
  static final Color disableFg = Colors.grey.shade600;
  static const Color errorTransparent = Color.fromARGB(170, 244, 67, 54);
  static const Color linkFg = Colors.blue;
  static const Color transparencyBlack = Color.fromARGB(121, 0, 0, 0);

  static const Color darkModeBg = Color(0xff111328);
  static const Color darkModeFg = Color(0xFF1D1E33);

  static const Color error = Colors.red;
  static const Color success = Color.fromARGB(255, 23, 122, 45);
  static const Color warning = Colors.orange;
  static const Color info = Color.fromARGB(175, 11, 74, 125);

  static const Color silverColor = Color(0xffC0C0C0);
  static const Color goldenColor = Color(0xffFFD700);

  static const Color myMessageBG = Color.fromARGB(155, 0, 125, 48);
  static const Color otherMessageBG = Color.fromARGB(121, 0, 0, 0);

  // Text styles
  static TextStyle subtitleTextStyle() => const TextStyle(
        color: Colors.grey,
      );

  static TextStyle titleTextStyle({Color? textColor}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: textColor,
      );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 12.0,
  );
  static const TextStyle linkTextStyle =
      TextStyle(color: Colors.blue, fontSize: 8.0);

  static const Color bottomPinnedDialogBg = Colors.teal;

  static TextStyle sortingTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
  );

  InputDecoration textfieldInputDecoration({
    Widget? label,
    Widget? suffixIcon,
    String? errorText,
    String? placehoderTitle,
    IconData? placehoderIcon,
  }) {
    return InputDecoration(
      errorText: errorText,
      border: const OutlineInputBorder(),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(placehoderIcon ?? Icons.person),
          const SizedBox(
            width: 8.0,
          ),
          Text(placehoderTitle ?? 'First name'),
        ],
      ),
      suffixIcon: suffixIcon,
    );
  }

  static RoundedRectangleBorder roundedBorderShape({double? radius}) {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 20.0)));
  }

  static final ThemeData material3Themedata =
      Theme.of(navigatorKey.currentContext!).copyWith();
}
