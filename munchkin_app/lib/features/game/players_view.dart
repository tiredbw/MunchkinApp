import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/session_controller.dart';
import '../../domain/commands/game_command.dart';
import '../../domain/models/game_models.dart';
import '../../l10n/app_localizations.dart';

class PlayersView extends ConsumerWidget {
  const PlayersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(sessionControllerProvider).game!;
    final session = ref.watch(sessionControllerProvider);
    final controller = ref.read(sessionControllerProvider.notifier);
    final isHost = controller.isHost;
    final l10n = AppLocalizations.of(context);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: game.turnOrder.length,
      itemBuilder: (context, index) {
        final player = game.playerById(game.turnOrder[index])!;
        final active = player.id == game.activePlayerId;
        final assignment = game.assignmentFor(player.id);
        final controllerPlayer = game.playerById(
          assignment?.controllerPlayerId,
        );
        final status = player.isConnected
            ? l10n.connected
            : assignment?.status == ControlAssignmentStatus.pending
            ? l10n.pendingAssignment
            : assignment?.status == ControlAssignmentStatus.active
            ? l10n.controlledOnDevice(controllerPlayer?.name ?? '')
            : l10n.offline;
        return Card(
          color: active ? Theme.of(context).colorScheme.primaryContainer : null,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(player.name),
                subtitle: Text(
                  '${l10n.level}: ${player.level} · ${l10n.strength}: ${player.strength}\n$status',
                ),
                isThreeLine: true,
                trailing: Text(
                  '${player.totalPower}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (isHost)
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        tooltip: l10n.decreaseLevel,
                        onPressed:
                            session.busy ||
                                game.battle != null ||
                                player.level <= game.settings.minLevel
                            ? null
                            : () => controller.send(
                                GameCommand.adjustPlayerLevel(
                                  playerId: player.id,
                                  delta: -1,
                                ),
                              ),
                        icon: const Icon(Icons.remove),
                      ),
                      IconButton(
                        tooltip: l10n.increaseLevel,
                        onPressed:
                            session.busy ||
                                game.battle != null ||
                                player.level >= game.settings.maxLevel
                            ? null
                            : () => controller.send(
                                GameCommand.adjustPlayerLevel(
                                  playerId: player.id,
                                  delta: 1,
                                ),
                              ),
                        icon: const Icon(Icons.add),
                      ),
                      if (!player.isHost && !player.isConnected)
                        assignment == null
                            ? IconButton(
                                tooltip: l10n.assignDevice,
                                onPressed: session.busy
                                    ? null
                                    : () => _assignPlayer(
                                        context,
                                        controller,
                                        game,
                                        player,
                                      ),
                                icon: const Icon(Icons.devices_other),
                              )
                            : IconButton(
                                tooltip: l10n.revokeAssignment,
                                onPressed: session.busy
                                    ? null
                                    : () => controller.send(
                                        GameCommand.revokeControl(player.id),
                                      ),
                                icon: const Icon(Icons.link_off),
                              ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _assignPlayer(
    BuildContext context,
    SessionController controller,
    GameState game,
    Player player,
  ) async {
    final candidates = game.players
        .where((value) => value.isConnected && value.id != player.id)
        .toList(growable: false);
    final targetId = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(AppLocalizations.of(context).chooseDevice),
        children: candidates
            .map(
              (candidate) => SimpleDialogOption(
                onPressed: () => Navigator.pop(context, candidate.id),
                child: Text(candidate.name),
              ),
            )
            .toList(growable: false),
      ),
    );
    if (targetId == null) return;
    await controller.send(
      GameCommand.offerControl(
        playerId: player.id,
        controllerPlayerId: targetId,
      ),
    );
  }
}
