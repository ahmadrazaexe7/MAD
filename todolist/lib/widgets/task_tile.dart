import 'package:flutter/material.dart';
import '../models/task.dart';
import 'edit_task_dialog.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final double opacity;
  final VoidCallback onDelete;
  final Function(String, String) onEdit;
  final Function(bool?) onToggleDone;

  const TaskTile({
    required this.task,
    required this.opacity,
    required this.onDelete,
    required this.onEdit,
    required this.onToggleDone,
    super.key,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.opacity,
      duration: const Duration(milliseconds: 400),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: expanded ? 150 : 80,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.task.isDone
                ? [Colors.greenAccent, Colors.green]
                : [Colors.purpleAccent, Colors.deepPurple],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
        ),
        child: ListTile(
          leading: Checkbox(
            value: widget.task.isDone,
            onChanged: widget.onToggleDone,
            activeColor: Colors.white,
            checkColor: Colors.deepPurple,
          ),
          title: Text(
            widget.task.title,
            style: TextStyle(
              color: Colors.white,
              decoration: widget.task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: expanded
              ? Text(
            widget.task.description.isNotEmpty
                ? widget.task.description
                : 'No description added',
            style: const TextStyle(color: Colors.white70),
          )
              : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => EditTaskDialog(
                      initialTitle: widget.task.title,
                      initialDesc: widget.task.description,
                      onSave: (t, d) {
                        widget.onEdit(t, d);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white,
                ),
                onPressed: () => setState(() => expanded = !expanded),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: widget.onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}