import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:food_app/model/meal.dart';
import 'package:food_app/providers/cart_meal_order_provider.dart';
import 'package:food_app/providers/favorite_meal_provider.dart';
import 'package:food_app/widgets/meal_details/meal_description.dart';
import 'package:food_app/widgets/meal_details/meal_prep_details.dart';

class MealDetailsScreen extends ConsumerStatefulWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  ConsumerState<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends ConsumerState<MealDetailsScreen> {
  bool isStep = false;

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;
    final favoriteMeal = ref.watch(favoriteMealProvider);
    final isFavorite = favoriteMeal.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MealDescription(
              meal: meal,
              onAddToFavorite: () {
                final isAdded = ref
                    .read(favoriteMealProvider.notifier)
                    .toggleFavoriteMeal(meal);

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isAdded
                          ? 'Meal added to favorite'
                          : 'Meal removed from favorite',
                    ),
                  ),
                );
              },
              onAddToCart: () {
                final isAdded =
                    ref.read(cartMealProvider.notifier).toggleCartMeal(meal);

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isAdded ? 'Meal added to cart' : 'Meal removed from cart',
                    ),
                  ),
                );
              },
              favoriteIconColor: isFavorite
                  ? const Color(0xFFFA096E)
                  : const Color(0xFFACA7A8),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // MealButton(text: 'Ingredients', onTap: () {}),
                  // MealButton(text: 'Steps', onTap: () {}),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: !isStep
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onBackground,
                        backgroundColor: !isStep
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.background),
                    onPressed: () {
                      setState(() {
                        isStep = false;
                      });
                    },
                    child: const Text(
                      'Ingredients',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: !isStep
                            ? Theme.of(context).colorScheme.onBackground
                            : Theme.of(context).colorScheme.onPrimary,
                        backgroundColor: !isStep
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      setState(() {
                        isStep = true;
                      });
                    },
                    child: const Text(
                      'Steps',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            if (!isStep)
              ...meal.ingredients.map((step) {
                return MealPrepDetails(text: step);
              }),
            if (isStep)
              ...meal.steps.map((step) {
                return MealPrepDetails(text: step);
              }),
          ],
        ),
      ),
    );
  }
}
