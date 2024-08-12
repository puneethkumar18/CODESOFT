class Task {
  final String name;
  final String category;
  final String description;
  final String completeIn;
  final bool isCompleted;

  Task({
    required this.name,
    required this.category,
    required this.description,
    required this.completeIn,
    required this.isCompleted,
  });

  Task copyWith({
    String? name,
    String? category,
    String? description,
    String? completeIn,
    bool? isCompleted,
  }) {
    return Task(
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      completeIn: completeIn ?? this.completeIn,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
