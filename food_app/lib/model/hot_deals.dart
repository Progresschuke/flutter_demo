class HotDealCategory {
  const HotDealCategory({required this.imageUrl, required this.title});

  final String imageUrl;
  final String title;
}

class RecommendedMeal {
  const RecommendedMeal({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
  });

  final String imageUrl;
  final String title;
  final String price;
  final String rating;
}
