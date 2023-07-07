import 'package:flutter/material.dart';
import 'package:foodmix_app/result/question_identifier.dart';

class ResultStructure extends StatelessWidget {
  const ResultStructure({super.key, required this.itemData});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer =
        itemData['user_answer'] == itemData['correct_answer'];
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionIdentifier(
              isCorrectAnswer: isCorrectAnswer,
              questionIndex: itemData['question_index'] as int),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image(image: itemData['question'] as Image),
                Text(
                  itemData['user_answer'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 119, 13, 101),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  itemData['correct_answer'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 40, 71),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
