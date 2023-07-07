// import 'package:flutter/material.dart';
// import 'package:foodmix_app/screens/start_screen.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 240, 223, 223),
//                 Color.fromARGB(244, 201, 199, 199),
//               ],
//               begin: Alignment.bottomCenter,
//               end: Alignment.topLeft,
//             ),
//           ),
//           child: const StartScreen(),
//         ),
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:foodmix_app/transition.dart';

void main() {
  runApp(const Transition());
}
