import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// -------------------------------
/// Base Shape class
/// -------------------------------
class Shape {
  Shape();

  double area() => 0;
  double circumference() => 0;

  void display() {
    print("Area: ${area()}");
    print("Circumference: ${circumference()}");
  }
}

/// -------------------------------
/// Circle class extending Shape
/// -------------------------------
class Circle extends Shape {
  final double radius;

  // Constructor using sugar syntax + calling super
  Circle(this.radius) : super();

  @override
  double area() {
    return pi * radius * radius;
  }

  @override
  double circumference() {
    return 2 * pi * radius;
  }

  @override
  void display() {
    print("Circle with radius: $radius");
    super.display(); // Uses overridden methods
  }
}

/// -------------------------------
/// Flutter App
/// -------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Assignment Task 2 54471",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController radiusController = TextEditingController();
  String result = "";

  /// ✅ Perform Circle calculations
  void calculateCircle() {
    double? radius = double.tryParse(radiusController.text);

    if (radius == null || radius <= 0) {
      setState(() {
        result = "Please enter a valid radius!";
      });
      return;
    }

    // Create Circle object
    Circle c1 = Circle(radius);

    setState(() {
      result = """
Circle with radius: ${c1.radius}
Area: ${c1.area()}
Circumference: ${c1.circumference()}
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dart Input Example 54471")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field for radius
            TextField(
              controller: radiusController,
              decoration: const InputDecoration(labelText: 'Enter Circle Radius'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            // Button
            ElevatedButton(onPressed: calculateCircle, child: const Text("Calculate Circle")),

            const SizedBox(height: 20),

            // Show result
            Text(result, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}