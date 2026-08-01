import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/session_controller.dart';
import '../../domain/commands/game_command.dart';
import '../../l10n/app_localizations.dart';

class CharacterView extends ConsumerWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider);
    final controller = ref.read(sessionControllerProvider.notifier);
    final player = session.game!.playerById(controller.playerId);
    final game = session.game!;
    final l10n = AppLocalizations.of(context);
    if (player == null) return const Center(child: CircularProgressIndicator());
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(player.name, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 24),
        _StatCard(
          label: l10n.level,
          value: player.level,
          actions: controller.isHost
              ? <Widget>[
                  IconButton.filledTonal(
                    onPressed:
                        session.busy || player.level <= game.settings.minLevel
                        ? null
                        : () => controller.send(
                            GameCommand.adjustPlayerLevel(
                              playerId: player.id,
                              delta: -1,
                            ),
                          ),
                    icon: const Icon(Icons.remove),
                  ),
                  IconButton.filled(
                    onPressed:
                        session.busy || player.level >= game.settings.maxLevel
                        ? null
                        : () => controller.send(
                            GameCommand.adjustPlayerLevel(
                              playerId: player.id,
                              delta: 1,
                            ),
                          ),
                    icon: const Icon(Icons.add),
                  ),
                ]
              : const <Widget>[],
        ),
        const SizedBox(height: 12),
        _StatCard(
          label: l10n.strength,
          value: player.strength,
          actions: <Widget>[
            for (final delta in <int>[-5, -1, 1, 5])
              FilledButton.tonal(
                onPressed:
                    session.busy ||
                        player.strength + delta < game.settings.minStrength ||
                        player.strength + delta > game.settings.maxStrength
                    ? null
                    : () => controller.send(
                        GameCommand.adjustStats(strengthDelta: delta),
                      ),
                child: Text(delta > 0 ? '+$delta' : '$delta'),
              ),
          ],
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                Text(l10n.totalPower),
                Text(
                  '${player.totalPower}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.actions,
  });

  final String label;
  final int value;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text('$value', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: actions,
          ),
        ],
      ),
    ),
  );
}
