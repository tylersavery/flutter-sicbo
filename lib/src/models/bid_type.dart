enum BidType {
  small(1, null, null),
  big(1, null, null),
  doubleOne(11, 1, null),
  doubleTwo(11, 2, null),
  doubleThree(11, 3, null),
  doubleFour(11, 4, null),
  doubleFive(11, 5, null),
  doubleSix(11, 6, null),
  tripleOne(180, 1, null),
  tripleTwo(180, 2, null),
  tripleThree(180, 3, null),
  tripleFour(180, 4, null),
  tripleFive(180, 5, null),
  tripleSix(180, 6, null),
  tripleAny(30, null, null),
  sumFour(60, 4, null),
  sumFive(20, 5, null),
  sumSix(18, 6, null),
  sumSeven(12, 7, null),
  sumEight(8, 8, null),
  sumNine(6, 9, null),
  sumTen(6, 10, null),
  sumEleven(6, 11, null),
  sumTwelve(6, 12, null),
  sumThirteen(8, 13, null),
  sumFourteen(12, 14, null),
  sumFifteen(18, 15, null),
  sumSixteen(20, 16, null),
  sumSeventeen(60, 17, null),
  comboOneTwo(6, 1, 2),
  comboOneThree(6, 1, 3),
  comboOneFour(6, 1, 4),
  comboOneFive(6, 1, 5),
  comboOneSix(6, 1, 6),
  comboTwoThree(6, 2, 3),
  comboTwoFour(6, 2, 4),
  comboTwoFive(6, 2, 5),
  comboTwoSix(6, 2, 6),
  comboThreeFour(6, 3, 4),
  comboThreeFive(6, 3, 5),
  comboThreeSix(6, 3, 6),
  comboFourFive(6, 4, 5),
  comboFourSix(6, 4, 6),
  comboFiveSix(6, 5, 6),
  singleOne(1, 1, null),
  singleTwo(1, 2, null),
  singleThree(1, 3, null),
  singleFour(1, 4, null),
  singleFive(1, 5, null),
  singleSix(1, 6, null),
  ;

  final int multiplier;
  final int? value;
  final int? secondaryValue;

  const BidType(
    this.multiplier,
    this.value,
    this.secondaryValue,
  );
}

bool isWinner(BidType type, List<int> roll) {
  final sum = roll.fold(0, (a, b) => a + b);

  switch (type) {
    case BidType.big:
      if (roll.every((element) => element == roll.first)) {
        return false;
      }
      if (sum > 10) {
        return true;
      }
    case BidType.small:
      if (roll.every((element) => element == roll.first)) {
        return false;
      }
      if (sum < 11) {
        return true;
      }
    case BidType.doubleOne:
    case BidType.doubleTwo:
    case BidType.doubleThree:
    case BidType.doubleFour:
    case BidType.doubleFive:
    case BidType.doubleSix:
      if (roll.where((v) => v == type.value).length >= 2) {
        return true;
      }
    case BidType.tripleOne:
    case BidType.tripleTwo:
    case BidType.tripleThree:
    case BidType.tripleFour:
    case BidType.tripleFive:
    case BidType.tripleSix:
      if (roll.where((v) => v == type.value).length == 3) {
        return true;
      }
    case BidType.tripleAny:
      return roll.every((element) => element == roll.first);
    case BidType.sumFour:
    case BidType.sumFive:
    case BidType.sumSix:
    case BidType.sumSeven:
    case BidType.sumEight:
    case BidType.sumNine:
    case BidType.sumTen:
    case BidType.sumEleven:
    case BidType.sumTwelve:
    case BidType.sumThirteen:
    case BidType.sumFourteen:
    case BidType.sumFifteen:
    case BidType.sumSixteen:
    case BidType.sumSeventeen:
      return sum == type.value;
    case BidType.comboOneTwo:
    case BidType.comboOneThree:
    case BidType.comboOneFour:
    case BidType.comboOneFive:
    case BidType.comboOneSix:
    case BidType.comboTwoThree:
    case BidType.comboTwoFour:
    case BidType.comboTwoFive:
    case BidType.comboTwoSix:
    case BidType.comboThreeFour:
    case BidType.comboThreeFive:
    case BidType.comboThreeSix:
    case BidType.comboFourFive:
    case BidType.comboFourSix:
    case BidType.comboFiveSix:
      final v1 = type.value;
      final v2 = type.secondaryValue;
      return roll.contains(v1) && roll.contains(v2);
    case BidType.singleOne:
    case BidType.singleTwo:
    case BidType.singleThree:
    case BidType.singleFour:
    case BidType.singleFive:
    case BidType.singleSix:
      return roll.contains(type.value);
  }

  return false;
}
