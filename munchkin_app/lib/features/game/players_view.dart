import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme.dart';
import '../../application/session_controller.dart';
import '../../l10n/app_localizations.dart';

const List<Color> _avatarPalette = <Color>[
  Color(0xFFB3541E),
  Color(0xFF5E7A3E),
  Color(0xFF3E6B7A),
  Color(0xFF7A3E6B),
  Color(0xFF7A6B3E),
  Color(0xFF3E4F7A),
  Color(0xFF7A3E3E),
  Color(0xFF3E7A5E),
];

Color _avatarColorFor(String playerId) =>
    _avatarPalette[playerId.hashCode.abs() % _avatarPalette.length];

class PlayersView extends ConsumerWidget {
  const PlayersView({super.key, required this.onOpenCharacter});

  final VoidCallback onOpenCharacter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(sessionControllerProvider).game!;
    final myPlayerId = ref.read(sessionControllerProvider.notifier).playerId;
    final l10n = AppLocalizations.of(context);
    final maxPower = game.players.isEmpty
        ? 0
        : game.players.map((p) => p.totalPower).reduce((a, b) => a > b ? a : b);

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: game.turnOrder.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final player = game.playerById(game.turnOrder[index])!;
        final active = player.id == game.activePlayerId;
        final isMe = player.id == myPlayerId;
        final isLeader = player.totalPower == maxPower && maxPower > 0;
        final scheme = Theme.of(context).colorScheme;
        final avatarColor = _avatarColorFor(player.id);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: isMe
                ? Border.all(color: scheme.primary, width: 2)
                : Border.all(color: Colors.transparent, width: 2),
          ),
          child: Card(
            color: active ? scheme.primaryContainer : null,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              onTap: isMe ? onOpenCharacter : null,
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
                              color: Colors.amber.shade600,
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
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  player.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ),
                              if (isMe) ...<Widget>[
                                const SizedBox(width: AppSpacing.xs),
                                _Tag(label: l10n.youTag, color: scheme.primary),
                              ],
                              if (active) ...<Widget>[
                                const SizedBox(width: AppSpacing.xs),
                                _Tag(
                                  label: l10n.currentTurn,
                                  color: scheme.onPrimaryContainer,
                                  outlined: true,
                                ),
                              ],
                              if (!player.isConnected) ...<Widget>[
                                const SizedBox(width: AppSpacing.xs),
                                Icon(
                                  Icons.cloud_off,
                                  size: 16,
                                  color: scheme.error,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${l10n.level} ${player.level}  ·  ${l10n.strength} ${player.strength}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
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
                                color: isLeader ? Colors.amber.shade800 : null,
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
