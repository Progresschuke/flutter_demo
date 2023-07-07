import 'package:flutter/material.dart';

import 'package:expense_tracker_app/model/expense_structure.dart';

import 'package:expense_tracker_app/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.work),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8,
          ),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(71, 114, 122, 238),
              Color.fromARGB(255, 90, 94, 151)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final bucket in buckets)
                    ChartBar(
                        fill: bucket.totalExpenses == 0
                            ? 0
                            : bucket.totalExpenses / maxTotalExpense)
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: buckets
                  .map(
                    (bucket) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        child: Icon(
                          categoryIcons[bucket.category],
                          color: const Color.fromARGB(255, 9, 18, 34),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
