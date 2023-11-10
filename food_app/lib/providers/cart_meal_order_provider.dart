import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/model/meal.dart';

class CartMealNotifier extends StateNotifier<List<Meal>> {
  CartMealNotifier() : super([]);

  bool toggleCartMeal(Meal meal) {
    final mealIsInCart = state.contains(meal);

    if (mealIsInCart) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }

  void removeMealFromCart(Meal meal) {
    state = state.where((m) => m.id != meal.id).toList();
  }
}

final cartMealProvider = StateNotifierProvider<CartMealNotifier, List<Meal>>(
    (ref) => CartMealNotifier());

//created to toggle the add-to-cart button

class ToggleCartButtonNotifier extends StateNotifier<bool> {
  ToggleCartButtonNotifier() : super(true);

  void toggleCartButtonTrue() {
    state = true;
  }

  void toggleCartButtonFalse() {
    state = false;
  }

  void toggleCartButton() {
    state = !state;
  }
}

final toggleCartButtonProvider =
    StateNotifierProvider<ToggleCartButtonNotifier, bool>((ref) {
  return ToggleCartButtonNotifier();
});
