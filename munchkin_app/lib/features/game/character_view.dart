import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme.dart';
import '../../application/session_controller.dart';
import '../../domain/commands/game_command.dart';
import '../../domain/models/game_models.dart';
import '../../l10n/app_localizations.dart';
import 'turn_view.dart';

class CharacterView extends ConsumerWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider);
    final controller = ref.read(sessionControllerProvider.notifier);
    final player = session.game!.playerById(controller.playerId);
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    if (player == null) return const Center(child: CircularProgressIndicator());
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: <Widget>[
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
          actions: <Widget>[
            IconButton.filledTonal(
              onPressed: session.busy
                  ? null
                  : () => controller.send(
                      const GameCommand.adjustStats(levelDelta: -1),
                    ),
              icon: const Icon(Icons.remove),
            ),
            IconButton.filled(
              onPressed: session.busy
                  ? null
                  : () => controller.send(
                      const GameCommand.adjustStats(levelDelta: 1),
                    ),
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
                      ),
                child: Text(delta > 0 ? '+$delta' : '$delta'),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        _EquipmentCard(
          player: player,
          busy: session.busy,
          controller: controller,
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
                const SizedBox(height: 4),
                Text(
                  l10n.totalPowerBreakdown(
                    player.level,
                    player.strength,
                    player.equipment.total,
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (session.game!.battle == null) ...<Widget>[
          const SizedBox(height: AppSpacing.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: TurnActions(
                isActive: player.id == session.game!.activePlayerId,
                busy: session.busy,
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
  });

  final String label;
  final int value;
  final IconData icon;
  final List<Widget> actions;

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
            Text('$value', style: Theme.of(context).textTheme.displaySmall),
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

class _EquipmentCard extends StatelessWidget {
  const _EquipmentCard({
    required this.player,
    required this.busy,
    required this.controller,
  });

  final Player player;
  final bool busy;
  final SessionController controller;

  static const Map<EquipmentSlot, IconData> _icons = <EquipmentSlot, IconData>{
    EquipmentSlot.headgear: Icons.sports_motorsports,
    EquipmentSlot.armor: Icons.shield,
    EquipmentSlot.weapon: Icons.gavel,
    EquipmentSlot.footgear: Icons.directions_walk,
    EquipmentSlot.other: Icons.inventory_2,
  };

  String _labelFor(AppLocalizations l10n, EquipmentSlot slot) => switch (slot) {
    EquipmentSlot.headgear => l10n.equipmentHeadgear,
    EquipmentSlot.armor => l10n.equipmentArmor,
    EquipmentSlot.weapon => l10n.equipmentWeapon,
    EquipmentSlot.footgear => l10n.equipmentFootgear,
    EquipmentSlot.other => l10n.equipmentOther,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.backpack,
                    size: 18,
                    color: scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n.equipment,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  Text(
                    '+${player.equipment.total}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: scheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            for (final slot in EquipmentSlot.values)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: <Widget>[
                    Icon(
                      _icons[slot],
                      size: 20,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        _labelFor(l10n, slot),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    SizedBox(
                      width: 28,
                      child: Text(
                        '${player.equipment.forSlot(slot)}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: busy
                          ? null
                          : () => controller.send(
                              GameCommand.adjustEquipment(
                                slot: slot,
                                delta: -1,
                              ),
                            ),
                      icon: const Icon(Icons.remove_circle_outline, size: 20),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: busy
                          ? null
                          : () => controller.send(
                              GameCommand.adjustEquipment(slot: slot, delta: 1),
                            ),
                      icon: const Icon(Icons.add_circle_outline, size: 20),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
