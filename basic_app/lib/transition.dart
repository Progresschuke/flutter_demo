import 'package:basic_app/model/quiz_question.dart';
import 'package:flutter/material.dart';

import 'package:basic_app/start_screen.dart';
import 'package:basic_app/question_screen.dart';
import 'package:basic_app/result_screen.dart';

class Transition extends StatefulWidget {
  const Transition({
    super.key,
    required this.finalQuestions,
    required this.title,
  });

  final List<QuizQuestion> finalQuestions;
  final String title;

  @override
  State<Transition> createState() {
    return _TransitionState();
  }
}

class _TransitionState extends State<Transition> {
  var activeScreen = 'start-screen';
  List<String> selectedAnswers = [];

  void addAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == widget.finalQuestions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'question-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = activeScreen == 'start-screen'
        ? StartScreen(switchScreen)
        : QuestionScreen(
            onChooseAnswer: addAnswer,
            questions: widget.finalQuestions,
          );

    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        questions: widget.finalQuestions,
        selectedAnswers: selectedAnswers,
        restartQuiz: restartQuiz,
      );
    }

    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Theme.of(context).colorScheme.primary.withOpacity(0.6),
        //       Theme.of(context).colorScheme.primary.withOpacity(0.3),
        //     ],
        //     begin: Alignment.bottomRight,
        //     end: Alignment.topLeft,
        //   ),
        // ),
        child: screenWidget,
      ),
    );
  }
}
