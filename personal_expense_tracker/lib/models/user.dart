class User {
  final String uid;
  final String name;
  final String email;
  final String password;
  double income;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    this.income = 0.0,
  });

  User copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
    double? income,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      income: income ?? this.income,
    );
  }
}
