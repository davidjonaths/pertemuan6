import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id;
  final String task;
  final bool isDone;

  Todo({
    required this.id,
    required this.task,
    this.isDone = false,
  });

  factory Todo.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Todo(
      id: doc.id,
      task: data['task'] ?? '',
      isDone: data['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task': task,
      'isDone': isDone,
    };
  }
}
