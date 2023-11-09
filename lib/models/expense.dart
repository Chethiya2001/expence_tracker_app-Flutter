import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatDate = DateFormat.yMd();

//create Enum
enum Catergory { food, travel, leisure, work }

const catergoryIcons = {
  Catergory.food: Icons.food_bank,
  Catergory.leisure: Icons.movie,
  Catergory.travel: Icons.flight,
  Catergory.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.cetergory})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Catergory cetergory;

  //create date formatter
  String get formattedDate {
    return formatDate.format(date);
  }
}

//add chart expense
class ExpenseBucket {
  const ExpenseBucket({required this.catergory, required this.expenses});

  ExpenseBucket.forCatergory(List<Expense> allExpenses, this.catergory)
      : expenses = allExpenses
            .where((expense) => expense.cetergory == catergory)
            .toList(); //additional funtion in the class filter

  final Catergory catergory;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
