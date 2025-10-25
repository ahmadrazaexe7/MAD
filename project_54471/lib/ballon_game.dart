import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class BalloonGame extends StatefulWidget {
  const BalloonGame({super.key});

  @override
  State<BalloonGame> createState() => _BalloonGameState();
}

class _BalloonGameState extends State<BalloonGame> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;
  late List<bool> _popped;
  int _score = 0;
  bool _showInfo = false;
  Timer? _roundTimer;
  bool _gameRunning = false;

  static const int _roundSeconds = 10;
  static const int _balloonCount = 3;

  @override
  void initState() {
    super.initState();
    _popped = List.filled(_balloonCount, false);

    _controllers = List.generate(
      _balloonCount,
          (i) => AnimationController(
        vsync: this,
        duration: Duration(seconds: 3 + i * 2),
      ),
    );

    _animations = _controllers.map((c) {
      final curved = CurvedAnimation(parent: c, curve: Curves.easeInOut);
      return Tween<double>(begin: 600, end: 0).animate(curved)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) c.repeat();
        });
    }).toList();

    _startRound();
  }

  @override
  void dispose() {
    _roundTimer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _startRound() {
    setState(() {
      _score = 0;
      _popped = List.filled(_balloonCount, false);
      _gameRunning = true;
    });

    for (final c in _controllers) {
      c.reset();
      c.forward();
    }

    _roundTimer?.cancel();
    _roundTimer = Timer(const Duration(seconds: _roundSeconds), _endRound);
  }

  void _endRound() {
    for (final c in _controllers) {
      c.stop();
    }

    setState(() => _gameRunning = false);

    if (!mounted) return;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Round Over'),
        content: Text('Your score: $_score'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: const Text('Restart to play again'),
          ),
        ],
      ),
    );
  }

  void popBalloon(int index) {
    if (!_gameRunning || _popped[index]) return;

    setState(() {
      _popped[index] = true;
      _score++;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() => _popped[index] = false);
    });
  }

  void resetGame() {
    _roundTimer?.cancel();
    for (final c in _controllers) {
      c.reset();
    }
    _startRound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text('🎈 Relexing App by Ahmad(54471)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => setState(() => _showInfo = !_showInfo),
          ),
        ],
      ),
      body: AnimatedCrossFade(
        duration: const Duration(milliseconds: 500),
        firstChild: _buildGameArea(),
        secondChild: _buildInfoCard(),
        crossFadeState: _showInfo ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        onPressed: resetGame,
        label: const Text('Restart'),
        icon: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildInfoCard() => Center(
    child: Card(
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          '''🎮 Balloon Relax Game

Tap on the balloons to pop them and earn points.
Each balloon fades when popped and reappears after a short delay.

The round lasts for $_roundSeconds seconds. After the round ends your final score will be shown.

Created by: Ahmad Raza
SAP ID: 54471''',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.blueGrey.shade800),
        ),
      ),
    ),
  );

  Widget _buildGameArea() {
    return Stack(
      children: [
        // Balloons
        for (var i = 0; i < _balloonCount; i++)
          AnimatedBuilder(
            animation: _animations[i],
            builder: (context, child) => Positioned(
              bottom: _animations[i].value,
              left: 60.0 + i * 100,
              child: GestureDetector(
                onTap: () => popBalloon(i),
                child: AnimatedOpacity(
                  opacity: (_popped[i] || !_gameRunning) ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: BalloonWidget(index: i),
                ),
              ),
            ),
          ),

        // Score at bottom center
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4))],
              ),
              child: Text(
                'Score: $_score',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
            ),
          ),
        ),

        // Overlay when round finished
        if (!_gameRunning)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Card(
                color: Colors.white,
                elevation: 12,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Round finished. Your score: $_score\nTap Restart to play again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.blueGrey.shade800),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class BalloonWidget extends StatelessWidget {
  final int index;
  const BalloonWidget({Key? key, required this.index}) : super(key: key);

  static const _colors = [Colors.redAccent, Colors.green, Colors.orangeAccent];

  @override
  Widget build(BuildContext context) {
    final color = _colors[index % _colors.length];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4))],
          ),
          child: const Align(
            alignment: Alignment(-0.25, -0.4),
            child: SizedBox(
              width: 16,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.all(Radius.circular(6))),
              ),
            ),
          ),
        ),
        Container(width: 2, height: 22, color: Colors.brown),
      ],
    );
  }
}
