import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/screens/home_screen.dart';
import 'package:food_app/screens/tab.dart';

//.....Raw File Using Flex Color Scheme and Firebase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  runApp(ProviderScope(
    child: GetMaterialApp(
      routes: {
        '/a': (BuildContext context) => const TabScreen(),
      },
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.limeM3).toTheme,
      theme: FlexColorScheme.light(scheme: FlexScheme.verdunHemlock).toTheme,
      home: const HomeScreen(),
      // home: const ProfileScreen(),
    ),
  ));
}

// //.....Raw File Using Customized Theme  from Helpers

// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:food_app/helpers/get_dark_theme.dart';
// import 'package:food_app/helpers/get_light_theme.dart';
// import 'package:food_app/screens/home_screen.dart';
// import 'package:food_app/screens/tab.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
  // runApp(ProviderScope(
  //   child: MaterialApp(
  //     routes: {
  //       '/a': (BuildContext context) => const TabScreen(),
  //     },
  //     debugShowCheckedModeBanner: false,
  //     darkTheme: getDarkTheme(),
  //     themeMode: ThemeMode.system,
  //     theme: getLightTheme(),
  //     home: const HomeScreen(),
  //   ),
  // ));
// }

// Raw File
//import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:food_app/helpers/get_dark_theme.dart';
// import 'package:food_app/screens/home_screen.dart';
// import 'package:food_app/screens/tab.dart';
// import 'package:google_fonts/google_fonts.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(ProviderScope(
//     child: MaterialApp(
//       routes: {
//         '/a': (BuildContext context) => const TabScreen(),
//       },
//       debugShowCheckedModeBanner: false,
//       darkTheme: getDarkTheme(),
//       themeMode: ThemeMode.system,
//       theme: ThemeData(
//         useMaterial3: true,
//         colorScheme: ColorScheme.fromSeed(
//           brightness: Brightness.dark,
//           seedColor: Color(0xFFC2C507),
//         ),
//         textTheme: GoogleFonts.latoTextTheme().copyWith(
//           titleSmall: GoogleFonts.montserrat(
//             fontWeight: FontWeight.bold,
//           ),
//           titleMedium: GoogleFonts.montserrat(
//             fontWeight: FontWeight.bold,
//           ),
//           titleLarge: GoogleFonts.lato(
//             fontWeight: FontWeight.bold,
//           ),
//           displaySmall: GoogleFonts.lato(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       home: const HomeScreen(),
//     ),
//   ));
// }

