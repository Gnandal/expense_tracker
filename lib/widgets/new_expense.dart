import 'package:flutter/material.dart';
import 'package:spense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addNewSpense, {super.key});
  final void Function(Expense expense) addNewSpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;

  _displayDatePicker() async {
    final datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1));

    setState(() {
      _selectedDate = datePicked!;
    });
  }

  _submitForm() {
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredAmount == null || _amountController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text("Please, fill an valid amount value..."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );

      return;
    }

    widget.addNewSpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        category: _selectedCategory,
        date: _selectedDate!,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No date Selected"
                          : formatter.format(_selectedDate!),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    IconButton(
                        onPressed: _displayDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
