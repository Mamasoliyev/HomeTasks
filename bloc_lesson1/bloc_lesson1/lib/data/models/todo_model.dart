class TodoModel {
  final String name;
  final bool isCompleted;
  final String owner;

  TodoModel({
    required this.name,
    this.isCompleted = false,
    required this.owner,
  });
}
