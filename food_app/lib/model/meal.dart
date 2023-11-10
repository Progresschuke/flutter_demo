enum Complexity {
  simple,
  challenging,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

class Meal {
  const Meal({
    required this.id,
    required this.title,
    required this.duration,
    required this.price,
    required this.rating,
    required this.calories,
    required this.affordability,
    required this.complexity,
    required this.category,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final String title;
  final int duration;
  final double price;
  final double rating;
  final String calories;
  final Affordability affordability;
  final Complexity complexity;
  final String category;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
}
