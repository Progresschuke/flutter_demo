import 'package:flutter/material.dart';
import 'package:food_app/widgets/auth/email_sign_up/email_sign_up_form.dart';

import 'package:food_app/widgets/auth/email_sign_up/have_account_text.dart';

class EmailSignUpBody extends StatelessWidget {
  const EmailSignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3 * size.width / 100,
            vertical: 5 * size.height / 100,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 7 * size.height / 100),
                Text(
                  'Register Account',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                SizedBox(height: 1.5 * size.height / 100),
                Text(
                  'Complete your details to \ncreate an account',
                  textAlign: TextAlign.center,
                  textHeightBehavior: const TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                  ),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                ),
                SizedBox(height: 4 * size.height / 100),
                const EmailSignUpForm(),
                SizedBox(height: 6 * size.height / 100),
                Text(
                  'By continuing, you confirm that you comply \nwith our Terms and Conditions',
                  textAlign: TextAlign.center,
                  textHeightBehavior: const TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                  ),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                ),
                SizedBox(height: 3 * size.height / 100),
                const HaveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
