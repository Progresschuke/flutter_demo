import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/auth/sign_in.dart';

import 'package:food_app/widgets/background_image.dart';
import 'package:food_app/widgets/intro_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

// To check device connection state
  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  @override
  void dispose() {
    //dispose connection subscription to avoid rebuilding
    subscription.cancel();
    super.dispose();
  }

  void recheckConnection() async {
    Navigator.pop(context, 'cancel');
    setState(() {
      isAlertSet = false;
    });
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected && isAlertSet == false) {
      showDialogBox();
      setState(() {
        isAlertSet = true;
      });
    }
  }

  showDialogBox() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('No Connection'),
              content: const Text('Please check your internet connection'),
              actions: [
                TextButton(
                    onPressed: recheckConnection, child: const Text('Ok'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundImage(
      image: const AssetImage(
        'assets/images/bg_image.jpg',
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hungry?',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                'Order or Cook...',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.8)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 7 * size.height / 100,
              ),
              SizedBox(
                height: 40 * size.height / 100,
                width: 60 * size.height / 100,
                child: Image.asset('assets/images/burger.png'),
              ),
              const Spacer(),
              const IntroText(),
              const SizedBox(
                height: 38,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const SignInScreen()),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: Text(
                  'Get Started',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



//Internet Connection
// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:food_app/screens/tab.dart';
// import 'package:food_app/widgets/background_image.dart';
// import 'package:food_app/widgets/intro_text.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return BackgroundImage(
//       image: const AssetImage(
//         'assets/images/bg_image.jpg',
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
//           child: StreamBuilder(
//             stream: Connectivity().onConnectivityChanged,
//             builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
//               print(snapshot.toString());
//               if (snapshot.hasData) {
//                 ConnectivityResult? result = snapshot.data;
//                 if (result == ConnectivityResult.mobile) {
//                   //connected to mobile internet
//                   return connected('Mobile');
//                 } else if (result == ConnectivityResult.wifi) {
//                   //connected to WIFI internet
//                   return homePage();
//                 } else {
//                   //no network
//                   return noInternet();
//                 }
//               } else {
//                 return loading();
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget loading() {
//     return const Center(
//       child: CircularProgressIndicator(
//         valueColor: AlwaysStoppedAnimation(Colors.amber),
//       ),
//     );
//   }

//   Widget connected(String type) {
//     return Center(
//       child: Text(
//         '$type Connected',
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//         ),
//       ),
//     );
//   }

//   Widget homePage() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           'Hungry?',
//           style: Theme.of(context).textTheme.displayLarge!.copyWith(
//               color: const Color.fromARGB(255, 251, 255, 17),
//               fontWeight: FontWeight.bold),
//           textAlign: TextAlign.center,
//         ),
//         Text(
//           'Order or Cook...',
//           style: Theme.of(context)
//               .textTheme
//               .displayMedium!
//               .copyWith(fontWeight: FontWeight.w400, color: Colors.white70),
//           textAlign: TextAlign.center,
//         ),
//         const Spacer(),
//         const IntroText(),
//         const SizedBox(
//           height: 38,
//         ),
//         ElevatedButton.icon(
//           onPressed: () {
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (ctx) => const TabScreen()));
//           },
//           icon: const Icon(Icons.arrow_forward),
//           style: ElevatedButton.styleFrom(
//               backgroundColor: const Color.fromARGB(255, 251, 255, 17),
//               foregroundColor: Colors.black87),
//           label: Text(
//             'Get Started',
//             style: GoogleFonts.roboto(
//               fontSize: 18,
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Widget noInternet() {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           'assets/images/no_internet.png',
//           color: Colors.white30,
//           height: 30 * size.height / 100,
//         ),
//         Container(
//           margin: const EdgeInsets.all(8),
//           child: const Text('No Internet Connection',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//               )),
//         ),
//         Container(
//           alignment: Alignment.center,
//           margin: const EdgeInsets.all(8),
//           child: const Text('Check your connection, then refresh the page',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//               )),
//         ),
//       ],
//     );
//   }
// }


// //Rich Text

// // import 'package:flutter/material.dart';
// // import 'package:food_app/widgets/intro_text.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         decoration: const BoxDecoration(
// //           image: DecorationImage(
// //             image: AssetImage(
// //               'assets/images/homepage.png',
// //             ),
// //             fit: BoxFit.cover,
// //           ),
// //         ),
// //         child: Center(
// //           child: Column(
// //             children: [
// //               const Opacity(
// //                 opacity: .65,
// //                 child: Image(
// //                   image: AssetImage('assets/images/burger1.png'),
// //                   height: 500,
// //                 ),
// //               ),
// //               const IntroText(),
// //               const SizedBox(
// //                 height: 38,
// //               ),
// //               ElevatedButton.icon(
// //                   onPressed: () {},
// //                   icon: const Icon(Icons.arrow_forward),
// //                   style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color.fromARGB(255, 223, 168, 3),
// //                       foregroundColor: Colors.black87),
// //                   label: Text(
// //                     'Get Started',
// //                     style: GoogleFonts.roboto(
// //                       fontSize: 18,
// //                     ),
// //                   ),)
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
