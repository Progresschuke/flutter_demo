import 'package:flutter/material.dart';

class CartQtyButton extends StatelessWidget {
  const CartQtyButton({
    super.key,
    required this.color1,
    required this.color2,
    required this.text,
    required this.onReduceQty,
    required this.onIncreaseQty,
  });

  final Color color1;
  final Color color2;
  final String text;
  final void Function() onReduceQty;
  final void Function() onIncreaseQty;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4 * size.width / 100,
        vertical: 0.8 * size.height / 100,
      ),
      child: Row(
        children: [
          MiniButton(
              color: color1, onTap: onReduceQty, icon: Icons.remove_outlined),
          SizedBox(
            width: 1 * size.width / 100,
          ),
          Text(text,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w300)),
          SizedBox(
            width: 1 * size.width / 100,
          ),
          MiniButton(
            color: color2,
            onTap: onIncreaseQty,
            icon: Icons.add,
          ),
        ],
      ),
    );
  }
}

class MiniButton extends StatelessWidget {
  const MiniButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.onTap});

  final Color color;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 3.5 * size.height / 100,
        width: 7 * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}
