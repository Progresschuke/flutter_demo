//Raw file using dismissible widget to remove meals from cart
import 'package:flutter/material.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/screens/payment/proceed_payment.dart';
import 'package:food_app/widgets/cart/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.meals});

  final List<Meal> meals;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String get calculateTotal {
    double totalPrice = 0;
    for (final meal in widget.meals) {
      totalPrice += meal.price;
    }
    return totalPrice.toStringAsFixed(2);
  }

  double get totalPrice {
    double totalPrice = 0;
    for (final meal in widget.meals) {
      totalPrice += meal.price;
    }
    return totalPrice;
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
                  child: CartItem(meal: widget.meals[index])),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.w300)),
                      Text('\$$totalPrice',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.w300)),
                    ],
                  ),
                  SizedBox(
                    height: 4 * size.height / 100,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                            Size.fromWidth(60 * size.width / 100)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary)),
                    onPressed: () {
                      proceedPayment(context);
                    },
                    child: Text('Checkout',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w300)),
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
          title: const Text('Your Cart'),
        ),
        body: content,
      ),
    );
  }
}
