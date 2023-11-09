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
