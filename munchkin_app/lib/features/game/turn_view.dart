import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
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
    final isActive = controller.playerId == game.activePlayerId;
    final roll = game.lastDiceRoll;
    final appeal = game.diceAppeal;
    final appealPending = appeal?.status == DiceAppealStatus.pending;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        if (active != null)
          Text(
            l10n.activePlayer(active.name),
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _BattlePanel(
              game: game,
              isActive: isActive,
              busy: session.busy,
              remainingSeconds: _remaining(game.battle?.endsAt),
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (roll != null) _DiceResult(game: game, roll: roll),
        if (roll?.cheatedBy != null &&
            !roll!.finalized &&
            controller.playerId != roll.cheatedBy &&
            appeal == null) ...<Widget>[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: session.busy
                ? null
                : () => controller.send(const GameCommand.appealCheatDie()),
            icon: const Icon(Icons.gavel),
            label: Text(l10n.appealCheatDie),
          ),
        ],
        if (controller.isHost && appealPending) ...<Widget>[
          const SizedBox(height: 8),
          Text(l10n.diceAppealPending, textAlign: TextAlign.center),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  onPressed: session.busy
                      ? null
                      : () => controller.send(
                          const GameCommand.resolveDiceAppeal(true),
                        ),
                  child: Text(l10n.restoreOriginalRoll),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: session.busy
                      ? null
                      : () => controller.send(
                          const GameCommand.resolveDiceAppeal(false),
                        ),
                  child: Text(l10n.keepCheatRoll),
                ),
              ),
            ],
          ),
        ] else if (appealPending) ...<Widget>[
          const SizedBox(height: 8),
          Text(l10n.diceAppealPending, textAlign: TextAlign.center),
        ],
        if (isActive &&
            roll?.playerId == controller.playerId &&
            roll?.cheatedBy == null &&
            !appealPending) ...<Widget>[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: session.busy
                ? null
                : () => _sendSelectedDie(context, controller, cheat: true),
            icon: const Icon(Icons.auto_fix_high),
            label: Text(l10n.useCheatDie),
          ),
        ],
        if (isActive &&
            game.battle?.status != BattleStatus.escaping &&
            !appealPending) ...<Widget>[
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: session.busy
                ? null
                : game.settings.diceMode == DiceMode.virtual
                ? () => controller.send(const GameCommand.rollDice())
                : () => _sendSelectedDie(context, controller, cheat: false),
            icon: const Icon(Icons.casino),
            label: Text(
              game.settings.diceMode == DiceMode.virtual
                  ? l10n.rollDice
                  : l10n.recordPhysicalRoll,
            ),
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

  Future<void> _sendSelectedDie(
    BuildContext context,
    SessionController controller, {
    required bool cheat,
  }) async {
    final value = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: <Widget>[
              for (var value = 1; value <= 6; value++)
                FilledButton.tonal(
                  onPressed: () => Navigator.pop(context, value),
                  child: Text('$value'),
                ),
            ],
          ),
        ),
      ),
    );
    if (value == null) return;
    await controller.send(
      cheat
          ? GameCommand.useCheatDie(value)
          : GameCommand.recordPhysicalRoll(value),
    );
  }
}

class _BattlePanel extends ConsumerWidget {
  const _BattlePanel({
    required this.game,
    required this.isActive,
    required this.busy,
    required this.remainingSeconds,
  });

