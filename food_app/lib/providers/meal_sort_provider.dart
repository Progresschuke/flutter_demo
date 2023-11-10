import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/providers/filters_provider.dart';

enum MealSortingOption {
  ratingHighToLow,
  priceHighToLow,
  priceLowToHigh,
}

class MealSortingNotifier extends StateNotifier<List<Meal>> {
  MealSortingNotifier(List<Meal> meals) : super(meals);

  void sortMeals(MealSortingOption sortingOption) {
    state = [...state]; //clone list to avoid mutating

    switch (sortingOption) {
      case MealSortingOption.ratingHighToLow:
        state.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case MealSortingOption.priceHighToLow:
        state.sort((a, b) => b.price.compareTo(a.price));
        break;
      case MealSortingOption.priceLowToHigh:
        state.sort((a, b) => a.price.compareTo(b.price));
        break;
    }
  }
}

final mealSortingProvider =
    StateNotifierProvider<MealSortingNotifier, List<Meal>>((ref) {
  final filteredMeals = ref.watch(filteredMealsProvider);
  return MealSortingNotifier(filteredMeals);
});
