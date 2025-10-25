import 'dart:io';

void main() {
  List<int> numbers = [];

  print("Enter 6 integers:");

  for (int i = 0; i < 6; i++) {
    int value = int.parse(stdin.readLineSync()!);
    numbers.add(value);
  }

  int sumOdd = 0;
  for (int num in numbers) {
    if (num % 2 != 0) {
      sumOdd = sumOdd + num;
    }
  }

  int smallest = numbers[0];
  for (int num in numbers) {
    if (num < smallest) {
      smallest = num;
    }
  }

  print("Sum of Odd Numbers: $sumOdd");
  print("Smallest Number: $smallest");
}
