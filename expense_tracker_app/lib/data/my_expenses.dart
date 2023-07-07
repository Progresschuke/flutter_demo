import 'package:expense_tracker_app/model/expense_structure.dart';

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
