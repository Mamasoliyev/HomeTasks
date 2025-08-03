class TodoEntity {
  final String id;
  final String title;
  final bool isDone;

  TodoEntity({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  TodoEntity copyWith({String? id, String? title, bool? isDone}) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
