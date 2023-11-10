// import 'package:flutter/material.dart';
// import 'package:food_app/screens/auth/sign_up.dart';

// class NoAccountText extends StatelessWidget {
//   const NoAccountText({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("Don't have an account? "),
//         GestureDetector(
//           onTap: () {
//             Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (ctx) => const SignUpScreen()));
//           },
//           child: Text(
//             ' Sign Up',
//             style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:food_app/screens/auth/email_sign_up.dart';
import 'package:food_app/screens/auth/phone_sign_up.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          "Don't have an account? Sign up Using",
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(height: 1 * size.height / 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.phone_outlined,
              size: 15,
            ),
            SizedBox(width: 2 * size.width / 100),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const PhoneSignUp()));
              },
              child: Text(
                'phone number ',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            SizedBox(width: 3 * size.width / 100),
            const Icon(
              Icons.mail_outline,
              size: 13,
            ),
            SizedBox(width: 2 * size.width / 100),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => const EmailSignUpScreen()));
              },
              child: Text(
                'email address',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
