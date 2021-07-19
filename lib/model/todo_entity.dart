class TodoEntity {
  final String id;
  final String content;
  final bool isCompleted;

  TodoEntity(this.id, this.content, this.isCompleted);

  TodoEntity copyWith({String? id, String? content, bool? isCompleted}) {
    return TodoEntity(
        id ?? this.id,
        content ?? this.content,
        isCompleted ?? this.isCompleted);
  }

  TodoEntity.fromJson(Map json)
      : id = json['id'],
        content = json['content'],
        isCompleted = json['isCompleted'];

  Map toJson() => {
    'id': id,
    'content': content,
    'isCompleted': isCompleted
  };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  int get hashCode => id.hashCode ^ content.hashCode ^ isCompleted.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other)
      || other is TodoEntity
      && runtimeType == other.runtimeType
      && id == other.id
      && content == other.content
      && isCompleted == other.isCompleted;
  }



}