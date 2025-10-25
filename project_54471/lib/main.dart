// ----------------------------
// File: lib/main.dart
// ----------------------------

import 'package:flutter/material.dart';
import 'ballon_game.dart';

void main() => runApp(BalloonRelaxApp());

class BalloonRelaxApp extends StatelessWidget {
  const BalloonRelaxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Balloon Relax - Ahmad Raza (SAP: 54471)',
      home: BalloonGame(),
    );
  }
}
