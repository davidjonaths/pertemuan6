import 'package:flutter/material.dart';

class TodoDialog extends StatefulWidget {
  final String? initialTask;
  final Function(String) onSave;

  const TodoDialog({
    super.key,
    this.initialTask,
    required this.onSave,
  });

  @override
  State<TodoDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  late TextEditingController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.initialTask);
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialTask == null ? 'Tambah Todo' : 'Edit Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _taskController,
            decoration: const InputDecoration(labelText: 'Task'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_taskController.text.trim().isNotEmpty) {
              widget.onSave(_taskController.text.trim());
              Navigator.of(context).pop();
            }
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
