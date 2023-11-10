import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:food_app/model/hot_deals.dart';
import 'package:food_app/widgets/rating/rating.dart';

class RecommendedMealItem extends StatelessWidget {
  const RecommendedMealItem({
    required this.meal,
    super.key,
  });

  final RecommendedMeal meal;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final rate = double.tryParse(meal.rating);
    return Card(
      margin: const EdgeInsets.all(8.0),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: meal.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 50 * size.width / 100,
                height: 40 * size.height / 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                color: Theme.of(context).colorScheme.onBackground,
                width: 50 * size.width / 100,
                height: 40 * size.height / 100,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.background,
                )),
              ),
              errorWidget: (context, url, error) => SizedBox(
                width: 50 * size.width / 100,
                height: 40 * size.height / 100,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Unable to load images',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 16),
                    ),
                    Text(
                      'Please cheeck your connection',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 12),
                    ),
                  ],
                )),
              ),
            ),
            Positioned(
              top: .8 * size.height / 100,
              right: 2 * size.height / 100,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black54,
                  ),
                  height: 5 * size.height / 100,
                  width: 5 * size.height / 100,
                  child: const Icon(Icons.star, color: Colors.amber)),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RatingStar(rating: 5, ratingCount: 12),
                    Text(
                      meal.title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
