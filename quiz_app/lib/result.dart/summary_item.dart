import 'package:basic_app/result.dart/question_identifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({super.key, required this.summary});

  final Map<String, Object> summary;
  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer = summary['user_answer'] == summary['correct_answer'];
    final questionIndex = summary['question_index'] as int;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionIdentifier(
            isCorrectAnswer: isCorrectAnswer,
            questionIndex: questionIndex,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
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
                  style: const TextStyle(
                      color: Color.fromARGB(255, 202, 171, 252)),
                ),
                Text(
                  summary['correct_answer'] as String,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 181, 254, 246)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
