import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/data/hot_deals.dart';
import 'package:food_app/model/hot_deals.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/providers/filters_provider.dart';
import 'package:food_app/screens/filters.dart';
import 'package:food_app/screens/meal_details.dart';
import 'package:food_app/widgets/checking_box.dart';
import 'package:food_app/widgets/hero_carousel.dart';
import 'package:food_app/widgets/recommended_meal_item.dart';
import 'package:food_app/widgets/search_list/search_and_filter.dart';
import 'package:food_app/widgets/search_list/search_list_item.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:another_carousel_pro/another_carousel_pro.dart';

class HotDealsScreen extends ConsumerStatefulWidget {
  const HotDealsScreen({
    super.key,
  });

  @override
  ConsumerState<HotDealsScreen> createState() => _HotDealsScreenState();
}

class _HotDealsScreenState extends ConsumerState<HotDealsScreen> {
  // final foodList = ref.watch(filteredMealsProvider);
  var _ratingHighToLow = false;
  List<RecommendedMeal> meals = recommendedMeal;
  bool onSearch = false;
  final _titleController = TextEditingController();
  List<Meal> mealList = List.from(dummyMeals);

  @override
  void initState() {
    super.initState();
  }

  void searchFood() {
    setState(() {
      onSearch = true;
    });
  }

  void updateList(value) {
    String value = _titleController.text;
    // function that filters the foodlist
    setState(() {
      mealList = dummyMeals
          .where(
            (meal) =>
                meal.title.toLowerCase().contains(value.toLowerCase()) ||
                meal.category.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  void sortMealList(isChecked) {
    if (isChecked!) {
      setState(() {
        _ratingHighToLow = isChecked;
        mealList.sort((a, b) => b.rating.compareTo(a.rating));
      });
    } else {
      setState(() {
        _ratingHighToLow = false;
        mealList = List.from(dummyMeals);
      });
    }
  }

  void openFilterOverlay() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.background,
      useSafeArea: true,
      // isScrollControlled: true,
      context: context,
      builder: (ctx) =>
          FiltersScreen(onChanged: sortMealList, value: _ratingHighToLow),
    );
  }

  void viewMealDetails(Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(meal: meal),
      ),
    );
  }

  Future<bool> onPop() async {
    setState(() {
      onSearch = false;
      _titleController.clear();
      FocusScope.of(context).unfocus();
    });
    return false;
  }

  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFoodList = ref.watch(filteredMealsProvider);
    List<Meal> foodList = List.from(filteredFoodList);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: .5 * size.height / 100,
                horizontal: 5 * size.width / 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10 * size.height / 100,
                  child: RichText(
                    textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false),
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Yummy Flavors',
                          style: GoogleFonts.dancingScript(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 30,
                            height: 4,
                          ),
                        ),
                        TextSpan(
                          text: '\nWhat do you want to cook today?',
                          style: GoogleFonts.actor(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 3 * size.height / 100),

// For Food Search

                SearchAndFilter(
                  titleController: _titleController,
                  onPop: onPop,
                  onSearchFood: searchFood,
                  onUpdateList: updateList,
                  onTapFilters: openFilterOverlay,
                ),
              ],
            ),
          ),

//For foodList Search
          if (onSearch && mealList.isNotEmpty)
            CheckingBox(onChanged: sortMealList, value: _ratingHighToLow),
          if (onSearch && mealList.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: mealList.length,
                itemBuilder: (ctx, index) => SearchListItem(
                  onTapMeal: viewMealDetails,
                  meal: mealList[index],
                ),
              ),
            ),

          if (onSearch && mealList.isEmpty)
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10 * size.height / 100),
              child: Column(
                children: [
                  Text(
                    'Uh ohh... No meal found',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  SizedBox(
                    height: 1 * size.height / 100,
                  ),
                  Text(
                    'Try another term',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
            ),

//For food CarouselSlider
          if (!onSearch)
            Expanded(
              child: SizedBox(
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: .25 * size.height / 100,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: hotDealCat
                      .map((category) => HeroCarousel(category: category))
                      .toList(),
                ),
              ),
            ),
          if (!onSearch)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.air,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(
                    width: 8,
                  ),

// For Trending Foods

                  Text(
                    'Trending',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ],
              ),
            ),
          if (!onSearch)
            Expanded(
              child: ListView.builder(
                itemCount: meals.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) => RecommendedMealItem(
                  meal: meals[index],
                ),
              ),
            )
        ],
      ),
    );
  }
}
