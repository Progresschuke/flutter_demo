import 'package:basic_app/model/quiz_question.dart';
import 'package:flutter/material.dart';

import 'package:basic_app/answer_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen(
      {super.key, required this.onChooseAnswer, required this.questions});

  final void Function(String answer) onChooseAnswer;
  final List<QuizQuestion> questions;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String answer) {
    widget.onChooseAnswer(answer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = widget.questions[currentQuestionIndex];
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(currentQuestion.question,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 20,
            ),
            ...currentQuestion.getShuffledAnswers().map((answer) {
              return AnswerButton(
                onTap: () {
                  answerQuestion(answer);
                },
                answerText: answer,
              );
            }),
          ],
        ),
      ),
    );
  }
}
