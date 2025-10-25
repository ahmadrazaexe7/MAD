// Home page: list, search, shuffle, favorites, add surprise
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../data/sample_recipe.dart';
import '../widgets/flip_recipe_card.dart';

class RecipeHomePage extends StatefulWidget {
  const RecipeHomePage({super.key});
  @override
  State<RecipeHomePage> createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> with SingleTickerProviderStateMixin {
  late List<Recipe> recipes;
  final Set<int> favorites = {};
  final PageController pageController = PageController(viewportFraction: 0.86);
  final TextEditingController searchCtrl = TextEditingController();
  bool showOnlyFavorites = false;
  late final AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    recipes = List<Recipe>.from(sampleRecipes);
    _bgController = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    pageController.dispose();
    searchCtrl.dispose();
    super.dispose();
  }

  List<Recipe> get filtered {
    final q = searchCtrl.text.toLowerCase();
    return recipes.where((r) {
      if (showOnlyFavorites && !favorites.contains(r.id)) return false;
      if (q.isEmpty) return true;
      return r.title.toLowerCase().contains(q) || r.ingredients.any((ing) => ing.toLowerCase().contains(q));
    }).toList();
  }

  void shuffleDeck() => setState(() => recipes.shuffle(Random()));
  void toggleFavorite(int id) => setState(() => favorites.contains(id) ? favorites.remove(id) : favorites.add(id));

  void addRandomRecipe() {
    final id = recipes.length + 1;
    final colors = [Colors.cyan, Colors.lime, Colors.orange, Colors.purple, Colors.blueGrey];
    final newR = Recipe(
      id: id,
      title: 'Chef\'s Surprise #$id',
      subtitle: 'A playful improvised dish',
      ingredients: ['Ingredient A', 'Ingredient B', 'A pinch of love'],
      steps: ['Mix everything', 'Taste and adjust', 'Plate nicely and serve'],
      color: colors[id % colors.length],
    );
    setState(() => recipes.insert(0, newR));
    if (pageController.hasClients) pageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final list = filtered;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Flip Recipe — Pocket Chef'),
        actions: [
          IconButton(onPressed: shuffleDeck, icon: const Icon(Icons.shuffle)),
          IconButton(onPressed: () => setState(() => showOnlyFavorites = !showOnlyFavorites), icon: Icon(showOnlyFavorites ? Icons.favorite : Icons.favorite_border)),
        ],
      ),
      body: Stack(children: [
        AnimatedBuilder(
          animation: _bgController,
          builder: (_, __) {
            final t = _bgController.value;
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.9 + sin(t * 2 * pi) * 0.3, -1),
                  end: Alignment(0.9 - cos(t * 2 * pi) * 0.3, 1),
                  colors: [Colors.white, Colors.orange.shade50.withOpacity(0.9)],
                ),
              ),
            );
          },
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Search by title or ingredient...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () => setState(() => searchCtrl.clear()),
                    borderRadius: BorderRadius.circular(10),
                    child: const Padding(padding: EdgeInsets.all(10), child: Icon(Icons.clear)),
                  ),
                )
              ]),
              const SizedBox(height: 12),
              Expanded(child: list.isEmpty ? const Center(child: Text('No recipes found')) : _buildDeck(list)),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Recipes: ${list.length}', style: const TextStyle(fontWeight: FontWeight.w600)),
                Row(children: [
                  Text('Favorites: ${favorites.length}', style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      final favs = recipes.where((r) => favorites.contains(r.id)).toList();
                      showModalBottomSheet(context: context, builder: (_) => _buildFavSheet(favs));
                    },
                    icon: const Icon(Icons.list),
                    label: const Text('View'),
                    style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  )
                ])
              ])
            ]),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton.extended(onPressed: addRandomRecipe, icon: const Icon(Icons.auto_awesome), label: const Text('Add Surprise')),
    );
  }

  Widget _buildDeck(List<Recipe> list) {
    return PageView.builder(
      controller: pageController,
      itemCount: list.length,
      itemBuilder: (context, i) {
        final recipe = list[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 6),
          child: AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double scale = 1.0;
              if (pageController.hasClients && pageController.position.haveDimensions) {
                final page = pageController.page ?? pageController.initialPage.toDouble();
                final diff = (page - i).abs();
                scale = (1 - diff * 0.15).clamp(0.85, 1.0);
              }
              return Transform.scale(scale: Curves.easeOut.transform(scale), child: child);
            },
            child: FlipRecipeCard(recipe: recipe, isFavorite: favorites.contains(recipe.id), onFavorite: () => toggleFavorite(recipe.id)),
          ),
        );
      },
    );
  }

  Widget _buildFavSheet(List<Recipe> favs) {
    if (favs.isEmpty) return Container(padding: const EdgeInsets.all(24), child: const Center(child: Text('No favorites yet.')));
    return SizedBox(
      height: 320,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Favorite Recipes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: favs.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, i) {
                final r = favs[i];
                return ListTile(
                  leading: CircleAvatar(backgroundColor: r.color, child: Text(r.title[0])),
                  title: Text(r.title),
                  subtitle: Text(r.subtitle),
                  trailing: IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => setState(() => favorites.remove(r.id))),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
