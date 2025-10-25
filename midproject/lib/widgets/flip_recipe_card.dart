// Flipable recipe card widget
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/recipe.dart';

class FlipRecipeCard extends StatefulWidget {
  final Recipe recipe;
  final bool isFavorite;
  final VoidCallback onFavorite;

  const FlipRecipeCard({
    super.key,
    required this.recipe,
    required this.isFavorite,
    required this.onFavorite,
  });

  @override
  State<FlipRecipeCard> createState() => _FlipRecipeCardState();
}

class _FlipRecipeCardState extends State<FlipRecipeCard> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  bool flipped = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void toggle() {
    setState(() {
      flipped = !flipped;
      flipped ? _ctrl.forward() : _ctrl.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.recipe;
    return GestureDetector(
      onTap: toggle,
      child: Center(
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (_, child) {
            final angle = _ctrl.value * pi;
            final transform = Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(angle);
            final isBack = angle > pi / 2;
            return Transform(transform: transform, alignment: Alignment.center, child: isBack ? _buildBack(r) : _buildFront(r));
          },
        ),
      ),
    );
  }

  Widget _buildFront(Recipe r) => Card(
    elevation: 12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(radius: 26, backgroundColor: r.color, child: Text(r.title[0], style: const TextStyle(fontWeight: FontWeight.bold))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(r.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(r.subtitle, style: TextStyle(color: Colors.grey[700])),
            ]),
          ),
          IconButton(onPressed: widget.onFavorite, icon: Icon(widget.isFavorite ? Icons.favorite : Icons.favorite_border, color: widget.isFavorite ? Colors.red : null))
        ]),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 6, children: r.ingredients.take(6).map((ing) => Chip(label: Text(ing))).toList()),
        const Spacer(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Tap to flip', style: TextStyle(color: Colors.grey[600])), const Icon(Icons.touch_app_outlined, size: 18, color: Colors.grey)]),
      ]),
    ),
  );

  Widget _buildBack(Recipe r) => Transform(
    transform: Matrix4.rotationY(pi),
    alignment: Alignment.center,
    child: Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(radius: 22, backgroundColor: r.color, child: Text(r.title[0])),
            const SizedBox(width: 12),
            const Expanded(child: Text('Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            IconButton(onPressed: widget.onFavorite, icon: Icon(widget.isFavorite ? Icons.favorite : Icons.favorite_border, color: widget.isFavorite ? Colors.red : null))
          ]),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                ...r.ingredients.map((i) => Text('• $i')),
                const SizedBox(height: 12),
                const Text('Steps', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                ...r.steps.asMap().entries.map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Text('${e.key + 1}. ${e.value}'))),
              ]),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Tap to go back', style: TextStyle(color: Colors.grey[600])),
            TextButton.icon(onPressed: () => _showTips(), icon: const Icon(Icons.info_outline), label: const Text('Tips'))
          ])
        ]),
      ),
    ),
  );

  void _showTips() => showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Quick Tips'),
      content: const Text('Favorite recipes you like and use Add Surprise to create playful variations.'),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Got it'))],
    ),
  );
}
