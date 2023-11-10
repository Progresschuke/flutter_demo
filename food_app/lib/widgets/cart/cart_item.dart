import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:food_app/model/meal.dart';
import 'package:food_app/providers/cart_meal_order_provider.dart';
import 'package:food_app/widgets/cart/cart_qty_button.dart';

class CartItem extends ConsumerStatefulWidget {
  const CartItem({super.key, required this.meal});

  final Meal meal;

  @override
  ConsumerState<CartItem> createState() => _CartItemState();
}

class _CartItemState extends ConsumerState<CartItem> {
  int qty = 1;

  void reduceQty() {
    if (qty > 1) {
      setState(() {
        qty--;
      });
    }
  }

  void increaseQty() {
    setState(() {
      qty++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final meal = widget.meal;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 4 * size.width / 100,
        vertical: 0.8 * size.height / 100,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3 * size.width / 100,
          vertical: 1 * size.height / 100,
        ),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 10 * size.height / 100,
              width: 10 * size.height / 100,
              decoration: BoxDecoration(
                border: Border.all(
                    style: BorderStyle.solid,
                    color: Theme.of(context).colorScheme.onBackground),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(meal.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 4 * size.width / 100),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40 * size.width / 100,
                  child: Text(
                    widget.meal.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 1 * size.height / 100),
                CartQtyButton(
                  color1: Theme.of(context).colorScheme.primary,
                  color2: Theme.of(context).colorScheme.primary,
                  text: qty > 9 ? '$qty' : '0$qty',
                  onReduceQty: reduceQty,
                  onIncreaseQty: increaseQty,
                ),
              ],
            ),
            SizedBox(width: 4 * size.width / 100),
            Column(
              children: [
                Text(
                  '\$${meal.price * qty}',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 17),
                ),
                IconButton(
                  onPressed: () {
                    ref
                        .read(cartMealProvider.notifier)
                        .removeMealFromCart(meal);

                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Meal removed from cart',
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.redAccent.withOpacity(0.6),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
