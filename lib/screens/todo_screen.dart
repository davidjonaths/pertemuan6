import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/auth_notifier.dart';
import '../services/firestore.dart';
import '../models/todo.dart';
import '../widgets/todo_dialog.dart';
import '../widgets/todo_item.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        title: const Text('Todo List', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () => context.read<AuthNotifier>().signOut(),
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: firestoreService.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final todos = snapshot.data ?? [];

          if (todos.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada Todo.\nTekan tombol + untuk menambahkan.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Stack(
                children: [
                  TodoItem(
                    todo: todo,
                    firestoreService: firestoreService,
                  ),
                  Positioned(
                    right: 8,
                    top: 10,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => TodoDialog(
                            initialTask: todo.task,
                            onSave: (task) {
                              firestoreService.updateTodo(todo.id, task);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => TodoDialog(
              onSave: (task) {
                firestoreService.addTodo(task);
              },
            ),
          );
        },
        backgroundColor: const Color(0xFFE8DEF8),
        foregroundColor: const Color(0xFF6750A4),
        child: const Icon(Icons.add),
      ),
    );
  }
}
