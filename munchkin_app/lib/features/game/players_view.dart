import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme.dart';
import '../../application/session_controller.dart';
import '../../domain/models/game_models.dart';
import '../../l10n/app_localizations.dart';
import 'identity_labels.dart';

String _identitySummary(AppLocalizations l10n, Player player) {
  final races = player.races.map((race) => raceLabel(l10n, race)).join('/');
  final classes = player.classes
      .map((charClass) => classLabel(l10n, charClass))
      .join('/');
  return classes.isEmpty ? races : '$races · $classes';
}

class PlayersView extends ConsumerWidget {
  const PlayersView({super.key, required this.onOpenCharacter});

  final VoidCallback onOpenCharacter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(sessionControllerProvider).game!;
    final controller = ref.read(sessionControllerProvider.notifier);
    final myPlayerId = controller.playerId;
    final l10n = AppLocalizations.of(context);
    final maxPower = game.players.isEmpty
        ? 0
        : game.players.map((p) => p.totalPower).reduce((a, b) => a > b ? a : b);
    final activePlayerId = game.activePlayerId;
    final activeIndex = activePlayerId == null
        ? -1
        : game.turnOrder.indexOf(activePlayerId);
    final nextPlayerId = activeIndex >= 0 && game.turnOrder.length > 1
        ? game.turnOrder[(activeIndex + 1) % game.turnOrder.length]
        : null;

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: game.turnOrder.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final player = game.playerById(game.turnOrder[index])!;
        final active = player.id == game.activePlayerId;
        final isNext = player.id == nextPlayerId;
        final isMe = player.id == myPlayerId;
        final isMine = controller.controlsPlayer(player.id);
        final isWinner = player.id == game.winnerPlayerId;
        final isLeader = player.totalPower == maxPower && maxPower > 0;
        final scheme = Theme.of(context).colorScheme;
        final avatarColor = avatarColorFor(player.id);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: isWinner
                ? Border.all(color: leaderGold(context), width: 2)
                : isMine
                ? Border.all(color: scheme.primary, width: 2)
                : Border.all(color: Colors.transparent, width: 2),
          ),
          child: Card(
            color: active ? scheme.primaryContainer : null,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              onTap: isMine
                  ? () {
                      controller.selectViewedPlayer(player.id);
                      onOpenCharacter();
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: <Widget>[
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: avatarColor,
                          child: Text(
                            player.name.isEmpty
                                ? '?'
                                : player.name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (isLeader)
                          Positioned(
                            top: -6,
                            right: -6,
                            child: Icon(
                              Icons.emoji_events,
                              size: 18,
                              color: leaderGold(context),
                              shadows: const <Shadow>[
                                Shadow(color: Colors.black26, blurRadius: 2),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            player.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 2),
                          Wrap(
                            spacing: AppSpacing.xs,
                            runSpacing: 2,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              if (isMe)
                                _Tag(label: l10n.youTag, color: scheme.primary)
                              else if (isMine)
                                _Tag(
                                  label: l10n.localPlayerTag,
                                  color: scheme.primary,
                                  outlined: true,
                                ),
                              if (active)
                                _Tag(
                                  label: l10n.currentTurn,
                                  color: scheme.onPrimaryContainer,
                                  outlined: true,
                                ),
                              if (isWinner)
                                _Tag(
                                  label: l10n.gameWinnerBadge,
                                  color: leaderGold(context),
                                )
                              else if (isNext)
                                _Tag(
                                  label: l10n.upNextTag,
                                  color: scheme.onSurfaceVariant,
                                  outlined: true,
                                ),
                              if (!player.isConnected)
                                Icon(
                                  Icons.cloud_off,
                                  size: 16,
                                  color: scheme.error,
                                ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            player.peakLevel > player.level
                                ? '${l10n.level} ${player.level}  ·  ${l10n.strength} ${player.strength}  ·  ${l10n.peakLevelCaption(player.peakLevel)}'
                                : '${l10n.level} ${player.level}  ·  ${l10n.strength} ${player.strength}',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                          if (game.settings.trackRaceClass) ...<Widget>[
                            const SizedBox(height: 2),
                            Text(
                              _identitySummary(l10n, player),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: scheme.primary,
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${player.totalPower}',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: isLeader ? leaderGold(context) : null,
                              ),
                        ),
                        Text(
                          l10n.totalPower,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color, this.outlined = false});

  final String label;
  final Color color;
  final bool outlined;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: outlined ? Colors.transparent : color.withValues(alpha: 0.15),
      border: outlined ? Border.all(color: color, width: 1) : null,
      borderRadius: BorderRadius.circular(AppRadius.sm),
    ),
    child: Text(
      label,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: color,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
