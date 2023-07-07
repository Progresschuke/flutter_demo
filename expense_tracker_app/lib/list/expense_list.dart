import 'package:expense_tracker_app/list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/model/expense_structure.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.5),
        ),
        onDismissed: (direction) => onRemoveExpense(expenses[index]),
        key: ValueKey(
          expenses[index],
        ),
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}
