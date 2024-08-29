// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/models/transaction.dart' as model;
import 'package:personal_expense_tracker/provider/transactions_provider.dart';
import 'package:personal_expense_tracker/provider/user_provider.dart';
import 'package:personal_expense_tracker/utils/utils.dart';
import 'package:provider/provider.dart';

class TransactioServives {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // add transaction to the database
  void addTransation({
    required BuildContext context,
    required model.Transaction transaction,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final transactionProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    try {
      await _firestore
          .collection('users')
          .doc(userProvider.user.uid)
          .collection('transactions')
          .doc(transaction.tid)
          .set(transaction.toMap());

      transactionProvider.addTransaction(transaction);
      Future.delayed(
        const Duration(seconds: 3),
      );
      showSnackBar(context: context, content: "Added Succesfully");
      Navigator.pop(context);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  // remove transactions
  void removeTransaction({
    required BuildContext context,
    required String uid,
    required model.Transaction transaction,
  }) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('transactions')
        .doc(transaction.tid)
        .delete();
  }

  void updateTransation({
    required BuildContext context,
    required model.Transaction transaction,
  }) async {
    await _firestore
        .collection('transactions')
        .doc(transaction.tid)
        .update(transaction.toMap());
  }
}
