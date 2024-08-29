import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/provider/transactions_provider.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  final DateTime time;
  const TransactionList({
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionsProvider>(context);
    final trabsactionListOfTheDay = transactionProvider.getOnDate(time);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: trabsactionListOfTheDay.length,
      itemBuilder: (context, index) {
        final transaction = trabsactionListOfTheDay[index];

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: ListTile(
              tileColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              title: Text(
                transaction.category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
              subtitle: Text(
                transaction.note,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                '${transaction.amount}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
