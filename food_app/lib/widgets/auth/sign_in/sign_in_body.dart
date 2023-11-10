import 'package:flutter/material.dart';
import 'package:food_app/widgets/auth/sign_in/no_account_text.dart';
import 'package:food_app/widgets/auth/sign_in/sign_in_form.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

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
                SizedBox(height: 10 * size.height / 100),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                SizedBox(height: 1.5 * size.height / 100),
                Text(
                  'Do you have an account? \nSign in with your email and password',
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
                const SignInForm(),
                SizedBox(height: 15 * size.height / 100),
                const NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
