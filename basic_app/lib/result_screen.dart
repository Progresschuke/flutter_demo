import 'package:basic_app/model/quiz_question.dart';
import 'package:flutter/material.dart';

// import 'package:basic_app/data/questions.dart';
import 'package:basic_app/result.dart/result_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.questions,
    required this.restartQuiz,
    required this.selectedAnswers,
  });

  final void Function() restartQuiz;
  final List<QuizQuestion> questions;
  final List<String> selectedAnswers;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].question,
          'correct_answer': questions[i].answers[0],
          'user_answer': selectedAnswers[i],
        },
      );
    }
    return summary;
  }

  @override
  Widget build(context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where(
          (data) => data['user_answer'] == data['correct_answer'],
        )
        .length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out $numTotalQuestions correctly',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            ResultSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: restartQuiz,
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Restart Quiz!',
              ),
            )
          ],
        ),
      ),
    );
  }
}
