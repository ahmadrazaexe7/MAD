import 'dart:io';

void main() {
  stdout.write("Enter a number n: ");
  int n = int.parse(stdin.readLineSync()!);

  for (int i = 1; i <= n; i++) {
    String line = "";
    for (int j = 1; j <= i; j++) {
      line += "$j ";
    }
    print(line.trim());
  }
}
