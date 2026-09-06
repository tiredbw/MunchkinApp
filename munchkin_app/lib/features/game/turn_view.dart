import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme.dart';
import '../../application/session_controller.dart';
import '../../domain/commands/game_command.dart';
import '../../domain/models/game_models.dart';
import '../../l10n/app_localizations.dart';

class TurnView extends ConsumerStatefulWidget {
  const TurnView({super.key});

  @override
  ConsumerState<TurnView> createState() => _TurnViewState();
}

class _TurnViewState extends ConsumerState<TurnView> {
  Timer? _ticker;
  int? _lastHapticSecond;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionControllerProvider);
    final controller = ref.read(sessionControllerProvider.notifier);
    final game = session.game!;
    final l10n = AppLocalizations.of(context);
    final active = game.activePlayer;
    final isActive = controller.controlsPlayer(game.activePlayerId);
    final scheme = Theme.of(context).colorScheme;
    _tickCountdownHaptic(game);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: <Widget>[
        if (active != null)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person_pin,
                  size: 18,
                  color: scheme.onSecondaryContainer,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    l10n.activePlayer(active.name),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: scheme.onSecondaryContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.md),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          switchInCurve: Curves.easeOut,
          child: Card(
            key: ValueKey<String>(game.battle?.status.name ?? 'idle'),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: _BattlePanel(
                game: game,
                isActive: isActive,
                actingPlayerId: isActive
                    ? game.activePlayerId
                    : controller.playerId,
                busy: session.busy,
                remainingSeconds: _remaining(game.battle?.endsAt),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (game.lastDiceRoll != null)
          _DiceResult(game: game, roll: game.lastDiceRoll!),
        if (isActive && game.settings.diceMode == DiceMode.virtual) ...<Widget>[
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: session.busy
                ? null
                : () => controller.send(
                    const GameCommand.rollDice(),
                    actAsPlayerId: game.activePlayerId,
                  ),
            icon: const Icon(Icons.casino),
            label: Text(l10n.rollDice),
          ),
        ],
      ],
    );
  }

  int _remaining(DateTime? endsAt) {
    if (endsAt == null) return 0;
    final milliseconds = endsAt
        .difference(DateTime.now().toUtc())
        .inMilliseconds;
    if (milliseconds <= 0) return 0;
    return (milliseconds / 1000).ceil();
  }

  /// A light tick each second the victory countdown is in its final
  /// stretch, so an intervening player feels the urgency without staring
  /// at the screen.
  void _tickCountdownHaptic(GameState game) {
    final battle = game.battle;
    if (battle == null || battle.status != BattleStatus.countdown) {
      _lastHapticSecond = null;
      return;
    }
    final remaining = _remaining(battle.endsAt);
    if (remaining > 0 && remaining <= 3 && remaining != _lastHapticSecond) {
      _lastHapticSecond = remaining;
      HapticFeedback.lightImpact();
    }
  }
}

/// Shown on both "Мой персонаж" and "Текущий ход" whenever no battle is in
/// progress: turn actions for the active player, or whose turn it is.
class TurnActions extends ConsumerWidget {
  const TurnActions({
    super.key,
    required this.isActive,
    required this.busy,
    this.actingPlayerId,
  });

  final bool isActive;
  final bool busy;
  final String? actingPlayerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(sessionControllerProvider.notifier);
    if (!isActive) {
      final activeName = ref.watch(
        sessionControllerProvider.select(
          (value) => value.game?.activePlayer?.name,
        ),
      );
      return Center(
        child: Text(
          activeName == null
              ? l10n.waitingForHost
              : l10n.activePlayer(activeName),
        ),
      );
    }
    final battleFoughtThisTurn = ref.watch(
      sessionControllerProvider.select(
        (value) => value.game?.battleFoughtThisTurn ?? false,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FilledButton.icon(
          onPressed: busy
              ? null
              : () => battleFoughtThisTurn
                    ? _confirmSecondBattle(context, controller)
                    : controller.send(
                        const GameCommand.startBattle(),
                        actAsPlayerId: actingPlayerId,
                      ),
          icon: const Icon(Icons.shield),
          label: Text(l10n.startBattle),
        ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton(
          onPressed: busy
              ? null
              : () => controller.send(
                  const GameCommand.endTurn(),
                  actAsPlayerId: actingPlayerId,
                ),
          child: Text(l10n.endTurn),
        ),
      ],
    );
  }

  Future<void> _confirmSecondBattle(
    BuildContext context,
    SessionController controller,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.startBattle),
        content: Text(l10n.battleAlreadyPlayed),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.startBattle),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await controller.send(
        const GameCommand.startBattle(),
        actAsPlayerId: actingPlayerId,
      );
    }
  }
}

