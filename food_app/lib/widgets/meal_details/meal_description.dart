import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:food_app/model/meal.dart';
import 'package:food_app/providers/cart_meal_order_provider.dart';
import 'package:food_app/widgets/meal_details/meal_details_trait.dart';
import 'package:food_app/widgets/rating/rating.dart';
import 'package:intl/intl.dart';

class MealDescription extends ConsumerWidget {
  const MealDescription({
    super.key,
    required this.meal,
    required this.favoriteIconColor,
    required this.onAddToFavorite,
    required this.onAddToCart,
  });

  final Meal meal;

  final Color favoriteIconColor;
  final void Function() onAddToFavorite;
  final void Function() onAddToCart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final value = NumberFormat('#,###');
    bool toggleCartButton = ref.watch(toggleCartButtonProvider);

    return Stack(
      children: [
        Hero(
          tag: meal.id,
          child: CachedNetworkImage(
            imageUrl: meal.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              height: 40 * size.height / 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => SizedBox(
              width: double.infinity,
              height: 20 * size.height / 100,
              child: const Center(child: CircularProgressIndicator()),
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
          right: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(202, 10, 10, 10),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(4),
              child: IconButton(
                onPressed: onAddToFavorite,
                icon: const Icon(Icons.favorite),
                color: favoriteIconColor,
              ),
            ),
          ),
        ),
        // Positioned(
        //   bottom: 0,
        //   right: 0,
        //   left: 0,
        //   top: 20,
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        //     child: Container(
        //       color: Colors.white.withOpacity(0.0),
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Colors.black54,
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      meal.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/naira.png',
                          height: 24,
                          color: Colors.white,
                        ),
                        Text(
                          value.format(meal.price),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                RatingStar(rating: meal.rating, ratingCount: 12),
                const SizedBox(height: 8),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      MealDetailsTrait(
                          value: '${meal.duration}', text: 'Minutes'),
                      const VerticalDivider(
                        color: Colors.white,
                        endIndent: 5,
                        indent: 5,
                        thickness: 0.4,
                      ),
                      MealDetailsTrait(value: meal.calories, text: 'Calories'),
                      const Spacer(),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.primaryContainer),
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer)),
                        onPressed: () {
                          ref
                              .read(toggleCartButtonProvider.notifier)
                              .toggleCartButton();
                          onAddToCart();
                        },
                        child: Text(toggleCartButton
                            ? 'Add to cart'
                            : 'Remove from cart'),
                      ),
                      // if (toggleCartButton == false)
                      //   ElevatedButton(
                      //       style: ButtonStyle(
                      //           backgroundColor: MaterialStateProperty.all(
                      //               Theme.of(context)
                      //                   .colorScheme
                      //                   .primaryContainer),
                      //           foregroundColor: MaterialStateProperty.all(
                      //               Theme.of(context)
                      //                   .colorScheme
                      //                   .onPrimaryContainer)),
                      //       onPressed: () {
                      //         ref
                      //             .read(toggleCartButtonProvider.notifier)
                      //             .toggleCartButtonTrue();
                      //         // onAddToCart();
                      //       },
                      //       child: Text('Remove from cart')),
                      // if (toggleCartButton == true)
                      //   ElevatedButton(
                      //       style: ButtonStyle(
                      //           backgroundColor: MaterialStateProperty.all(
                      //               Theme.of(context)
                      //                   .colorScheme
                      //                   .primaryContainer),
                      //           foregroundColor: MaterialStateProperty.all(
                      //               Theme.of(context)
                      //                   .colorScheme
                      //                   .onPrimaryContainer)),
                      //       onPressed: () {
                      //         ref
                      //             .read(toggleCartButtonProvider.notifier)
                      //             .toggleCartButtonFalse();
                      //         // onAddToCart();
                      //       },
                      //       child: Text('add cart'))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
