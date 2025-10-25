import 'package:flutter/material.dart';

class Recipe {
  final int id;
  final String title;
  final String subtitle;
  final List<String> ingredients;
  final List<String> steps;
  final Color color;

  const Recipe({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.ingredients,
    required this.steps,
    required this.color,
  });
}