class _BattlePanel extends ConsumerWidget {
  const _BattlePanel({
    required this.game,
    required this.isActive,
    required this.busy,
    required this.remainingSeconds,
    this.actingPlayerId,
  });

  final GameState game;
  final bool isActive;
  final bool busy;
  final int remainingSeconds;
  final String? actingPlayerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(sessionControllerProvider.notifier);
    final battle = game.battle;
    if (battle == null) {
      return TurnActions(
        isActive: isActive,
        busy: busy,
        actingPlayerId: actingPlayerId,
      );
    }

    switch (battle.status) {
      case BattleStatus.fighting:
        if (!isActive) {
          return _WaitingState(
            icon: Icons.sports_kabaddi,
            message: l10n.currentTurn,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FilledButton(
              onPressed: busy
                  ? null
                  : () {
                      HapticFeedback.mediumImpact();
                      controller.send(
                        const GameCommand.declareVictory(),
                        actAsPlayerId: actingPlayerId,
                      );
                    },
              child: Text(l10n.canWin),
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: busy
                  ? null
                  : () => _showCannotWin(context, controller, actingPlayerId),
              child: Text(l10n.cannotWin),
            ),
          ],
        );
      case BattleStatus.countdown:
        final total = game.settings.victoryCountdownSeconds.clamp(1, 1 << 30);
        final progress = (remainingSeconds / total).clamp(0.0, 1.0);
        return Column(
          children: <Widget>[
            _CountdownRing(
              progress: progress,
              remainingSeconds: remainingSeconds,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.victoryCountdown(remainingSeconds),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            if (!isActive)
              FilledButton.tonalIcon(
                onPressed: busy
                    ? null
                    : () => controller.send(const GameCommand.intervene()),
                icon: const Icon(Icons.front_hand),
                label: Text(l10n.intervene),
              ),
          ],
        );
      case BattleStatus.intervention:
        return _ResumePanel(
          message: l10n.interventionReceived,
          active: isActive,
          busy: busy,
          actingPlayerId: actingPlayerId,
        );
      case BattleStatus.helpRequested:
        return _ResumePanel(
          message: l10n.helpRequested,
          active: isActive,
          busy: busy,
          allowEscape: true,
          actingPlayerId: actingPlayerId,
        );
      case BattleStatus.escaping:
        if (!isActive) {
          return _WaitingState(
            icon: Icons.directions_run,
            message: l10n.escapingNow,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              game.settings.diceMode == DiceMode.physical
                  ? l10n.physicalDice
                  : l10n.escapingNow,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            if (game.settings.diceMode == DiceMode.virtual)
              OutlinedButton.icon(
                onPressed: busy
                    ? null
                    : () => controller.send(
                        const GameCommand.rollDice(),
                        actAsPlayerId: actingPlayerId,
                      ),
                icon: const Icon(Icons.casino),
                label: Text(l10n.rollDice),
              ),
            FilledButton(
              onPressed: busy
                  ? null
                  : () => controller.send(
                      const GameCommand.resolveEscape(),
                      actAsPlayerId: actingPlayerId,
                    ),
              child: Text(l10n.finishEscape),
            ),
            TextButton(
              onPressed: busy
                  ? null
                  : () => controller.send(
                      const GameCommand.resumeBattle(),
                      actAsPlayerId: actingPlayerId,
                    ),
              child: Text(l10n.resumeBattle),
            ),
          ],
        );
      case BattleStatus.won:
        if (!isActive) {
          return _WaitingState(
            icon: Icons.emoji_events,
            message: l10n.battleWon,
            color: leaderGold(context),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.emoji_events, size: 40, color: leaderGold(context)),
            const SizedBox(height: 8),
            Text(
              l10n.battleWon,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${l10n.level}: ${game.activePlayer?.level ?? 0}',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: busy
                  ? null
                  : () {
                      HapticFeedback.mediumImpact();
                      controller.send(
                        const GameCommand.raiseLevel(),
                        actAsPlayerId: actingPlayerId,
                      );
                    },
              icon: const Icon(Icons.arrow_upward),
              label: Text(l10n.raiseLevel),
            ),
            FilledButton(
              onPressed: busy
                  ? null
                  : () => controller.send(
                      const GameCommand.finishBattle(),
                      actAsPlayerId: actingPlayerId,
                    ),
              child: Text(l10n.finishBattle),
            ),
          ],
        );
      case BattleStatus.endedWithoutVictory:
        if (!isActive) {
          return _WaitingState(
            icon: Icons.directions_run,
            message: l10n.escapingNow,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              l10n.escapeOutcome,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            FilledButton.icon(
              onPressed: busy
                  ? null
                  : () => controller.send(
                      const GameCommand.finishBattle(),
                      actAsPlayerId: actingPlayerId,
                    ),
              icon: const Icon(Icons.check_circle_outline),
              label: Text(l10n.survivedEscape),
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: busy
                  ? null
                  : () =>
                        _confirmDeath(context, controller, game, actingPlayerId),
              icon: const Icon(Icons.dangerous),
              label: Text(l10n.diedInBattle),
            ),
          ],
        );
    }
  }

  Future<void> _confirmDeath(
    BuildContext context,
    SessionController controller,
    GameState game,
    String? actingPlayerId,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.diedInBattle),
        content: Text(l10n.diedInBattleConfirm(game.settings.minLevel)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.diedInBattle),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await controller.send(
        const GameCommand.dieInBattle(),
        actAsPlayerId: actingPlayerId,
      );
    }
  }

  Future<void> _showCannotWin(
    BuildContext context,
    SessionController controller,
    String? actingPlayerId,
  ) async {
    final l10n = AppLocalizations.of(context);
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FilledButton.tonal(
                onPressed: () {
                  Navigator.pop(context);
                  controller.send(
                    const GameCommand.requestHelp(),
                    actAsPlayerId: actingPlayerId,
                  );
                },
                child: Text(l10n.requestHelp),
              ),
              const SizedBox(height: AppSpacing.sm),
              FilledButton.tonal(
                onPressed: () {
                  Navigator.pop(context);
                  controller.send(
                    const GameCommand.startEscape(),
                    actAsPlayerId: actingPlayerId,
                  );
                },
                child: Text(l10n.escape),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.backToBattle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountdownRing extends StatelessWidget {
  const _CountdownRing({
    required this.progress,
    required this.remainingSeconds,
  });

  final double progress;
  final int remainingSeconds;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final urgent = remainingSeconds <= 3;
    final color = urgent ? scheme.error : scheme.primary;
    return SizedBox(
      width: 128,
      height: 128,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            tween: Tween<double>(begin: progress, end: progress),
            builder: (context, value, _) => CustomPaint(
              size: const Size.square(128),
              painter: _RingPainter(
                progress: value,
                color: color,
                trackColor: scheme.surfaceContainerHighest,
              ),
            ),
          ),
          Text(
            '$remainingSeconds',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
  });

  final double progress;
  final Color color;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 8;
    final track = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    final arc = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, track);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

class _WaitingState extends StatelessWidget {
  const _WaitingState({required this.icon, required this.message, this.color});

  final IconData icon;
  final String message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 32, color: color ?? scheme.onSurfaceVariant),
        const SizedBox(height: AppSpacing.sm),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

class _ResumePanel extends ConsumerWidget {
  const _ResumePanel({
    required this.message,
    required this.active,
    required this.busy,
    this.allowEscape = false,
    this.actingPlayerId,
  });

  final String message;
  final bool active;
  final bool busy;
  final bool allowEscape;
  final String? actingPlayerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(sessionControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(message, textAlign: TextAlign.center),
        if (active) ...<Widget>[
          const SizedBox(height: AppSpacing.sm),
          FilledButton(
            onPressed: busy
                ? null
                : () {
                    HapticFeedback.mediumImpact();
                    controller.send(
                      const GameCommand.declareVictory(),
                      actAsPlayerId: actingPlayerId,
                    );
                  },
            child: Text(l10n.canWin),
          ),
          OutlinedButton(
            onPressed: busy
                ? null
                : () => controller.send(
                    const GameCommand.resumeBattle(),
                    actAsPlayerId: actingPlayerId,
                  ),
            child: Text(l10n.resumeBattle),
          ),
          if (allowEscape)
            TextButton(
              onPressed: busy
                  ? null
                  : () => controller.send(
                      const GameCommand.startEscape(),
                      actAsPlayerId: actingPlayerId,
                    ),
              child: Text(l10n.escape),
            ),
        ],
      ],
    );
  }
}

class _DiceResult extends StatelessWidget {
  const _DiceResult({required this.game, required this.roll});

  final GameState game;
  final DiceRoll roll;

  @override
  Widget build(BuildContext context) {
    final player = game.playerById(roll.playerId);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.casino, size: 36),
        title: Text(
          AppLocalizations.of(
            context,
          ).diceResult(player?.name ?? '—', roll.value),
        ),
      ),
    );
  }
}
