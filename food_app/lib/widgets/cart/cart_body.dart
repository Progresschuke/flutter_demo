//Raw file using dismissible widget to remove meals from cart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:food_app/model/meal.dart';
import 'package:food_app/screens/payment/proceed_payment.dart';
import 'package:food_app/widgets/cart/cart_qty_button.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key, required this.meals});

  final List<Meal> meals;

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  final value = NumberFormat("#,###");
  int qty = 1;
  String get calculateTotal {
    double totalPrice = 0;
    for (final meal in widget.meals) {
      totalPrice += meal.price * qty;
    }
    return totalPrice.toStringAsFixed(0);
  }

  double get totalPrice {
    double totalPrice = 0;
    for (final meal in widget.meals) {
      totalPrice += meal.price * qty;
    }
    return totalPrice;
  }

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

  void proceedPayment(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ProceedPayment(amountTag: '$totalPrice'),
      ),
    );
  }

  void removeMeal(Meal meal) {
    final meals = widget.meals;
    final mealIndex = meals.indexOf(meal);
    setState(() {
      meals.remove(meal);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Meal removed from cart.'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              meals.insert(mealIndex, meal);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final meals = widget.meals;
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No meals added yet!',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          Text('Try adding some...',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
        ],
      ),
    );

    if (widget.meals.isNotEmpty) {
      content = Column(
        children: [
// List of Meals in Cart
          Expanded(
            child: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(widget.meals[index]),
                onDismissed: (direction) => removeMeal(meals[index]),
                child: Padding(
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
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(meals[index].imageUrl),
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
                                widget.meals[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
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
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/naira.png',
                                  height: 12,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                Text(
                                  value.format(meals[index].price),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

//total amount + pay now
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4 * size.width / 100,
              vertical: 5 * size.height / 100,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4 * size.width / 100,
                vertical: 3 * size.height / 100,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Total',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  fontSize: 32,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.w700)),
                      SizedBox(width: 0.4 * size.width),
                      Image.asset(
                        'assets/images/naira.png',
                        height: 22,
                        color: Colors.black,
                      ),
                      SizedBox(width: 0.01 * size.width),
                      Text(value.format(totalPrice),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  fontSize: 32,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 4 * size.height / 100,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                          Size(0.8 * size.width, 0.05 * size.height)),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      proceedPayment(context);
                    },
                    child: Text(
                      'Checkout',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Your Cart'),
        ),
        body: content,
      ),
    );
  }
}
