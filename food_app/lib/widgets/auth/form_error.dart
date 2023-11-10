import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({super.key, required this.errors});

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: List.generate(
          errors.length,
          (index) => Row(
                children: [
                  Image.asset(
                    'assets/images/failed.png',
                    height: 3 * size.height / 100,
                    width: 3 * size.width / 100,
                  ),
                  SizedBox(width: 3 * size.width / 100),
                  Text(errors[index]!)
                ],
              )),
    );
  }
}
