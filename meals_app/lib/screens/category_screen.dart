import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals_screen.dart';

import 'package:meals_app/widgets/category_item.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/data/dummy_data.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final finalDummyMeals = availableMeals
        .where((meals) => meals.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => MealsScreen(
                meals: finalDummyMeals,
                title: category.title,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
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
    );
  }
}
