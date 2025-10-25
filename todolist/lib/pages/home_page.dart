import 'package:flutter/material.dart';
import 'todo_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: buildColumn2(),
        ),
      ),
    );
  }

  Column buildColumn2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Top content
        HomeColumnWidget(),

        // Bottom footer
        homePadding(),
      ],
    );
  }

  Padding homePadding() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Homecolumn(),
    );
  }

  Column Homecolumn() {
    return Column(
      children: const [
        Divider(color: Colors.white70, thickness: 1, indent: 50, endIndent: 50),
        SizedBox(height: 10),
        Text(
          'Riphah International University',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 0.5),
        ),
        SizedBox(height: 6),
        Text(
          'BSCS Department',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}

class HomeColumnWidget extends StatelessWidget {
  const HomeColumnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 60),
        const Icon(Icons.task_alt_rounded,
            color: Colors.white, size: 90),
        const SizedBox(height: 20),
        const Text(
          'Welcome to Your\nAnimated To-Do List!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Developed by Ahmed (SAP: 54471)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(
                horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            elevation: 4,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ToDoListPage()),
            );
          },
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          label: const Text('Go to To-Do List',
              style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}