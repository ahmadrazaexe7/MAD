import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/edit_task_dialog.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final List<Task> tasks = [];

  bool showList = true;
  double opacity = 1.0;

  void addTask() {
    if (titleController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(
          title: titleController.text,
          description: descController.text,
        ));
        titleController.clear();
        descController.clear();
        opacity = 0.0;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() => opacity = 1.0);
      });
    }
  }

  void editTask(int index, String newTitle, String newDesc) {
    setState(() {
      tasks[index].title = newTitle;
      tasks[index].description = newDesc;
    });
  }

  void toggleDone(int index, bool? value) =>
      setState(() => tasks[index].isDone = value ?? false);

  void deleteTask(int index) => setState(() => tasks.removeAt(index));

  void toggleView() => setState(() => showList = !showList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('✨ Animated To-Do List ✨'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[400],
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB993D6), Color(0xFF8CA6DB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              // --- Task List Section ---
              Expanded(
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 600),
                  crossFadeState: showList
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: tasks.isEmpty
                      ? todo_list_Center()
                      : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) => TaskTile(
                      task: tasks[index],
                      opacity: opacity,
                      onDelete: () => deleteTask(index),
                      onEdit: (t, d) => editTask(index, t, d),
                      onToggleDone: (v) => toggleDone(index, v),
                    ),
                  ),
                  secondChild: const Center(
                    child: Text(
                      'List Hidden 👀',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // Footer Section
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Riphah International University',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Created by  Ahmed',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'SAP ID: 54471',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFABs(context),
    );
  }

  Center todo_list_Center() {
    return const Center(
      child: Text(
        'No tasks yet. Add one!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  // --- Floating Action Buttons ---
  Widget _buildFABs(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'toggle',
          mini: true,
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: toggleView,
          child: const Icon(Icons.visibility),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          heroTag: 'add',
          backgroundColor: Colors.pinkAccent,
          onPressed: () => showDialog(
            context: context,
            builder: (_) => AddTaskDialog(
              titleController: titleController,
              descController: descController,
              onAdd: () {
                addTask();
                Navigator.pop(context);
              },
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}