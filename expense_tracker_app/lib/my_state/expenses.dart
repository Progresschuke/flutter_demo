import 'package:expense_tracker_app/chart/Chart.dart';
import 'package:expense_tracker_app/modal%20popup/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/list/expense_list.dart';
import 'package:expense_tracker_app/model/expense_structure.dart';
// import 'package:expense_tracker_app/data/my_expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> myExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 15.999,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 14.694,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'React Course',
      amount: 9.99,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: addExpense,
            ));
  }

  void addExpense(Expense expense) {
    setState(() {
      myExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = myExpenses.indexOf(expense);
    setState(() {
      myExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense deleted.'),
      duration: const Duration(seconds: 3),
      backgroundColor: const Color.fromARGB(251, 3, 23, 44),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              myExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print(width);
    Widget mainContent = const Center(
      child: Text('No expense found. Start addind some!'),
    );

    if (myExpenses.isNotEmpty) {
      mainContent =
          ExpenseList(expenses: myExpenses, onRemoveExpense: removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vortex Menu'),
        actions: [
          IconButton(
            onPressed: openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: myExpenses),
                Expanded(
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                Chart(expenses: myExpenses),
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
