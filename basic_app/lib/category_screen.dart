import 'package:basic_app/category_item.dart';
import 'package:basic_app/data/questions.dart';
import 'package:basic_app/model/quiz_question.dart';
import 'package:basic_app/transition.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final finalQuizQuestions = questions
        .where((question) => question.category.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Transition(
          finalQuestions: finalQuizQuestions,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Quiz for Sharp Brains',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 5.5,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final category in availableCategories)
              CategoryItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              )
          ],
        ),
      ),
    );
  }
}
