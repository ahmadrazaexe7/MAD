import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() => runApp(const FlipRecipeApp());

class FlipRecipeApp extends StatelessWidget {
  const FlipRecipeApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flip Recipe — Pocket Chef',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepOrange),
    home: const RecipeHomePage(),
  );
}
