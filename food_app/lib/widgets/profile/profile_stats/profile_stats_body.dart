import 'package:flutter/material.dart';

class ProfileStatsBody extends StatelessWidget {
  const ProfileStatsBody({
    super.key,
    required this.title,
    required this.stats,
  });

  final String title;
  final String stats;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(2 * size.height / 100),
      child: Padding(
        padding: EdgeInsets.all(2 * size.height / 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            SizedBox(height: 3 * size.height / 100),
            Text(
              stats,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
