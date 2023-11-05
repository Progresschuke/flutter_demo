import 'package:basic_app/category_screen.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.system,
    darkTheme: FlexColorScheme.dark(scheme: FlexScheme.greyLaw).toTheme,
    theme: FlexColorScheme.light(scheme: FlexScheme.outerSpace).toTheme,
    home: const CategoryScreen(),
  ));
}
