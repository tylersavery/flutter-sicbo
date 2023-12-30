import 'package:flutter/material.dart';
import 'package:sicbo/src/components/betting_board.dart';
import 'package:sicbo/src/components/game_board.dart';
import 'package:sicbo/src/components/roll_history_list.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sic bo"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: GameBoard(),
          ),
          RollHistoryList(),
          BettingBoard()
        ],
      ),
    );
  }
}
