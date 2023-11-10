import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key, required this.onSelectPage});

  final void Function(int index) onSelectPage;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(onTap: onSelectPage, items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.set_meal),
        label: 'Featured',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.food_bank),
        label: 'Favorites',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.restaurant_menu),
        label: 'Categories',
      ),
    ]);
  }
}
