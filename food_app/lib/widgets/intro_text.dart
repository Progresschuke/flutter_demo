import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroText extends StatelessWidget {
  const IntroText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/foodlogo.png', width: 40, height: 40),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Taste Fusion',
              style: GoogleFonts.rowdies(
                  fontSize: 28,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Embark on a flavorful journey with dishes inspired by vibrant spices',
          style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 2,
              color: Theme.of(context).colorScheme.onBackground),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
