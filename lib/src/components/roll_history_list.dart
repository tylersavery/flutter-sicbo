import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sicbo/src/components/die.dart';
import 'package:sicbo/src/providers/roll_history_provider.dart';

class RollHistoryList extends ConsumerWidget {
  const RollHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolls = ref.watch(rollHistoryProvider);
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
      width: double.infinity,
      height: 48,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: rolls.length,
            itemBuilder: (context, index) {
              final roll = rolls[index];

              final isLast = index >= rolls.length - 1;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...roll.map((v) {
                    return Die(
                      value: v,
                      size: 32,
                    );
                  }).toList(),
                  if (!isLast)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 1,
                        height: 40,
                        color: Colors.white30,
                      ),
                    )
                ],
              );
            }),
      ),
    );
  }
}
