import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/models/transaction.dart';
import 'package:personal_expense_tracker/services/transaction_services.dart/transaction_services.dart';

import 'package:personal_expense_tracker/widgets/custom_text_field.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends StatefulWidget {
  static const String routeName = 'addTransaction-screen';
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final TransactioServives transactioServives = TransactioServives();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    categoryController.dispose();
    noteController.dispose();
    amountController.dispose();
  }

  void addTransaction() {
    const uid = Uuid();
    final transaction = Transaction(
      tid: uid.v4(),
      category: categoryController.text,
      note: noteController.text,
      amount: double.parse(amountController.text),
      date: DateTime.now(),
    );
    transactioServives.addTransation(
      context: context,
      transaction: transaction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Add Trasaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
        child: Column(
          children: [
            CustomTextField(
              hinttext: 'Add Category',
              controller: categoryController,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              hinttext: 'Add Note',
              controller: noteController,
              maxLines: 4,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              hinttext: 'Amount',
              controller: amountController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: addTransaction,
              child: const Text(
                "Add",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
