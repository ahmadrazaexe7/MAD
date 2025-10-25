import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// -------------------------------
/// Student Class with Constructors
/// -------------------------------
class Student {
  final String name;
  final int age;

  /// 1️⃣ Default Constructor
  Student() : name = "Unknown", age = 0;

  /// 2️⃣ Parameterized Constructor
  Student.parameterized(this.name, this.age);

  /// 3️⃣ Named Constructor
  Student.guest() : name = "Guest", age = 18;

  /// 4️⃣ Const Constructor (for immutable objects)
  const Student.constConstructor({this.name = "Const", this.age = 100});

  /// 5️⃣ Redirecting Constructor
  Student.young(String name) : this.parameterized(name, 18);

  @override
  String toString() {
    return "Name: $name, Age: $age";
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  List<int> numbers = [];
  String result = "";

  /// ✅ Add a number to the list
  void addNumber() {
    int? num = int.tryParse(numberController.text);
    if (num != null) {
      setState(() {
        numbers.add(num);
        numberController.clear();
      });
    }
  }

  /// ✅ Perform calculations
  void calculate() {
    String name = nameController.text.trim();
    int age = int.tryParse(ageController.text) ?? 0;

    // Create students using all constructors
    Student s1 = Student(); // default
    Student s2 = Student.parameterized(name, age); // parameterized
    Student s3 = Student.guest(); // named
    const Student s4 = Student.constConstructor(); // const
    Student s5 = Student.young(name); // redirecting

    // Age check
    if (age < 18) {
      setState(() {
        result = "Sorry $name, you are not eligible to register.\n\n"
            "Constructors Demo:\n"
            "1) $s1\n"
            "2) $s2\n"
            "3) $s3\n"
            "4) $s4\n"
            "5) $s5";
      });
      return;
    }

    if (numbers.isEmpty) {
      setState(() {
        result = "Please add at least one number!";
      });
      return;
    }

    int sumEven = 0;
    int sumOdd = 0;
    int largest = numbers[0];
    int smallest = numbers[0];

    for (int num in numbers) {
      if (num % 2 == 0) {
        sumEven += num;
      } else {
        sumOdd += num;
      }

      if (num > largest) largest = num;
      if (num < smallest) smallest = num;
    }

    setState(() {
      result = """
Name: $name
Age: $age

Sum of Even Numbers: $sumEven
Sum of Odd Numbers: $sumOdd
Largest Number: $largest
Smallest Number: $smallest

Constructors Demo:
1) $s1
2) $s2
3) $s3
4) $s4
5) $s5
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dart Input Example 57288")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input fields
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: 'Enter a number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            // Buttons
            Row(
              children: [
                ElevatedButton(onPressed: addNumber, child: const Text("Add Number")),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: calculate, child: const Text("Calculate")),
              ],
            ),

            const SizedBox(height: 20),

            // Show numbers list
            if (numbers.isNotEmpty)
              Text("Numbers: ${numbers.join(", ")}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

            const SizedBox(height: 20),

            // Show result
            Text(result, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}