import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/models/transaction.dart' as m;

class TransactionsProvider extends ChangeNotifier {
  double totalExpence = 0;
  List<m.Transaction> _transactions = [
    m.Transaction(
      date: DateTime(
        2024,
        8,
        28,
      ),
      category: 'Grocery bill',
      note: 'Day 28 of Aug Grocery bill',
      amount: 110,
      tid: "assbhqfbqbjsbjkbsjqbsbjqbsbfbbj",
    )
  ];

  List<m.Transaction> get transactions => _transactions;

  List<m.Transaction> getOnDate(DateTime time) {
    List<m.Transaction> res = [];
    _transactions.map((t) {
      if (t.date.day == time.day) {
        res.add(t);
      }
    }).toList();
    return res;
  }

  void setTransactionList(List<m.Transaction> transactions) {
    _transactions = transactions;
    for (var element in transactions) {
      totalExpence += element.amount;
    }
    notifyListeners();
  }

  void addTransaction(m.Transaction transaction) {
    _transactions.add(transaction);
    totalExpence += transaction.amount;
    notifyListeners();
  }

  void removeTransaction(m.Transaction transaction) {
    _transactions.remove(transaction);
    totalExpence -= transaction.amount;
    notifyListeners();
  }
}
