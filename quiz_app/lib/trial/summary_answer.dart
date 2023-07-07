import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryAnswer extends StatelessWidget {
  const SummaryAnswer({super.key, required this.summary});

  final Map<String, Object> summary;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(summary['question'] as String,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(
          height: 5,
        ),
        Text(
          summary['user_answer'] as String,
          style: const TextStyle(color: Color.fromARGB(255, 202, 171, 252)),
        ),
        Text(
          summary['correct_answer'] as String,
          style: const TextStyle(color: Color.fromARGB(255, 181, 254, 246)),
        )
      ],
    );
  }
}
