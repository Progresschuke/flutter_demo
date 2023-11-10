import 'package:flutter/material.dart';

class FilterFoodChip extends StatelessWidget {
  const FilterFoodChip({
    super.key,
    required this.title,
    required this.onSelected,
    required this.selected,
  });

  final bool selected;
  final String title;
  final void Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FilterChip(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      labelPadding: EdgeInsets.symmetric(
        horizontal: .4 * size.width / 100,
        vertical: .2 * size.width / 100,
      ),
      selected: selected,
      checkmarkColor: Theme.of(context).colorScheme.background,
      showCheckmark: true,
      label: Text(title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.background)),
      selectedColor:
          Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
      onSelected: onSelected,
    );
  }
}
