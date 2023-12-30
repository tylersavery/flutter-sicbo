// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sicbo/src/components/betting_chip.dart';
import 'package:sicbo/src/components/die.dart';
import 'package:sicbo/src/constants.dart';
import 'package:sicbo/src/models/bid_type.dart';
import 'package:sicbo/src/providers/bid_amount_provider.dart';
import 'package:sicbo/src/providers/bids_provider.dart';
import 'package:collection/collection.dart';
import 'package:sicbo/src/providers/credits_provider.dart';
import 'package:sicbo/src/providers/round_state_provider.dart';
import 'package:sicbo/src/providers/winning_bid_types_provider.dart';

class GameTile extends ConsumerWidget {
  final BidType? bidType;
  final double width;
  final double height;
  final String? heading;
  final String? label;
  final String? hint;
  final List<List<int>> diceGrid;

  const GameTile({
    super.key,
    required this.width,
    required this.height,
    this.heading,
    this.label,
    this.hint,
    this.bidType,
    this.diceGrid = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double scaleX = 1.0;
    double scaleY = 1.0;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height - 154;

    if (screenWidth < MIN_WIDTH) {
      scaleX = screenWidth / MIN_WIDTH;
    }

    if (screenHeight < MIN_HEIGHT) {
      scaleY = screenHeight / MIN_HEIGHT;
    }

    final scale = min(scaleX, scaleY);

    final w = width * TILE_UNIT_PIXELS * scale;
    final h = height * TILE_UNIT_PIXELS * scale;

    final diceGridMaxRows = diceGrid.length;
    final diceGridMaxCols = diceGrid.fold(0, (max, list) => list.length > max ? list.length : max);

    final diceGridDieSize = min((w - 12) / diceGridMaxCols, (h - 12) / diceGridMaxRows);

    final bid = bidType != null ? ref.watch(bidsProvider).firstWhereOrNull((b) => b.type == bidType) : null;

    Color bgColor = Colors.transparent;
    bool canBid = false;
    if (bidType != null) {
      bgColor = ref.watch(winningBidTypesProvider).contains(bidType)
          ? ref.watch(bidsProvider).firstWhereOrNull((b) => b.type == bidType) != null
              ? Colors.yellow
              : Colors.yellow.withOpacity(0.4)
          : Colors.black12;

      canBid = ref.watch(roundStateProvider) == RoundState.betting && ref.watch(availableCreditsProvider) >= ref.watch(bidAmountProvider).value;
    }

    return SizedBox(
      width: w,
      height: h,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: canBid
              ? () {
                  ref.read(bidsProvider.notifier).add(bidType!, ref.read(bidAmountProvider));
                }
              : null,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (diceGrid.isNotEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: diceGrid.map((row) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: row.map((value) {
                          return Die(
                            value: value,
                            size: diceGridDieSize,
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (heading != null)
                      Text(
                        heading!,
                        style: TextStyle(
                          fontSize: 22 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    if (label != null)
                      Text(
                        label!,
                        style: TextStyle(
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    if (hint != null)
                      Text(
                        hint!,
                        style: TextStyle(
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
                if (bid != null && bid.amount > 0)
                  SizedBox(
                    width: TILE_UNIT_PIXELS * scale,
                    height: TILE_UNIT_PIXELS * scale,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ...bid.denominations.asMap().entries.map(
                          (entry) {
                            final b = entry.value;
                            final index = entry.key;
                            return Transform.translate(
                              key: Key("${index}_${b.value}"),
                              offset: Offset(0, -4.0 * index),
                              child: BettingChip(
                                amount: b,
                                onPressed: () {
                                  ref.read(bidsProvider.notifier).subtract(bid.type, b);
                                },
                              ),
                            );
                          },
                        ).toList(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: bid.amount >= 100
                                ? bid.amount >= 1000
                                    ? 48
                                    : 32
                                : 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.black87,
                            ),
                            child: Center(
                              child: Text(
                                bid.amount.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
