import 'package:flutter/material.dart';
import 'package:food_app/widgets/auth/forgot_password/forgot_password_form.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3 * size.width / 100,
              vertical: 5 * size.height / 100,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10 * size.height / 100),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3 * size.width / 100,
                      vertical: 5 * size.height / 100,
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.3),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    child: Image.asset('assets/images/foodlogo.png',
                        width: 20 * size.width / 100,
                        height: 10 * size.height / 100),
                  ),
                  SizedBox(height: 1.5 * size.height / 100),
                  Text(
                    'Reset Password',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  SizedBox(height: 1.5 * size.height / 100),
                  Text(
                    'Enter your e-mail address and we will\nsend you a password reset link',
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
                  SizedBox(height: 1.5 * size.height / 100),
                  const ForgotPasswordForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
