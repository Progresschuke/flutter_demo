// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:meals_app/providers/favorite_meals_provider.dart';
// import 'package:meals_app/providers/meal_provider.dart';
// import 'package:meals_app/screens/category_screen.dart';
// import 'package:meals_app/screens/filters_screen.dart';
// import 'package:meals_app/screens/meals_screen.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

// const kInitialFilters = {
//   Filter.glutenFree: false,
//   Filter.lactoseFree: false,
//   Filter.vegetarian: false,
//   Filter.vegan: false,
// };

// class TabsScreen extends ConsumerStatefulWidget {
//   const TabsScreen({super.key});

//   @override
//   ConsumerState<TabsScreen> createState() {
//     return _TabsScreenState();
//   }
// }

// class _TabsScreenState extends ConsumerState<TabsScreen> {
//   var selectedPageIndex = 0;
//   Map<Filter, bool> _selectedFilters = kInitialFilters;

//   void _selectedPage(int index) {
//     setState(() {
//       selectedPageIndex = index;
//     });
//   }

//   // void toggleMealsFavorite(Meal meal) {

//   //   if (_favoriteMeals.contains(meal)) {
//   //     _favoriteMeals.remove(meal);
//   //   } else {
//   //     _favoriteMeals.add(meal);
//   //   }
//   // }

//   void showInfoMessage(String message) {
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ),
//     );
//   }

//   // void toggleMealsFavorite(Meal meal) {
//   //   final isExisting = _favoriteMeals.contains(meal);
//   //   if (isExisting) {
//   //     setState(() {
//   //       _favoriteMeals.remove(meal);
//   //       showInfoMessage('Meal removed from favorite.');
//   //     });
//   //   } else {
//   //     setState(() {
//   //       _favoriteMeals.add(meal);
//   //       showInfoMessage('Meal added as favorite!');
//   //     });
//   //   }
//   // }

//   // void toggleMealsFavorite(Meal meal) {
//   //   final mealIndex = _favoriteMeals.indexOf(meal);
//   //   final isExisting = _favoriteMeals.contains(meal);
//   //   if (isExisting) {
//   //     setState(() {
//   //       _favoriteMeals.remove(meal);
//   //     });
//   //     ScaffoldMessenger.of(context).clearSnackBars();
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //       content: const Text('Meal removed as Favorite!'),
//   //       action: SnackBarAction(
//   //           label: 'undo',
//   //           onPressed: () {
//   //             setState(() {
//   //               _favoriteMeals.insert(mealIndex, meal);
//   //             });
//   //           }),
//   //     ));
//   //   } else {
//   //     setState(() {
//   //       _favoriteMeals.add(meal);
//   //     });
//   //     ScaffoldMessenger.of(context).clearSnackBars();
//   //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//   //       content: Text('Meal added as Favorite!'),
//   //     ));
//   //   }
//   // }

//   void setScreen(String identifier) async {
//     Navigator.of(context).pop();
//     if (identifier == 'filters') {
//       final result = await Navigator.of(context).push<Map<Filter, bool>>(
//         MaterialPageRoute(
//           builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
//         ),
//       );

//       print(result);
//       setState(() {
//         _selectedFilters = result ?? kInitialFilters;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final favoriteMeals = ref.watch(favoriteMealProvider);
//     final meals = ref.watch(mealProvider);

//     final filteredMeals = meals.where((meal) {
//       if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
//         return false;
//       }
//       if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
//         return false;
//       }
//       if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
//         return false;
//       }
//       if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
//         return false;
//       }
//       return true;
//     }).toList();

//     Widget activePage = CategoryScreen(
//       availableMeals: filteredMeals,
//     );
//     var activePageTitle = 'categories';

//     if (selectedPageIndex == 1) {
//       setState(() {
//         activePage = MealsScreen(
//           meals: favoriteMeals,
//         );
//         activePageTitle = 'favorites';
//       });
//     }

//     return Scaffold(
//       drawer: MainDrawer(onSelectScreen: setScreen),
//       appBar: AppBar(
//         title: Text(activePageTitle),
//       ),
//       body: activePage,
//       bottomNavigationBar:
//           BottomNavigationBar(onTap: _selectedPage, items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.set_meal),
//           label: 'categories',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.set_meal),
//           label: 'Favorites',
//         ),
//       ]),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/providers/favorite_meals_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/providers/meal_provider.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealProvider);
    final meals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoryScreen(
      availableMeals: meals,
    );
    var activePageTitle = 'categories';

    if (selectedPageIndex == 1) {
      setState(() {
        activePage = MealsScreen(
          meals: favoriteMeals,
        );
        activePageTitle = 'favorites';
      });
    }

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: setScreen),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar:
          BottomNavigationBar(onTap: _selectedPage, items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.set_meal),
          label: 'categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.set_meal),
          label: 'Favorites',
        ),
      ]),
    );
  }
}
