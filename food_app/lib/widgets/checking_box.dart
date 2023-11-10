import 'package:flutter/material.dart';

class CheckingBox extends StatelessWidget {
  const CheckingBox({super.key, required this.onChanged, required this.value});

  final void Function(bool?) onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CheckboxListTile(
      checkColor: const Color(0xFF96BE05),
      activeColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 6 * size.width / 100,
        vertical: .01 * size.width / 100,
      ),
      title: Text(
        'Most Rated',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: const Color(0xFFAAA7A7),
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
