import 'package:flutter/material.dart';

class QuizQuestion {
  const QuizQuestion(this.question, this.answers, this.category);

  final String question;
  final List<String> answers;
  final String category;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}

class Category {
  const Category({
    required this.title,
    required this.id,
    required this.color,
    required this.icon,
  });

  final String title;
  final String id;
  final Color color;
  final Icon icon;
}
