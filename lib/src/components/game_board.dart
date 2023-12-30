import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sicbo/src/components/die.dart';
import 'package:sicbo/src/components/game_tile.dart';
import 'package:sicbo/src/constants.dart';
import 'package:sicbo/src/models/bid_type.dart';
import 'package:sicbo/src/providers/roll_provider.dart';
import 'package:sicbo/src/providers/round_state_provider.dart';

class GameBoard extends ConsumerWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height - 154;

    final w = min(screenWidth, MIN_WIDTH);
    final h = min(screenHeight, MIN_HEIGHT);

    return SizedBox(
      width: w,
      height: h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GameTile(
                    width: 4,
                    height: 4,
                    heading: "SMALL",
                    label: "Sum of 1-10",
                    hint: "1 wins 1\n Lose on any triple",
                    bidType: BidType.small,
                  ),
                  Column(
                    children: [
                      GameTile(
                        width: 3,
                        height: 1,
                        label: "Each double 1 wins 11",
                      ),
                      Row(
                        children: [
                          GameTile(
                            width: 1,
                            height: 3,
                            bidType: BidType.doubleOne,
                            diceGrid: [
                              [1],
                              [1]
                            ],
                          ),
                          GameTile(
                            width: 1,
                            height: 3,
                            bidType: BidType.doubleTwo,
                            diceGrid: [
                              [2],
                              [2]
                            ],
                          ),
                          GameTile(
                            width: 1,
                            height: 3,
                            bidType: BidType.doubleThree,
                            diceGrid: [
                              [3],
                              [3]
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      GameTile(
                        width: 3,
                        height: 1,
                        label: "Each triple 1 wins 180",
                      ),
                      GameTile(
                        width: 3,
                        height: 1,
                        bidType: BidType.tripleOne,
                        diceGrid: [
                          [1, 1, 1],
                        ],
                      ),
                      GameTile(
                        width: 3,
                        height: 1,
                        bidType: BidType.tripleTwo,
                        diceGrid: [
                          [2, 2, 2],
                        ],
                      ),
                      GameTile(
                        width: 3,
                        height: 1,
                        bidType: BidType.tripleThree,
                        diceGrid: [
                          [3, 3, 3],
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GameTile(
                        width: 2,
                        height: 1,
                        label: "1 wins 30",
                      ),
                      GameTile(
                        width: 2,
                        height: 3,
                        bidType: BidType.tripleAny,
                        diceGrid: [
                          [1, 1, 1],
                          [2, 2, 2],
                          [3, 3, 3],
                          [4, 4, 4],
                          [5, 5, 5],
                          [6, 6, 6],
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GameTile(
                        width: 3,
                        height: 1,
                        label: "Each triple 1 wins 180",
                      ),
                      GameTile(
                        width: 3,
                        height: 1,
                        bidType: BidType.tripleFour,
                        diceGrid: [
                          [4, 4, 4],
                        ],
                      ),
                      GameTile(
                        width: 3,
                        height: 1,
                        bidType: BidType.tripleFive,
                        diceGrid: [
                          [5, 5, 5],
                        ],
                      ),
                      GameTile(
                        width: 3,
                        height: 1,
                        bidType: BidType.tripleSix,
                        diceGrid: [
                          [6, 6, 6],
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GameTile(
                        width: 3,
                        height: 1,
                        label: "Each double 1 wins 11",
                      ),
                      Row(
                        children: [
                          GameTile(
                            width: 1,
                            height: 3,
                            bidType: BidType.doubleFour,
                            diceGrid: [
                              [4],
                              [4]
                            ],
                          ),
                          GameTile(
                            width: 1,
                            height: 3,
                            bidType: BidType.doubleFive,
                            diceGrid: [
                              [5],
                              [5]
                            ],
                          ),
                          GameTile(
                            width: 1,
                            height: 3,
                            bidType: BidType.doubleSix,
                            diceGrid: [
                              [6],
                              [6]
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  GameTile(
                    width: 4,
                    height: 4,
                    heading: "BIG",
                    label: "Sum of 11-17",
                    hint: "1 wins 1\n Lose on any triple",
                    bidType: BidType.big,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BidType.sumFour,
                  BidType.sumFive,
                  BidType.sumSix,
                  BidType.sumSeven,
                  BidType.sumEight,
                  BidType.sumNine,
                  BidType.sumTen,
                  BidType.sumEleven,
                  BidType.sumTwelve,
                  BidType.sumThirteen,
                  BidType.sumFourteen,
                  BidType.sumFifteen,
                  BidType.sumSixteen,
                  BidType.sumSeventeen,
                ].map(
                  (type) {
                    return GameTile(
                      width: 1.57,
                      height: 2,
                      bidType: type,
                      heading: "${type.value}",
                      hint: "1 wins ${type.multiplier}",
                    );
                  },
                ).toList(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GameTile(
                    width: 3,
                    height: 2,
                    label: "2 die 1 wins 6 >",
                  ),
                  ...[
                    BidType.comboOneTwo,
                    BidType.comboOneThree,
                    BidType.comboOneFour,
                    BidType.comboOneFive,
                    BidType.comboOneSix,
                    BidType.comboTwoThree,
                    BidType.comboTwoFour,
                    BidType.comboTwoFive,
                    BidType.comboTwoSix,
                    BidType.comboThreeFour,
                    BidType.comboThreeFive,
                    BidType.comboThreeSix,
                    BidType.comboFourFive,
                    BidType.comboFourSix,
                    BidType.comboFiveSix,
                  ].map((type) {
                    return GameTile(
                      width: 1.265,
                      height: 2,
                      bidType: type,
                      diceGrid: [
                        [type.value!],
                        [type.secondaryValue!]
                      ],
                    );
                  }).toList(),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BidType.singleOne,
                  BidType.singleTwo,
                  BidType.singleThree,
                  BidType.singleFour,
                  BidType.singleFive,
                  BidType.singleSix,
                ]
                    .map((type) => GameTile(
                          width: 3.66,
                          height: 1,
                          bidType: type,
                          diceGrid: [
                            [type.value!]
                          ],
                        ))
                    .toList(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GameTile(
                    width: 7.32,
                    height: 1,
                    heading: "1:1 on one die",
                  ),
                  GameTile(
                    width: 7.32,
                    height: 1,
                    heading: "2:1 on two dice",
                  ),
                  GameTile(
                    width: 7.32,
                    height: 1,
                    heading: "3:1 on three dice",
                  )
                ],
              )
            ],
          ),
          if (ref.watch(roundStateProvider) == RoundState.rolling && ref.watch(rollProvider) != null)
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: ref.watch(rollProvider)!.map((value) {
                      return Die(value: value, size: 128);
                    }).toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
