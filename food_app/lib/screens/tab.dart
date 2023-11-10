import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/bottom_sheet_provider.dart';
import 'package:food_app/providers/cart_meal_order_provider.dart';
import 'package:food_app/providers/favorite_meal_provider.dart';
import 'package:food_app/providers/filters_provider.dart';

import 'package:food_app/screens/categories.dart';
import 'package:food_app/screens/hot_deals.dart';
import 'package:food_app/screens/meals.dart';
import 'package:food_app/screens/profile.dart';
import 'package:food_app/widgets/bottom_navbar.dart';
import 'package:food_app/widgets/cart/cart_body.dart';
import 'package:food_app/widgets/main_drawer.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    final mealInCart = ref.watch(cartMealProvider);
    final filteredMeals = ref.watch(filteredMealsProvider);
    Navigator.of(context).pop();
    if (identifier == 'cart') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => CartBody(
            meals: mealInCart,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomSheetState = ref.watch(bottomSheetProvider);
    final filteredMeals = ref.watch(filteredMealsProvider);
    final favoriteMeal = ref.watch(favoriteMealProvider);
    final mealInCart = ref.watch(cartMealProvider);

    Widget activePage = const HotDealsScreen();

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favoriteMeal,
      );
    }

    if (_selectedPageIndex == 2) {
      activePage = CategoriesScreen(
        availableMeals: filteredMeals,
      );
    }

    void showBottomSheet(BuildContext context) async {
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      final firstName = userData.data()!['firstName'];
      final lastName = userData.data()!['lastName'];

      if (mounted) {}
      if (bottomSheetState) {
        showModalBottomSheet(
          isDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Welcome back $firstName $lastName'),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(bottomSheetProvider.notifier)
                          .removeBottomSheet();
                      Navigator.of(context).pop(); // Dismiss the bottom sheet
                    },
                    child: const Text('Check Trending Meals'),
                  ),
                ],
              ),
            );
          },
        );
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showBottomSheet(
          context); // Show the bottom sheet after the screen is built
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
              },
              icon: const Icon(Icons.manage_accounts))
        ],
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavbar(
        onSelectPage: _selectPage,
      ),
      body: activePage,
    );
  }
}
