import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descController;
  final VoidCallback onAdd;

  const AddTaskDialog({
    super.key,
    required this.titleController,
    required this.descController,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Add New Task',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: buildColumn(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
          onPressed: onAdd,
          child: const Text('Add'),
        ),
      ],
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Task Title',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: descController,
          decoration: const InputDecoration(
            labelText: 'Task Description',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ],
    );
  }
}