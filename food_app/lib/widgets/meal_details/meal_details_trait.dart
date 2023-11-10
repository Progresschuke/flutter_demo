import 'package:flutter/material.dart';

class MealDetailsTrait extends StatelessWidget {
  const MealDetailsTrait({super.key, required this.value, required this.text});

  final String value;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 3),
        Text(text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
