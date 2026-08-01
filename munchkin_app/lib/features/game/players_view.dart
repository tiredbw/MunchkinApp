import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/session_controller.dart';
import '../../l10n/app_localizations.dart';

class PlayersView extends ConsumerWidget {
  const PlayersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(sessionControllerProvider).game!;
    final l10n = AppLocalizations.of(context);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: game.turnOrder.length,
      itemBuilder: (context, index) {
        final player = game.playerById(game.turnOrder[index])!;
        final active = player.id == game.activePlayerId;
        return Card(
          color: active ? Theme.of(context).colorScheme.primaryContainer : null,
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Row(
              children: <Widget>[
                Expanded(child: Text(player.name)),
                if (!player.isConnected) const Icon(Icons.cloud_off, size: 18),
              ],
            ),
            subtitle: Text(
              '${l10n.level}: ${player.level}  ·  ${l10n.strength}: ${player.strength}',
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${player.totalPower}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  l10n.totalPower,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
