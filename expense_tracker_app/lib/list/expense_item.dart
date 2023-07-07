import 'package:flutter/material.dart';

import 'package:expense_tracker_app/model/expense_structure.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Text(
              expense.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: const Color.fromARGB(255, 6, 16, 37)),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(3)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expense.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
