// With Filters Provider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:food_app/providers/filters_provider.dart';
import 'package:food_app/widgets/search_list/filter_food_chip.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
    required this.onChanged,
    required this.value,
  });

  final void Function(bool?) onChanged;
  final bool value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final activeFilter = ref.watch(filtersProvider);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 7 * size.width / 100,
        vertical: 8 * size.width / 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cuisines',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          SizedBox(
            height: 1.5 * size.height / 100,
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 2 * size.width / 100,
            children: [
              FilterFoodChip(
                  title: 'Salads',
                  selected: activeFilter[Filter.salads]!,
                  onSelected: (isChecked) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.salads, isChecked);
                  }),
              FilterFoodChip(
                  title: 'Soups',
                  selected: activeFilter[Filter.soups]!,
                  onSelected: (isChecked) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.soups, isChecked);
                  }),
              FilterFoodChip(
                  title: 'Beef',
                  selected: activeFilter[Filter.beef]!,
                  onSelected: (isChecked) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.beef, isChecked);
                  }),
              FilterFoodChip(
                  title: 'Chops',
                  selected: activeFilter[Filter.chops]!,
                  onSelected: (isChecked) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.chops, isChecked);
                  }),
              FilterFoodChip(
                  title: 'Seafoods',
                  selected: activeFilter[Filter.seafoods]!,
                  onSelected: (isChecked) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.seafoods, isChecked);
                  }),
              FilterFoodChip(
                  title: 'Pasta',
                  selected: activeFilter[Filter.pasta]!,
                  onSelected: (isChecked) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.pasta, isChecked);
                  }),
              FilterFoodChip(
                  title: 'Dessert',
                  selected: activeFilter[Filter.dessert]!,
                  onSelected: (isChecked) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.dessert, isChecked);
                  }),
            ],
          ),
          SizedBox(
            height: 4 * size.height / 100,
          ),
          Text(
            'Sort category list by',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          SizedBox(
            height: 1.5 * size.height / 100,
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 2 * size.width / 100,
            children: [
              FilterFoodChip(
                  title: 'Gluten-free',
                  selected: activeFilter[Filter.glutenFree]!,
                  onSelected: (isChecked) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.glutenFree, isChecked);
                  }),
              FilterFoodChip(
                  title: 'Lactose-free',
                  selected: activeFilter[Filter.lactoseFree]!,
                  onSelected: (isChecked) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.lactoseFree, isChecked);
                  }),
              FilterFoodChip(
                  title: 'Vegan',
                  selected: activeFilter[Filter.vegan]!,
                  onSelected: (isChecked) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.vegan, isChecked);
                  }),
              FilterFoodChip(
                  title: 'Vegetarian',
                  selected: activeFilter[Filter.vegetarian]!,
                  onSelected: (isChecked) {
                    ref
                        .read(filtersProvider.notifier)
                        .setFilter(Filter.vegetarian, isChecked);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}


//Without FiltersProvider
// import 'package:flutter/material.dart';

// import 'package:food_app/data/dummy_data.dart';
// import 'package:food_app/model/category.dart';

// class FiltersScreen extends StatefulWidget {
//   const FiltersScreen({super.key});

//   @override
//   State<FiltersScreen> createState() => _FiltersScreenState();
// }

// class _FiltersScreenState extends State<FiltersScreen> {
//   List<Category> filteredCategories = [];
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: 7 * size.width / 100,
//         vertical: 8 * size.width / 100,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Cuisines',
//             style: Theme.of(context)
//                 .textTheme
//                 .titleLarge!
//                 .copyWith(color: Theme.of(context).colorScheme.background),
//           ),
//           SizedBox(
//             height: 1.5 * size.height / 100,
//           ),
//           Wrap(
//             direction: Axis.horizontal,
//             spacing: 2 * size.width / 100,
//             children: [
//               for (final category in availableCategories)
//                 FilterChip(
//                   selectedColor: const Color(0xFF979696).withOpacity(0.3),
//                   elevation: 2,
//                   showCheckmark: true,
//                   selected: filteredCategories.contains(category),
//                   label: Text(category.title,
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyLarge!
//                           .copyWith(color: Colors.white)),
//                   backgroundColor: const Color(0xFF979696).withOpacity(0.7),
//                   onSelected: (selected) {
//                     setState(() {
//                       if (selected) {
//                         filteredCategories.add(category);
//                       } else {
//                         filteredCategories.remove(category);
//                       }
//                     });
//                   },
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
