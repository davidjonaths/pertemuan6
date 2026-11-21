import 'package:flutter/material.dart';
import '../services/firestore.dart';
import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final FirestoreService firestoreService;

  const TodoItem({
    super.key,
    required this.todo,
    required this.firestoreService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2,
      child: CheckboxListTile(
        title: Text(
          todo.task,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
            color: todo.isDone ? Colors.grey : Colors.black,
          ),
        ),
        value: todo.isDone,
        onChanged: (_) => firestoreService.updateTodoStatus(todo.id, todo.isDone),
        activeColor: const Color(0xFF6750A4),
        secondary: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            firestoreService.deleteTodo(todo.id);
          },
        ),
      ),
    );
  }
}
