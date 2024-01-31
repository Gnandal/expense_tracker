import 'package:flutter/material.dart';
import 'package:spense_tracker/models/expense.dart';
import 'package:spense_tracker/widgets/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses, {super.key, required this.removeExpense});

  final void Function(Expense) removeExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
        ),
        onDismissed: (direction) {
          removeExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
