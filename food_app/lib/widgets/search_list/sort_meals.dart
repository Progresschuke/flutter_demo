import 'package:flutter/material.dart';

class SortMeals extends StatelessWidget {
  const SortMeals({
    super.key,
    required this.onChanged,
    required this.value,
  });

  final void Function(bool?) onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      alignment: AlignmentDirectional.topStart,
      child: Column(
        children: [
          CheckboxListTile(
            checkColor: const Color(0xFF0E4E01),
            activeColor: Colors.transparent,
            contentPadding: EdgeInsets.symmetric(
              horizontal: .2 * size.width / 100,
              vertical: .01 * size.width / 100,
            ),
            title: Text(
              'Most Rated',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: const Color(0xFF5A5959),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
            ),
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}




// Raw Files
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:food_app/providers/filters_provider.dart';

// class SortMeals extends ConsumerWidget {
//   const SortMeals({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     Size size = MediaQuery.of(context).size;
//     final activeFilter = ref.watch(filtersProvider);
//     final meals = ref.watch(filteredMealsProvider);

//     return Container(
//       alignment: AlignmentDirectional.topStart,
//       child: Column(
//         children: [
//           CheckboxListTile(
//               checkColor: const Color(0xFF0E4E01),
//               activeColor: Colors.transparent,
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: .2 * size.width / 100,
//                 vertical: .01 * size.width / 100,
//               ),
//               title: Text(
//                 'Most Rated',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                       color: const Color(0xFF5A5959),
//                       fontSize: 20,
//                       fontWeight: FontWeight.w300,
//                     ),
//               ),
//               value: activeFilter[Filter.mostRated]!,
//               onChanged: (isChecked) {
//                 ref
//                     .read(filtersProvider.notifier)
//                     .setFilter(Filter.mostRated, isChecked!);
//               }),
//           CheckboxListTile(
//               checkColor: const Color(0xFF0E4E01),
//               activeColor: Colors.transparent,
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: .2 * size.width / 100,
//                 vertical: .01 * size.width / 100,
//               ),
//               title: Text(
//                 'High to Low',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                       color: const Color(0xFF5A5959),
//                       fontSize: 20,
//                       fontWeight: FontWeight.w300,
//                     ),
//               ),
//               value: activeFilter[Filter.highToLow]!,
//               onChanged: (isChecked) {
//                 ref
//                     .read(filtersProvider.notifier)
//                     .setFilter(Filter.highToLow, isChecked!);
                    
//                     if(isChecked) {
//                       meals.sort((a, b) => b.rating.compareTo(a.rating));
//                     }
                    
//               }),
//           CheckboxListTile(
//               checkColor: const Color(0xFF0E4E01),
//               activeColor: Colors.transparent,
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: .2 * size.width / 100,
//                 vertical: .01 * size.width / 100,
//               ),
//               title: Text(
//                 'Low to High',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                       color: const Color(0xFF5A5959),
//                       fontSize: 20,
//                       fontWeight: FontWeight.w300,
//                     ),
//               ),
//               value: activeFilter[Filter.lowToHigh]!,
//               onChanged: (isChecked) {
//                 ref
//                     .read(filtersProvider.notifier)
//                     .setFilter(Filter.lowToHigh, isChecked!);
//               }),
//         ],
//       ),
//     );
//   }
// }






// Using MealSortingProvider
// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:food_app/model/meal.dart';
// import 'package:food_app/providers/meal_sort_provider.dart';

// class SortMeals extends ConsumerWidget {
//   const SortMeals({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     Size size = MediaQuery.of(context).size;
//     List<Meal> mealSortingNotifier = ref.watch(mealSortingProvider);

//     bool ratingHighToLow =
//         mealSortingNotifier == MealSortingOption.ratingHighToLow;

//     return Container(
//       alignment: AlignmentDirectional.topStart,
//       child: Column(
//         children: [
//           CheckboxListTile(
//               checkColor: const Color(0xFF0E4E01),
//               activeColor: Colors.transparent,
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: .2 * size.width / 100,
//                 vertical: .01 * size.width / 100,
//               ),
//               title: Text(
//                 'Most Rated',
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                       color: const Color(0xFF5A5959),
//                       fontSize: 20,
//                       fontWeight: FontWeight.w300,
//                     ),
//               ),
//               value: ratingHighToLow,
//               onChanged: (value) {
//                 if (value!) {
//                   ref
//                       .read(mealSortingProvider.notifier)
//                       .sortMeals(MealSortingOption.ratingHighToLow);
//                 }
//               }),
//           // CheckboxListTile(
//           //     checkColor: const Color(0xFF0E4E01),
//           //     activeColor: Colors.transparent,
//           //     contentPadding: EdgeInsets.symmetric(
//           //       horizontal: .2 * size.width / 100,
//           //       vertical: .01 * size.width / 100,
//           //     ),
//           //     title: Text(
//           //       'High to Low',
//           //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//           //             color: const Color(0xFF5A5959),
//           //             fontSize: 20,
//           //             fontWeight: FontWeight.w300,
//           //           ),
//           //     ),
//           //     value: activeFilter[Filter.highToLow]!,
//           //     onChanged: (isChecked) {
//           //       ref
//           //           .read(filtersProvider.notifier)
//           //           .setFilter(Filter.highToLow, isChecked!);
//           //     }),
//           // CheckboxListTile(
//           //     checkColor: const Color(0xFF0E4E01),
//           //     activeColor: Colors.transparent,
//           //     contentPadding: EdgeInsets.symmetric(
//           //       horizontal: .2 * size.width / 100,
//           //       vertical: .01 * size.width / 100,
//           //     ),
//           //     title: Text(
//           //       'Low to High',
//           //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//           //             color: const Color(0xFF5A5959),
//           //             fontSize: 20,
//           //             fontWeight: FontWeight.w300,
//           //           ),
//           //     ),
//           //     value: activeFilter[Filter.lowToHigh]!,
//           //     onChanged: (isChecked) {
//           //       ref
//           //           .read(filtersProvider.notifier)
//           //           .setFilter(Filter.lowToHigh, isChecked!);
//           //     }),
//         ],
//       ),
//     );
//   }
// }
