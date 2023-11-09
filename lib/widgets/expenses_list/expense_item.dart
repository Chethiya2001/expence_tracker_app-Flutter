//use view individual list item in the List item list

import 'package:expence_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

//get input
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              //Display amount
              Row(
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}'),
                  //need to display right side (use Space to get space)
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        catergoryIcons[expense.cetergory],
                      ), //add each enums to defferent icons
                      const SizedBox(width: 8),
                      Text(expense
                          .formattedDate) //add formatted date expence class difines
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
