import 'dart:convert';

class Transaction {
  final String tid;
  final String category;
  final double amount;
  final String note;
  final DateTime date;

  Transaction({
    required this.tid,
    required this.category,
    required this.amount,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'tid': tid});
    result.addAll({'category': category});
    result.addAll({'note': note});
    result.addAll({'amount': amount});

    return result;
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      tid: map['tid'] ?? '',
      category: map['category'] ?? '',
      note: map['note'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));

  Transaction copyWith({
    String? tid,
    String? category,
    double? amount,
    String? note,
    DateTime? date,
  }) {
    return Transaction(
      tid: tid ?? this.tid,
      category: category ?? this.category,
      note: note ?? this.note,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }
}
