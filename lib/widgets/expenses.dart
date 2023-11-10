import 'package:expence_tracker_app/models/expense.dart';
import 'package:expence_tracker_app/widgets/chart/chart.dart';
import 'package:expence_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expence_tracker_app/widgets/new_expence.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  //dumy data
  final List<Expense> _registerdExpenses = [
    Expense(
        title: "Flutter course",
        amount: 19.99,
        date: DateTime.now(),
        cetergory: Catergory.work),
    Expense(
        title: "Breackfast",
        amount: 2,
        date: DateTime.now(),
        cetergory: Catergory.food),
  ];

  //create funtion to add expenses users-> open
  void _openAddExpenses() {
    //add new dynamic element => model Overlay
    showModalBottomSheet(
      useSafeArea: true, //camara responsive
      //built in funtion
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
          onAddExpense: _addExpense), //add add new expense widget here
    );
  }

  //save data
  void _addExpense(Expense expense) {
    setState(() {
      _registerdExpenses.add(expense);
    });
  }

  //swap
  void _removeExpense(Expense expense) {
    final expenseIndex = _registerdExpenses.indexOf(expense);
    setState(() {
      _registerdExpenses.remove(expense);
    });
    //undo
    ScaffoldMessenger.of(context).clearSnackBars(); //old msg remove quick
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text("Deleted"),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registerdExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //ajust with available
    final width = MediaQuery.of(context).size.width;
    ///////////
    Widget mainContent = const Center(
      child: Text("No expenses, Start Adding."),
    );
    if (_registerdExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerdExpenses,
        onRemoveExpenses: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Expense Tracker"),
        //action use to display widgets or button
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed:
                _openAddExpenses, //add model bottom sheet funtion name to display
          )
        ],
      ),
      //compare with width
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registerdExpenses),
                //list output
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registerdExpenses),
                ),
                //list output
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
