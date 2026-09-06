import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme.dart';
import '../../application/session_controller.dart';
import '../../domain/commands/game_command.dart';
import '../../domain/models/game_models.dart';
import '../../l10n/app_localizations.dart';
import 'identity_labels.dart';
import 'turn_view.dart';

class CharacterView extends ConsumerWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider);
    final controller = ref.read(sessionControllerProvider.notifier);
    final viewedPlayerId = controller.viewedPlayerId;
    final player = session.game!.playerById(viewedPlayerId);
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    if (player == null) return const Center(child: CircularProgressIndicator());
    final myPlayers = controller.controlledPlayerIds
        .map((id) => session.game!.playerById(id))
        .whereType<Player>()
        .toList(growable: false);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: <Widget>[
        if (myPlayers.length > 1) ...<Widget>[
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: <Widget>[
              for (final candidate in myPlayers)
                ChoiceChip(
                  avatar: CircleAvatar(
                    backgroundColor: avatarColorFor(candidate.id),
                    child: Text(
                      candidate.name.isEmpty
                          ? '?'
                          : candidate.name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  label: Text(candidate.name),
                  selected: candidate.id == player.id,
                  onSelected: (_) => controller.selectViewedPlayer(
                    candidate.id,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 26,
              backgroundColor: scheme.primary,
              child: Text(
                player.name.isEmpty
                    ? '?'
                    : player.name.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: scheme.onPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                player.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _StatCard(
          label: l10n.level,
          value: player.level,
          icon: Icons.military_tech,
          caption: player.peakLevel > player.level
              ? l10n.peakLevelCaption(player.peakLevel)
              : null,
          actions: <Widget>[
            IconButton.filledTonal(
              onPressed: session.busy
                  ? null
                  : () {
                      HapticFeedback.selectionClick();
                      controller.send(
                        const GameCommand.adjustStats(levelDelta: -1),
                        actAsPlayerId: viewedPlayerId,
                      );
                    },
              icon: const Icon(Icons.remove),
            ),
            IconButton.filled(
              onPressed: session.busy
                  ? null
                  : () {
                      HapticFeedback.selectionClick();
                      controller.send(
                        const GameCommand.adjustStats(levelDelta: 1),
                        actAsPlayerId: viewedPlayerId,
                      );
                    },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        _StatCard(
          label: l10n.strength,
          value: player.strength,
          icon: Icons.fitness_center,
          actions: <Widget>[
            for (final delta in <int>[-5, -1, 1, 5])
              FilledButton.tonal(
                onPressed: session.busy
                    ? null
                    : () => controller.send(
                        GameCommand.adjustStats(strengthDelta: delta),
                        actAsPlayerId: viewedPlayerId,
                      ),
                child: Text(delta > 0 ? '+$delta' : '$delta'),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Card(
          color: scheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: <Widget>[
                Text(
                  l10n.totalPower,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${player.totalPower}',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (session.game!.settings.trackRaceClass) ...<Widget>[
          const SizedBox(height: AppSpacing.sm),
          _IdentityCard(
            player: player,
            busy: session.busy,
            controller: controller,
            viewedPlayerId: viewedPlayerId,
          ),
        ],
        if (session.game!.battle == null) ...<Widget>[
          const SizedBox(height: AppSpacing.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: TurnActions(
                isActive: player.id == session.game!.activePlayerId,
                busy: session.busy,
                actingPlayerId: player.id,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.actions,
    this.caption,
  });

  final String label;
  final int value;
  final IconData icon;
  final List<Widget> actions;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 18, color: scheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Text(label, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 4),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              ),
              child: Text(
                '$value',
                key: ValueKey<int>(value),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            if (caption != null) ...<Widget>[
              const SizedBox(height: 2),
              Text(
                caption!,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              alignment: WrapAlignment.center,
              children: actions,
            ),
          ],
        ),
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({
    required this.player,
    required this.busy,
    required this.controller,
    required this.viewedPlayerId,
  });

  final Player player;
  final bool busy;
  final SessionController controller;
  final String? viewedPlayerId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.auto_awesome,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Text(
                  l10n.identity,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: <Widget>[
                for (final race in MunchkinRace.values)
                  FilterChip(
                    avatar: Icon(raceIcons[race], size: 16),
                    label: Text(raceLabel(l10n, race)),
                    selected: player.races.contains(race),
                    onSelected: busy
                        ? null
                        : (selected) {
                            final next = <MunchkinRace>{...player.races};
                            if (selected) {
                              next.add(race);
                            } else if (next.length > 1) {
                              // A munchkin always keeps at least one race.
                              next.remove(race);
                            }
                            controller.send(
                              GameCommand.setIdentity(
                                races: next.toList(growable: false),
                                classes: player.classes,
                              ),
                              actAsPlayerId: viewedPlayerId,
                            );
                          },
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: <Widget>[
                for (final charClass in MunchkinClass.values)
                  FilterChip(
                    avatar: Icon(classIcons[charClass], size: 16),
                    label: Text(classLabel(l10n, charClass)),
                    selected: player.classes.contains(charClass),
                    onSelected: busy
                        ? null
                        : (selected) {
                            final next = <MunchkinClass>{...player.classes};
                            if (selected) {
                              next.add(charClass);
                            } else {
                              next.remove(charClass);
                            }
                            controller.send(
                              GameCommand.setIdentity(
                                races: player.races,
                                classes: next.toList(growable: false),
                              ),
                              actAsPlayerId: viewedPlayerId,
                            );
                          },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
