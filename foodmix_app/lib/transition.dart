import 'package:flutter/material.dart';
import 'package:foodmix_app/data/questions.dart';
import 'package:foodmix_app/screens/question_screen.dart';
import 'package:foodmix_app/screens/result_screen.dart';
import 'package:foodmix_app/screens/start_screen.dart';

class Transition extends StatefulWidget {
  const Transition({super.key});

  @override
  State<Transition> createState() {
    return _TransitionState();
  }
}

class _TransitionState extends State<Transition> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void startQuiz() {
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
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(
      onStart: startQuiz,
    );

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        onRestart: restartQuiz,
        chosenAnswer: selectedAnswers,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 240, 223, 223),
                Color.fromARGB(255, 240, 223, 233),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topLeft,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
