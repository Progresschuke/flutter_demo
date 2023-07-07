import 'package:flutter/material.dart';
import 'package:foodmix_app/data/questions.dart';
import 'package:foodmix_app/result/result_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.chosenAnswer,
    required this.onRestart,
  });

  final List<String> chosenAnswer;
  final void Function() onRestart;

  List<Map<String, Object>> get summaryData {
    List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].pic,
        'user_answer': chosenAnswer[i],
        'correct_answer': questions[i].answers[0],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final totalQuestionNumber = questions.length;
    final correctQuestionNumber = summaryData
        .where(
          (data) => data['user_answer'] == data['correct_answer'],
        )
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'You answered $correctQuestionNumber out of $totalQuestionNumber correctly',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ResultSummary(itemData: summaryData),
            const SizedBox(
              height: 30,
            ),
            FilledButton.tonalIcon(
              style: FilledButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 233, 222, 222),
                backgroundColor: const Color.fromARGB(201, 20, 11, 16),
              ),
              onPressed: onRestart,
              label: const Text('Restart Quiz'),
              icon: const Icon(Icons.restart_alt_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
