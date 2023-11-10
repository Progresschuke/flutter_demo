import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:food_app/model/meal.dart';

class SearchListItem extends StatelessWidget {
  const SearchListItem({
    super.key,
    required this.meal,
    required this.onTapMeal,
  });

  final Meal meal;
  final void Function(Meal meal) onTapMeal;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1 * size.height / 100),
      margin: EdgeInsets.symmetric(horizontal: 4 * size.width / 100),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.background,
        onTap: () {
          onTapMeal(meal);
        },
        minLeadingWidth: 4 * size.width / 100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        title: Text(
          meal.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text(
          meal.category,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        trailing: Text(
          '${meal.rating}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: const Color(0xFFF1B602),
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: CachedNetworkImage(
          imageUrl: meal.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            width: 20 * size.width / 100,
            height: 20 * size.width / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => SizedBox(
            width: 20 * size.width / 100,
            height: 10 * size.width / 100,
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => SizedBox(
            width: 20 * size.width / 100,
            height: 10 * size.width / 100,
            child: const Center(child: Icon(Icons.error)),
          ),
        ),
      ),
    );
  }
}
