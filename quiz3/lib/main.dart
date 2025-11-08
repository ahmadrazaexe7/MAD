import 'package:flutter/material.dart';

void main() => runApp(const FlashcardApp());

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlashcardScreen(),
    );
  }
}

class Flashcard {
  String question;
  String answer;
  bool learned;
  Flashcard(this.question, this.answer, {this.learned = false});
}

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Flashcard> _cards = [
    Flashcard("What is the capital of France?", "Paris."),
    Flashcard("Which planet is known as the Red Planet?", "Mars."),
    Flashcard("Who wrote the Harry Potter series?", "J.K. Rowling."),
    Flashcard("What is the largest ocean on Earth?", "The Pacific Ocean."),
    Flashcard("In which year did World War II end?", "1945."),
  ];

  bool _showAnswer = false;

  Future<void> _refreshList() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _cards = [
        Flashcard("What is the capital of Japan?", "Tokyo."),
        Flashcard("Which gas do plants use during photosynthesis?", "Carbon Dioxide (CO₂)."),
        Flashcard("Who painted the Mona Lisa?", "Leonardo da Vinci."),
        Flashcard("What is the smallest prime number?", "2."),
        Flashcard("How many continents are there?", "Seven."),
      ];
    });
  }

  void _addCard() {
    final newCard = Flashcard("What is the tallest mountain?", "Mount Everest.");
    _cards.insert(0, newCard);
    _listKey.currentState?.insertItem(0);
  }

  int get learnedCount => _cards.where((c) => c.learned).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Learned: $learnedCount / ${_cards.length}"),
              ),
            ),
            SliverToBoxAdapter(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: _cards.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index, animation) {
                  final card = _cards[index];
                  return SizeTransition(
                    sizeFactor: animation,
                    child: Dismissible(
                      key: ValueKey(card.question),
                      onDismissed: (_) {
                        setState(() {
                          card.learned = true;
                          _cards.removeAt(index);
                        });
                      },
                      background: Container(
                        color: Colors.green,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(16),
                        child: const Icon(Icons.check, color: Colors.white),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _showAnswer = !_showAnswer);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  card.question,
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                if (_showAnswer)
                                  Text(card.answer,
                                      style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        child: const Icon(Icons.add),
      ),
    );
  }
}
