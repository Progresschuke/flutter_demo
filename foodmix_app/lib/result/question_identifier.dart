import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier({
    super.key,
    required this.questionIndex,
    required this.isCorrectAnswer,
  });

  final bool isCorrectAnswer;
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final questionNumber = questionIndex + 1;
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color: isCorrectAnswer
              ? const Color.fromARGB(255, 2, 40, 71)
              : const Color.fromARGB(248, 153, 31, 9),
          borderRadius: BorderRadius.circular(12)),
      child: Text(
        questionNumber.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
      ),
    );
  }
}
