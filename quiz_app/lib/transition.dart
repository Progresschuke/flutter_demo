import 'package:basic_app/data/questions.dart';
import 'package:flutter/material.dart';

import 'package:basic_app/start_screen.dart';
import 'package:basic_app/question_screen.dart';
import 'package:basic_app/result_screen.dart';

class Transition extends StatefulWidget {
  const Transition({super.key});

  @override
  State<Transition> createState() {
    return _TransitionState();
  }
}

class _TransitionState extends State<Transition> {
  // @override
  // void initState() {
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState();
  // }

  // void switchScreen() {
  //   setState(() {
  //     activeScreen = const QuestionScreen();
  //   });
  // }
  var activeScreen = 'start-screen';
  List<String> selectedAnswers = [];

  void addAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      // selectedAnswers = [];
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
      activeScreen = 'question-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = activeScreen == 'start-screen'
        ? StartScreen(switchScreen)
        : QuestionScreen(
            onChooseAnswer: addAnswer,
          );

    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        selectedAnswers: selectedAnswers,
        restartQuiz: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        // backgroundColor: const Color.fromRGBO(50, 5, 66, 99),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 31, 1, 65),
                Color.fromARGB(255, 30, 1, 63),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
