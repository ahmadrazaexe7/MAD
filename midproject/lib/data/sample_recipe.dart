import 'package:flutter/material.dart';
import '../models/recipe.dart';

const sampleRecipes = <Recipe>[
  Recipe(
    id: 1,
    title: 'Sunrise Shakshuka',
    subtitle: 'Spiced eggs in tomato sauce',
    ingredients: ['Eggs', 'Tomato', 'Onion', 'Bell pepper', 'Cumin', 'Paprika'],
    steps: [
      'Sauté onion & pepper',
      'Add tomatoes + spices, simmer',
      'Crack eggs on top, cover and cook',
      'Garnish with herbs and serve'
    ],
    color: Colors.deepOrangeAccent,
  ),
  Recipe(
    id: 2,
    title: 'Citrus Mint Quinoa',
    subtitle: 'Bright, light & protein-packed',
    ingredients: ['Quinoa', 'Orange', 'Mint', 'Olive oil', 'Salt'],
    steps: ['Cook quinoa', 'Zest & juice citrus', 'Toss quinoa with citrus, mint & oil', 'Serve warm or chilled'],
    color: Colors.teal,
  ),
  Recipe(
    id: 3,
    title: 'Spiced Chickpea Stew',
    subtitle: 'Comforting and vegan',
    ingredients: ['Chickpeas', 'Curry powder', 'Spinach', 'Coconut milk'],
    steps: ['Sauté spices', 'Add chickpeas and coconut milk', 'Simmer then stir in spinach', 'Serve with rice or flatbread'],
    color: Colors.indigo,
  ),
  Recipe(
    id: 4,
    title: 'Garlic Lemon Salmon',
    subtitle: 'Quick pan-roasted fish',
    ingredients: ['Salmon', 'Garlic', 'Lemon', 'Butter', 'Parsley'],
    steps: ['Season salmon', 'Sear skin-side down', 'Flip, add garlic & butter', 'Finish with lemon & herbs'],
    color: Colors.pink,
  ),
  Recipe(
    id: 5,
    title: 'Mango Coconut Lassi',
    subtitle: 'Sweet, tropical smoothie',
    ingredients: ['Mango', 'Yogurt', 'Coconut milk', 'Honey'],
    steps: ['Blend all ingredients until smooth', 'Pour over ice and enjoy'],
    color: Colors.amber,
  ),
];
