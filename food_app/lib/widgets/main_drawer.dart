import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectScreen,
  });

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 10,
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.only(bottom: 2, top: 70, left: 20),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/food.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black54,
                BlendMode.darken,
              ),
            )),
            child: Row(
              children: [
                const Icon(Icons.food_bank_rounded),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Food is Ready!',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white, fontSize: 26),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              onSelectScreen('cart');
            },
            leading: Icon(
              Icons.add_shopping_cart,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            contentPadding: const EdgeInsets.only(left: 20, top: 10),
            title: Text(
              'Cart',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 26,
                  ),
            ),
          ),
          ListTile(
            onTap: () {
              onSelectScreen('filters');
            },
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            contentPadding: const EdgeInsets.only(left: 20, top: 10),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 26,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
