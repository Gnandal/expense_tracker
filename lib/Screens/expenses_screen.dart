import 'package:flutter/material.dart';
import 'package:spense_tracker/models/expense.dart';
import 'package:spense_tracker/widgets/chart.dart';
import 'package:spense_tracker/widgets/expenses_list.dart';
import 'package:spense_tracker/widgets/new_expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Fruit',
      amount: 2.99,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });

    Navigator.pop(context);
  }

  _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense removed succesfull"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  _showOverlayDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(_addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: _showOverlayDialog,
              icon: const Icon(
                Icons.add,
              ))
        ],
        title: const Text(
          'Flutter ExpenseTracker',
        ),
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
              child: _registeredExpenses.isEmpty
                  ? const Center(
                      child: Text("Empty...."),
                    )
                  : ExpensesList(
                      _registeredExpenses,
                      removeExpense: _removeExpense,
                    ))
        ],
      ),
    );
  }
}
