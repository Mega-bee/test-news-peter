import 'package:flutter/material.dart';

Map<int, Color> color = const {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
MaterialColor customColor = MaterialColor(0xFF1e2761, color);
MaterialColor bgColor = MaterialColor(0xFFF73777B, color);
MaterialColor textColor = MaterialColor(0xFFffffff, color);
MaterialColor cardColor = MaterialColor(0xFF4D4C7D, color);
MaterialColor blackColor = MaterialColor(0xFF292928, color);
MaterialColor lighterblackColor = MaterialColor(0xFF303030, color);
MaterialColor lightColor = MaterialColor(0xFF5c5c5c, color);