  final GameState game;
  final bool isActive;
  final bool busy;
  final int remainingSeconds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(sessionControllerProvider.notifier);
    final battle = game.battle;
    if (battle == null) {
      if (!isActive) return Center(child: Text(l10n.waitingForHost));
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FilledButton.icon(
            onPressed: busy
                ? null
                : () => controller.send(const GameCommand.startBattle()),
            icon: const Icon(Icons.shield),
            label: Text(l10n.startBattle),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: busy
                ? null
                : () => controller.send(const GameCommand.endTurn()),
            child: Text(l10n.endTurn),
          ),
        ],
      );
    }

    switch (battle.status) {
      case BattleStatus.fighting:
        if (!isActive) return Center(child: Text(l10n.currentTurn));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FilledButton(
              onPressed:
                  busy || game.diceAppeal?.status == DiceAppealStatus.pending
                  ? null
                  : () => controller.send(const GameCommand.declareVictory()),
              child: Text(l10n.canWin),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: busy
                  ? null
                  : () => _showCannotWin(context, controller),
              child: Text(l10n.cannotWin),
            ),
          ],
        );
      case BattleStatus.countdown:
        return Column(
          children: <Widget>[
            Text(
              l10n.victoryCountdown(remainingSeconds),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
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
        );
      case BattleStatus.helpRequested:
        return _ResumePanel(
          message: l10n.helpRequested,
          active: isActive,
          busy: busy,
          allowEscape: true,
        );
      case BattleStatus.escaping:
        if (!isActive) return Center(child: Text(l10n.escapingNow));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              game.settings.diceMode == DiceMode.physical
                  ? l10n.physicalDice
                  : l10n.escapingNow,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: busy || game.lastDiceRoll != null
                  ? null
                  : game.settings.diceMode == DiceMode.virtual
                  ? () => controller.send(const GameCommand.rollDice())
                  : () => _recordPhysicalRoll(context, controller),
              icon: const Icon(Icons.casino),
              label: Text(
                game.settings.diceMode == DiceMode.virtual
                    ? l10n.rollDice
                    : l10n.recordPhysicalRoll,
              ),
            ),
            FilledButton(
              onPressed:
                  busy || game.diceAppeal?.status == DiceAppealStatus.pending
                  ? null
                  : () => controller.send(const GameCommand.resolveEscape()),
              child: Text(l10n.finishEscape),
            ),
            TextButton(
              onPressed: busy
                  ? null
                  : () => controller.send(const GameCommand.resumeBattle()),
              child: Text(l10n.resumeBattle),
            ),
          ],
        );
      case BattleStatus.won:
        if (!isActive) return Center(child: Text(l10n.battleWon));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              l10n.battleWon,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            if (!battle.levelRewardClaimed)
              OutlinedButton.icon(
                onPressed: busy
                    ? null
                    : () => controller.send(const GameCommand.raiseLevel()),
                icon: const Icon(Icons.arrow_upward),
                label: Text(l10n.raiseLevel),
              )
            else
              Text(l10n.levelRewardClaimed, textAlign: TextAlign.center),
            FilledButton(
              onPressed: busy
                  ? null
                  : () => controller.send(const GameCommand.finishBattle()),
              child: Text(l10n.finishBattle),
            ),
          ],
        );
      case BattleStatus.endedWithoutVictory:
        if (!isActive) return Center(child: Text(l10n.escapingNow));
        return FilledButton(
          onPressed: busy || game.diceAppeal?.status == DiceAppealStatus.pending
              ? null
              : () => controller.send(const GameCommand.finishBattle()),
          child: Text(l10n.finishBattle),
        );
    }
  }

  Future<void> _recordPhysicalRoll(
    BuildContext context,
    SessionController controller,
  ) async {
    final value = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            spacing: 8,
            children: <Widget>[
              for (var value = 1; value <= 6; value++)
                FilledButton.tonal(
                  onPressed: () => Navigator.pop(context, value),
                  child: Text('$value'),
                ),
            ],
          ),
        ),
      ),
    );
    if (value != null) {
      await controller.send(GameCommand.recordPhysicalRoll(value));
    }
  }

  Future<void> _showCannotWin(
    BuildContext context,
    SessionController controller,
  ) async {
    final l10n = AppLocalizations.of(context);
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FilledButton.tonal(
                onPressed: () {
                  Navigator.pop(context);
                  controller.send(const GameCommand.requestHelp());
                },
                child: Text(l10n.requestHelp),
              ),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: () {
                  Navigator.pop(context);
                  controller.send(const GameCommand.startEscape());
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

class _ResumePanel extends ConsumerWidget {
  const _ResumePanel({
    required this.message,
    required this.active,
    required this.busy,
    this.allowEscape = false,
  });

  final String message;
  final bool active;
  final bool busy;
  final bool allowEscape;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(sessionControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(message, textAlign: TextAlign.center),
        if (active) ...<Widget>[
          const SizedBox(height: 12),
          FilledButton(
            onPressed: busy
                ? null
                : () => controller.send(const GameCommand.declareVictory()),
            child: Text(l10n.canWin),
          ),
          OutlinedButton(
            onPressed: busy
                ? null
                : () => controller.send(const GameCommand.resumeBattle()),
            child: Text(l10n.resumeBattle),
          ),
          if (allowEscape)
            TextButton(
              onPressed: busy
                  ? null
                  : () => controller.send(const GameCommand.startEscape()),
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
        subtitle: roll.cheatedBy == null
            ? null
            : Text(
                '${AppLocalizations.of(context).originalRoll}: '
                '${roll.originalValue} · '
                '${AppLocalizations.of(context).cheatDieApplied}',
              ),
      ),
    );
  }
}
