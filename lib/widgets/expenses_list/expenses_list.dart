import 'package:expence_tracker_app/models/expense.dart';
import 'package:expence_tracker_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  // access data
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpenses});
//get as a inputs
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpenses;

  @override
  Widget build(BuildContext context) {
    //if need to display unknown amountof list use list view(auto scrollerble use .builder if need to visible list items) //
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
              //add them
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.5),
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              ),

              //swap effect
              key: ValueKey(expenses[index]),
              onDismissed: (direction) => onRemoveExpenses(expenses[index]),
              child: ExpenseItem(
                expenses[index],
              ), //use index to display single value use index num)
              //return widget
            ));
  }
}
