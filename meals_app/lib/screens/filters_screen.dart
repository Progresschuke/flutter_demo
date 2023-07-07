// import 'package:flutter/material.dart';
// import 'package:meals_app/screens/tabs_screen.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

// enum Filter {
//   glutenFree,
//   lactoseFree,
//   vegetarian,
//   vegan,
// }

// class FiltersScreen extends StatefulWidget {
//   const FiltersScreen({super.key, required this.currentFilters});

//   final Map<Filter, bool> currentFilters;

//   @override
//   State<FiltersScreen> createState() {
//     return _FiltersScreenState();
//   }
// }

// class _FiltersScreenState extends State<FiltersScreen> {
//   var _glutenFreeFilter = false;
//   var _lactoseFreeFilter = false;
//   var _vegetarianFilter = false;
//   var _veganFilter = false;

//   @override
//   void initState() {
//     super.initState();
//     _glutenFreeFilter = widget.currentFilters[Filter.glutenFree]!;
//     _lactoseFreeFilter = widget.currentFilters[Filter.lactoseFree]!;
//     _vegetarianFilter = widget.currentFilters[Filter.vegetarian]!;
//     _veganFilter = widget.currentFilters[Filter.vegan]!;
//   }

//   void _setScreen(String identifier) {
//     Navigator.of(context).pop();
//     if (identifier == 'meals') {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (ctx) => const TabsScreen(),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Filters'),
//       ),
//       drawer: MainDrawer(onSelectScreen: _setScreen),
//       body: WillPopScope(
//         onWillPop: () async {
//           Navigator.of(context).pop(
//             {
//               Filter.glutenFree: _glutenFreeFilter,
//               Filter.lactoseFree: _lactoseFreeFilter,
//               Filter.vegetarian: _vegetarianFilter,
//               Filter.vegan: _veganFilter,
//             },
//           );
//           return false;
//         },
//         child: Column(
//           children: [
//             SwitchListTile(
//               value: _glutenFreeFilter,
//               onChanged: (isChecked) {
//                 setState(() {
//                   _glutenFreeFilter = isChecked;
//                 });
//               },
//               activeColor: Theme.of(context).colorScheme.primary,
//               contentPadding: const EdgeInsets.only(left: 34, right: 22),
//               title: Text(
//                 'Gluten-Free',
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground),
//               ),
//               subtitle: Text(
//                 'only include gluten-free meals',
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//             ),
//             SwitchListTile(
//               value: _lactoseFreeFilter,
//               onChanged: (isChecked) {
//                 setState(() {
//                   _lactoseFreeFilter = isChecked;
//                 });
//               },
//               activeColor: Theme.of(context).colorScheme.primary,
//               contentPadding: const EdgeInsets.only(left: 34, right: 22),
//               title: Text(
//                 'Lactose-Free',
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground),
//               ),
//               subtitle: Text(
//                 'only include lactose-free meals',
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//             ),
//             SwitchListTile(
//               value: _vegetarianFilter,
//               onChanged: (isChecked) {
//                 setState(() {
//                   _vegetarianFilter = isChecked;
//                 });
//               },
//               activeColor: Theme.of(context).colorScheme.primary,
//               contentPadding: const EdgeInsets.only(left: 34, right: 22),
//               title: Text(
//                 'Vegetarian',
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground),
//               ),
//               subtitle: Text(
//                 'only include vegetarian meals',
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//             ),
//             SwitchListTile(
//               value: _veganFilter,
//               onChanged: (isChecked) {
//                 setState(() {
//                   _veganFilter = isChecked;
//                 });
//               },
//               activeColor: Theme.of(context).colorScheme.primary,
//               contentPadding: const EdgeInsets.only(left: 34, right: 22),
//               title: Text(
//                 'Vegan',
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground),
//               ),
//               subtitle: Text(
//                 'only include vegan meals',
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilter[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
            title: Text(
              'Gluten-Free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'only include gluten-free meals',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          SwitchListTile(
            value: activeFilter[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
            title: Text(
              'Lactose-Free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'only include lactose-free meals',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          SwitchListTile(
            value: activeFilter[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
            title: Text(
              'Vegetarian',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'only include vegetarian meals',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
          SwitchListTile(
            value: activeFilter[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
            title: Text(
              'Vegan',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'only include vegan meals',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
