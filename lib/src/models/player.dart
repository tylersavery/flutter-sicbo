class Player {
  final String name;
  final int credits;

  const Player({required this.name, required this.credits});

  Player addCredits(int credits) {
    return Player(
      name: name,
      credits: credits += this.credits,
    );
  }
}
