import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category { work, leisure, food, travel}

const categoryIcons = {
  Category.work: Icons.work,
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

  Expense({required this.title, required this.amount, required this.date, required this.category}) : id = uuid.v4();
}

class ExpenseBucket {

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for(final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }

  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) :
        expenses = allExpenses.where((element) => element.category == category).toList();
}