import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.onStart});

  final void Function() onStart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FoodMix Match',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(249, 0, 0, 0),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/images/7.png',
            width: 400,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Test your food memory, Click the button to start now',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              foregroundColor: const Color.fromARGB(248, 247, 234, 234),
              backgroundColor: const Color.fromARGB(240, 37, 36, 36),
            ),
            onPressed: onStart,
            icon: const Icon(Icons.directions_walk_rounded),
            label: const Text('Start Now!'),
          ),
        ],
      ),
    );
  }
}
