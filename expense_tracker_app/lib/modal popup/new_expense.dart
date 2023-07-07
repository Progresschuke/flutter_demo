import 'package:expense_tracker_app/model/expense_structure.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.food;

  void _presentDatePicker() async {
    final initialDate = DateTime.now();
    final firstDate = DateTime(
      initialDate.year - 1,
      initialDate.month,
      initialDate.day,
    );
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: initialDate);

    setState(() {
      selectedDate = pickedDate;
    });
  }

  void submitExpenseData() {
    final enteredAmount = double.tryParse(amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please input a valid title, amount, date and category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: titleController.text,
        amount: enteredAmount,
        date: selectedDate!,
        category: selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    final width = MediaQuery.of(context).size.width;

    Widget expandInput = Row(
      children: [
        Expanded(
          child: TextField(
            controller: titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: TextField(
            controller: amountController,
            maxLength: 10,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: const InputDecoration(
              prefixText: '\$ ',
              label: Text('Amount'),
            ),
          ),
        )
      ],
    );

    Widget expandCategory = Row(
      children: [
        DropdownButton(
            value: selectedCategory,
            items: Category.values
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category.name.toUpperCase(),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() {
                selectedCategory = value;
              });
            }),
        const Spacer(),
        Text(selectedDate == null
            ? 'No Date Selected'
            : formatter.format(selectedDate!)),
        IconButton(
          onPressed: _presentDatePicker,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );

    Widget displayButton = Row(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('cancel'),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: submitExpenseData,
          child: const Text('submit expense'),
        )
      ],
    );

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          child: Column(
            children: [
              if (width >= 600)
                expandInput
              else
                TextField(
                  controller: titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
              if (width >= 600)
                expandCategory
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: amountController,
                        maxLength: 10,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(selectedDate == null
                              ? 'No Date Selected'
                              : formatter.format(selectedDate!)),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              const SizedBox(
                height: 16,
              ),
              if (width >= 600)
                displayButton
              else
                Row(
                  children: [
                    DropdownButton(
                        value: selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            selectedCategory = value;
                          });
                        }),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('cancel'),
                    ),
                    ElevatedButton(
                      onPressed: submitExpenseData,
                      child: const Text('submit expense'),
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
