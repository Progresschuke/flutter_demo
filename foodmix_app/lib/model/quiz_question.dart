import 'package:flutter/material.dart';

class QuizQuestion {
  const QuizQuestion(this.pic, this.answers);

  final Image pic;
  final List<String> answers;

  List<String> get shuffledAnswers {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
