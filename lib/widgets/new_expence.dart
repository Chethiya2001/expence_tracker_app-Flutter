import 'package:expence_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  
  final void Function(Expense expense) onAddExpense; //add new data

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // //store values in title text field
  // var _enterdTitle = ''; //store new title value using _saveTitleInput the funtion
  // void _saveTitleInput(String inputValue) {
  //   _enterdTitle = inputValue;
  // }

  //Other way using controllers
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  //drop Down
  Catergory _selectedCatergory = Catergory.leisure;

  //date picker method
  void _presentDatePicker() async {
    //get all dates
    final now = DateTime.now();
    // final last = DateTime(now.year + 1, now.month, now.day);
    final firstDate =
        DateTime(now.year - 1, now.month, now.day); //lowest selected date set

    //built in funtion
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    // this line
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitData() {
    final enterdamount = double.tryParse(_amountController
        .text); // tryParse("Hello") => null, tryParse("11.10") => 11.10,
    final amountisInvalid = enterdamount == null || enterdamount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountisInvalid ||
        _selectedDate == null) {
      //show error msg in dialog box
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Plase make sure a filled all areas. '),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Ok"))
          ],
        ),
      );
      return; //close
    }
    //add new data
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enterdamount,
          date: _selectedDate!,
          cetergory: _selectedCatergory),
    );
    Navigator.pop(context);
  }

  //needs to close when the ovelay is closed
  @override
  void dispose() {
    _titleController.dispose(); //mention controller close
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            // onChanged:_saveTitleInput ,  get title field changing values use funtion or ...
            controller: _titleController,
            maxLength: 20,
            keyboardType: TextInputType.name,
            //add lable need decoration filed
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              //add date picker
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatDate.format(_selectedDate!),
                    ),
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
          //add buttons to save inputs and cancle and Drop down button
          Row(
            children: [
              DropdownButton(
                  value:
                      _selectedCatergory, //currently selecterd value show on the screen
                  items: Catergory.values
                      .map(
                        (catergory) => DropdownMenuItem(
                          value: catergory, //store internaly
                          child: Text(
                            catergory.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCatergory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cencle")),
              ElevatedButton(
                onPressed: () {
                  _submitData();
                },
                child: const Text("Save"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
