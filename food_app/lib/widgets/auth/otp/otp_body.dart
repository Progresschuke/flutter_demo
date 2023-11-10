import 'package:flutter/material.dart';
import 'package:food_app/widgets/auth/otp/otp_form.dart';

class OtpBody extends StatelessWidget {
  const OtpBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'OTP Verification',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              SizedBox(
                height: 1 * size.height / 100,
              ),
              Text(
                'We sent your verification code to +234 81***',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.5),
                    ),
              ),
              SizedBox(
                height: 1 * size.height / 100,
              ),
              buildTimer(
                Theme.of(context).colorScheme.error,
              ),
              SizedBox(
                height: 4 * size.height / 100,
              ),
              const OtpForm(),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: const Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
