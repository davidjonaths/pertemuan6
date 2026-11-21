import 'package:flutter/material.dart';
import 'firestore.dart';
import '../widgets/todo_dialog.dart';
import '../models/todo.dart';

class TodoScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: StreamBuilder<List<Todo>>(
        stream: _firestoreService.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading todos'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No todos yet'));
          }

          final todos = snapshot.data!;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(
                  todo.task,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (value) {
                    if (value != null) {
                      _firestoreService.updateTodoStatus(todo.id, todo.isDone);
                    }
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _firestoreService.deleteTodo(todo.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => TodoDialog(firestoreService: _firestoreService),
          );
        },
        child: const Icon(Icons.add),
      ),
        body: StreamBuilder<List<Todo>>(
          stream: _firestoreService.getTodos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Belum ada tugas'));
            }

            final todos = snapshot.data!;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return TodoItem(
                  todo: todos[index],
                  firestoreService: _firestoreService,
                )
                // Tambahkan widget item di sini
              },
            );
          },
        )
        ```[cite: 3]
          }
        }
    );
  }
}
