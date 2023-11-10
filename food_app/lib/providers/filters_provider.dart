import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/data/dummy_data.dart';

enum Filter {
  salads,
  soups,
  beef,
  pasta,
  seafoods,
  dessert,
  chops,
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
  mostRated,
  highToLow,
  lowToHigh,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.salads: false,
          Filter.chops: false,
          Filter.seafoods: false,
          Filter.soups: false,
          Filter.pasta: false,
          Filter.beef: false,
          Filter.dessert: false,
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
          Filter.mostRated: false,
          Filter.highToLow: false,
          Filter.lowToHigh: false
        });

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
        (ref) => FilterNotifier());

final filteredMealsProvider = Provider((ref) {
  const meals = dummyMeals;
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.salads]! && meal.category != 'Salads') {
      return false;
    }
    if (activeFilters[Filter.soups]! && meal.category != 'Soups') {
      return false;
    }
    if (activeFilters[Filter.beef]! && meal.category != 'Beef') {
      return false;
    }
    if (activeFilters[Filter.chops]! && meal.category != 'Chops') {
      return false;
    }
    if (activeFilters[Filter.seafoods]! && meal.category != 'Seafoods') {
      return false;
    }
    if (activeFilters[Filter.pasta]! && meal.category != 'Pasta') {
      return false;
    }
    if (activeFilters[Filter.dessert]! && meal.category != 'Dessert') {
      return false;
    }
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }

    // if (activeFilters[Filter.lowToHigh]!) {
    //   final sortedMeals = List.from(meals);
    //   sortedMeals.sort();
    //   return sortedMeals;
    // }

    return true;
  }).toList();
});
