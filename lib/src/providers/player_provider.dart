import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sicbo/src/models/player.dart';

class PlayerProvider extends StateNotifier<Player> {
  PlayerProvider(Player initialState) : super(initialState);

  addCredits(int amount) {
    state = state.addCredits(amount);
  }
}

final playerProvider = StateNotifierProvider<PlayerProvider, Player>((ref) {
  return PlayerProvider(Player(name: "Tyler", credits: 100));
});
