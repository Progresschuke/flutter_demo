import 'package:flutter/material.dart';

class MealPrepDetails extends StatelessWidget {
  const MealPrepDetails({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: ListTile(
          minLeadingWidth: 4,
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary,
            ),
            height: 10,
            width: 10,
          ),
          title: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 17,
                ),
          ),
        ),
      ),
    );
  }
}
