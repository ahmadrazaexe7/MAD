import 'dart:io';

void main() {
  stdout.write("Enter your name: ");
  String name = stdin.readLineSync()!;

  stdout.write("Enter your age: ");
  int age = int.parse(stdin.readLineSync()!);

  if (age < 18) {
    print("Sorry $name, you are not eligible to register.");
    return; // stop program
  }

  stdout.write("How many numbers do you want to enter? ");
  int n = int.parse(stdin.readLineSync()!);

  List<int> numbers = [];

  for (int i = 0; i < n; i++) {
    stdout.write("Enter number ${i + 1}: ");
    numbers.add(int.parse(stdin.readLineSync()!));
  }

  int sumEven = numbers.where((x) => x % 2 == 0).fold(0, (a, b) => a + b);
  int sumOdd = numbers.where((x) => x % 2 != 0).fold(0, (a, b) => a + b);
  int largest = numbers.reduce((a, b) => a > b ? a : b);
  int smallest = numbers.reduce((a, b) => a < b ? a : b);

  print("\nResults:");
  print("Sum of even numbers: $sumEven");
  print("Sum of odd numbers: $sumOdd");
  print("Largest number: $largest");
  print("Smallest number: $smallest");
}
