import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:food_app/model/meal.dart';
import 'package:food_app/widgets/meal_item/meal_item_traits.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: (Stack(
          children: [
            Hero(
              tag: meal.id,
              child: CachedNetworkImage(
                imageUrl: meal.imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: 20 * size.height / 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.5),
                  width: double.infinity,
                  height: 20 * size.height / 100,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.background,
                  )),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  width: double.infinity,
                  height: 20 * size.height / 100,
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
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealTraits(
                          icon: Icons.schedule,
                          label: ('${meal.duration} min'),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        MealTraits(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        MealTraits(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
