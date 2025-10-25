import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProfileApp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
