import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(200, 63, 28, 38),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.spoke_rounded,
                  size: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Food is Ready!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 28,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              onSelectScreen('meals');
            },
            leading: Icon(
              Icons.restaurant,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            contentPadding: const EdgeInsets.only(left: 20, top: 10),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 28,
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
                    fontSize: 28,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
