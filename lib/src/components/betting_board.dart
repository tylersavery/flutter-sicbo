import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sicbo/src/components/betting_chip.dart';
import 'package:sicbo/src/components/die.dart';
import 'package:sicbo/src/models/bid_amount.dart';
import 'package:sicbo/src/providers/bid_amount_provider.dart';
import 'package:sicbo/src/providers/credits_provider.dart';
import 'package:sicbo/src/providers/resolved_message_provider.dart';
import 'package:sicbo/src/providers/roll_provider.dart';
import 'package:sicbo/src/providers/round_state_provider.dart';

class BettingBoard extends ConsumerWidget {
  const BettingBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Consumer(builder: (context, ref, _) {
                            final credits = ref.watch(availableCreditsProvider);
                            return Text(
                              "$credits",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }),
                          Text(
                            "Credits",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer(builder: (context, ref, _) {
                    final selectedBid = ref.watch(bidAmountProvider);
                    final provider = ref.read(bidAmountProvider.notifier);

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 6.0,
                          children: BidAmount.values.map(
                            (value) {
                              return BettingChip(
                                amount: value,
                                selected: selectedBid == value,
                                onPressed: () {
                                  provider.set(value);
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (ref.watch(resolvedMessageProvider) != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ref.watch(resolvedMessageProvider)!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (ref.watch(rollProvider) != null) ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: ref.watch(rollProvider)!.map((value) {
                              return Die(value: value, size: 32);
                            }).toList(),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                        Consumer(builder: (context, ref, _) {
                          final roundState = ref.watch(roundStateProvider);

                          switch (roundState) {
                            case RoundState.betting:
                            case RoundState.rolling:
                              return ElevatedButton(
                                onPressed: roundState == RoundState.betting
                                    ? () {
                                        ref.read(roundStateProvider.notifier).roll();
                                      }
                                    : null,
                                child: SizedBox(width: 40, child: Center(child: Text("Roll"))),
                              );
                            case RoundState.resolving:
                              return ElevatedButton(
                                onPressed: () {
                                  ref.read(roundStateProvider.notifier).bet();
                                },
                                child: SizedBox(width: 40, child: Center(child: Text("Bet"))),
                              );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
