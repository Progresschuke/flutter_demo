import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';

class FavoriteMealProvider extends StateNotifier<List<Meal>> {
  FavoriteMealProvider() : super([]);

  bool toggleMealsFavoriteStatus(Meal meal) {
    final mealIsFave = state.contains(meal);

    if (mealIsFave) {
      state = state.where((thisMeal) => thisMeal.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoriteMealProvider, List<Meal>>(
        (ref) => FavoriteMealProvider());
