import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../app/theme.dart';
import '../../application/session_controller.dart';
import '../../domain/commands/game_command.dart';
import '../../domain/models/game_models.dart';
import '../../l10n/app_localizations.dart';
import '../game/character_view.dart';
import '../game/players_view.dart';
import '../game/turn_view.dart';

class RoomScreen extends ConsumerStatefulWidget {
  const RoomScreen({super.key});

  @override
  ConsumerState<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends ConsumerState<RoomScreen> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(
      sessionControllerProvider.select((value) => value.error),
      (previous, next) {
        if (next == null || next == previous) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next)));
      },
    );
    final session = ref.watch(sessionControllerProvider);
    final game = session.game;
    if (game == null) {
      return Scaffold(
        body: Center(
          child: FilledButton(
            onPressed: () => context.go('/'),
            child: Text(AppLocalizations.of(context).leave),
          ),
        ),
      );
    }
    if (game.phase == RoomPhase.ended) return const _EndedView();
    if (game.phase != RoomPhase.playing) return const _LobbyView();
    return _GameShell(
      index: _index,
      onIndexChanged: (value) => setState(() => _index = value),
    );
  }
}

Future<bool> _confirmEndGame(
  BuildContext context,
  AppLocalizations l10n,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.endGame),
      content: Text(l10n.endGameConfirm),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.endGame),
        ),
      ],
    ),
  );
  return result ?? false;
}

Future<void> _addLocalPlayerDialog(
  BuildContext context,
  AppLocalizations l10n,
  SessionController controller,
) async {
  final nameController = TextEditingController();
  final name = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.addLocalPlayerTitle),
      content: TextField(
        controller: nameController,
        autofocus: true,
        maxLength: 24,
        decoration: InputDecoration(labelText: l10n.playerNameLabel),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, nameController.text.trim()),
          child: Text(l10n.addLocalPlayer),
        ),
      ],
    ),
  );
  nameController.dispose();
  if (name == null || name.isEmpty) return;
  await controller.send(GameCommand.addLocalPlayer(name: name));
}

Future<bool> _confirmRemovePlayer(
  BuildContext context,
  AppLocalizations l10n,
  String playerName,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.removePlayer),
      content: Text(l10n.removePlayerConfirm(playerName)),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.removePlayer),
        ),
      ],
    ),
  );
  return result ?? false;
}

class _LobbyView extends ConsumerWidget {
  const _LobbyView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider);
    final game = session.game!;
    final controller = ref.read(sessionControllerProvider.notifier);
    final isHost = controller.isHost;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.waitingForPlayers),
        actions: <Widget>[
          IconButton(
            tooltip: isHost ? l10n.endGame : l10n.leave,
            onPressed: session.busy
                ? null
                : () async {
                    if (isHost) {
                      if (!await _confirmEndGame(context, l10n)) return;
                      await controller.send(const GameCommand.endGame());
                      return;
                    }
                    await controller.leave();
                    if (context.mounted) context.go('/');
                  },
            icon: Icon(isHost ? Icons.stop_circle_outlined : Icons.logout),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: <Widget>[
          if (game.phase == RoomPhase.lobby && isHost) const _InviteCard(),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        l10n.players,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _CountBadge(count: game.players.length),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  if (game.phase == RoomPhase.ordering)
                    _OrderList(game: game, enabled: isHost && !session.busy)
                  else
                    ...game.players.map(
                      (player) {
                        final canRemove =
                            isHost || controller.controlsPlayer(player.id);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor: player.isConnected
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer
                                  : Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                              child: Icon(
                                player.isLocal
                                    ? Icons.smartphone
                                    : player.isConnected
                                    ? Icons.person
                                    : Icons.person_off,
                                color: player.isConnected
                                    ? Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer
                                    : Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            title: Text(player.name),
                            subtitle: Text(
                              player.isLocal
                                  ? l10n.localPlayerTag
                                  : player.isConnected
                                  ? l10n.connected
                                  : l10n.offline,
                            ),
                            trailing: player.isHost
                                ? const Icon(
                                    Icons.admin_panel_settings_outlined,
                                  )
                                : canRemove
                                ? IconButton(
                                    tooltip: l10n.removePlayer,
                                    onPressed: session.busy
                                        ? null
                                        : () async {
                                            if (!await _confirmRemovePlayer(
                                              context,
                                              l10n,
                                              player.name,
                                            )) {
                                              return;
                                            }
                                            await controller.send(
                                              GameCommand.removePlayer(
                                                player.id,
                                              ),
                                            );
                                          },
                                    icon: const Icon(
                                      Icons.person_remove_outlined,
                                    ),
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  if (game.phase == RoomPhase.lobby) ...<Widget>[
                    const SizedBox(height: AppSpacing.sm),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton.icon(
                        onPressed: session.busy
                            ? null
                            : () => _addLocalPlayerDialog(
                                context,
                                l10n,
                                controller,
                              ),
                        icon: const Icon(Icons.person_add_alt_1),
                        label: Text(l10n.addLocalPlayer),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (!isHost)
            Center(
              child: Text(
                game.phase == RoomPhase.lobby
                    ? l10n.waitingForHost
                    : l10n.roomClosed,
              ),
            ),
          if (isHost) ..._hostActions(l10n, game, controller, session.busy),
          if (session.busy) ...<Widget>[
            const SizedBox(height: AppSpacing.md),
            const LinearProgressIndicator(),
          ],
        ],
      ),
    );
  }

  List<Widget> _hostActions(
    AppLocalizations l10n,
    GameState game,
    SessionController controller,
    bool busy,
  ) {
    switch (game.phase) {
      case RoomPhase.lobby:
        return <Widget>[
          FilledButton.icon(
            onPressed: busy
                ? null
                : () => controller.send(const GameCommand.closeLobby()),
            icon: const Icon(Icons.lock_outline),
            label: Text(l10n.closeLobby),
          ),
        ];
      case RoomPhase.ordering:
        return <Widget>[
          OutlinedButton.icon(
            onPressed: busy
                ? null
                : () => controller.send(const GameCommand.shuffleTurnOrder()),
            icon: const Icon(Icons.shuffle),
            label: Text(l10n.shuffle),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: busy
                ? null
                : () => controller.send(const GameCommand.confirmOrder()),
            child: Text(l10n.confirmOrder),
          ),
          TextButton(
            onPressed: busy
                ? null
                : () => controller.send(const GameCommand.reopenLobby()),
            child: Text(l10n.reopenLobby),
          ),
        ];
      case RoomPhase.ready:
        return <Widget>[
          FilledButton.icon(
            onPressed: busy
                ? null
                : () => controller.send(const GameCommand.startGame()),
            icon: const Icon(Icons.play_arrow),
            label: Text(l10n.startGame),
          ),
          TextButton(
            onPressed: busy
                ? null
                : () => controller.send(const GameCommand.reopenLobby()),
            child: Text(l10n.reopenLobby),
          ),
        ];
      case RoomPhase.playing:
      case RoomPhase.ended:
        return const <Widget>[];
    }
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        '$count',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: scheme.onSecondaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _InviteCard extends ConsumerWidget {
  const _InviteCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final invite = ref.watch(sessionControllerProvider).invite!;
    final encoded = invite.toUri().toString();
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.qr_code_2, color: scheme.primary),
                  const SizedBox(width: 6),
                  Text(
                    l10n.roomInvite,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: QrImageView(data: encoded, size: 190),
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  _InviteChip(
                    icon: Icons.dns_outlined,
                    text: '${invite.host}:${invite.port}',
                  ),
                  _InviteChip(icon: Icons.meeting_room, text: invite.roomId),
                  _InviteChip(icon: Icons.password, text: invite.pin),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.hostMustStayOpen,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.xs),
              TextButton.icon(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: encoded));
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(l10n.inviteCopied)));
                  }
                },
                icon: const Icon(Icons.copy),
                label: Text(l10n.copyInvite),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InviteChip extends StatelessWidget {
  const _InviteChip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 220),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 16, color: scheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Flexible(
              child: SelectableText(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderList extends ConsumerWidget {
  const _OrderList({required this.game, required this.enabled});

  final GameState game;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ReorderableListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: game.turnOrder.length,
        onReorderItem: enabled
            ? (oldIndex, newIndex) {
                final order = [...game.turnOrder];
                final id = order.removeAt(oldIndex);
                order.insert(newIndex, id);
                ref
                    .read(sessionControllerProvider.notifier)
                    .send(GameCommand.setTurnOrder(order));
              }
            : (_, _) {},
        itemBuilder: (context, index) {
          final player = game.playerById(game.turnOrder[index])!;
          return ListTile(
            key: ValueKey(player.id),
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(player.name),
            trailing: enabled ? const Icon(Icons.drag_handle) : null,
          );
        },
      );
}

class _GameShell extends ConsumerWidget {
  const _GameShell({required this.index, required this.onIndexChanged});

  final int index;
  final ValueChanged<int> onIndexChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final game = ref.watch(sessionControllerProvider).game!;
    final views = <Widget>[
      PlayersView(onOpenCharacter: () => onIndexChanged(1)),
      const CharacterView(),
      const TurnView(),
    ];
    final destinations = <NavigationDestination>[
      NavigationDestination(
        icon: const Icon(Icons.groups),
        label: l10n.players,
      ),
      NavigationDestination(
        icon: const Icon(Icons.person),
        label: l10n.myCharacter,
      ),
      NavigationDestination(
        icon: const Icon(Icons.shield),
        label: l10n.currentTurn,
      ),
    ];
    final wide = MediaQuery.sizeOf(context).width >= 760;
    final title = game.activePlayer == null
        ? l10n.currentTurn
        : l10n.activePlayer(game.activePlayer!.name);
    final appBar = AppBar(
      title: InkWell(onTap: () => onIndexChanged(2), child: Text(title)),
      actions: <Widget>[const _GameMenu()],
    );
    final body = Column(
      children: <Widget>[
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          child: game.winnerPlayerId != null
              ? const _WinnerBanner()
              : const SizedBox(width: double.infinity),
        ),
        Expanded(
          child: wide
              ? Row(
                  children: <Widget>[
                    NavigationRail(
                      selectedIndex: index,
                      onDestinationSelected: onIndexChanged,
                      labelType: NavigationRailLabelType.all,
                      destinations: destinations
                          .map(
                            (destination) => NavigationRailDestination(
                              icon: destination.icon,
                              label: Text(destination.label),
                            ),
                          )
                          .toList(growable: false),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(child: IndexedStack(index: index, children: views)),
                  ],
                )
              : IndexedStack(index: index, children: views),
        ),
      ],
    );
    if (!wide) {
      return Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: onIndexChanged,
          destinations: destinations,
        ),
      );
    }
    return Scaffold(appBar: appBar, body: body);
  }
}

class _WinnerBanner extends ConsumerWidget {
  const _WinnerBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final game = ref.watch(sessionControllerProvider).game!;
    final winner = game.playerById(game.winnerPlayerId);
    final controller = ref.read(sessionControllerProvider.notifier);
    if (winner == null) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;
    final gold = leaderGold(context);
    return TweenAnimationBuilder<double>(
      key: ValueKey<String>(winner.id),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, (1 - value) * -12),
          child: child,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              gold.withValues(alpha: 0.28),
              gold.withValues(alpha: 0.08),
            ],
          ),
          border: Border(
            bottom: BorderSide(color: gold.withValues(alpha: 0.4)),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.emoji_events_rounded, color: gold, size: 26),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                l10n.gameWinnerAnnouncement(winner.name, winner.level),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (controller.isHost)
              TextButton(
                onPressed: () async {
                  if (await _confirmEndGame(context, l10n)) {
                    await controller.send(const GameCommand.endGame());
                  }
                },
                child: Text(
                  l10n.endGameNow,
                  style: TextStyle(color: scheme.error),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _GameMenu extends ConsumerWidget {
  const _GameMenu();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(sessionControllerProvider.notifier);
    return PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'end') {
          if (await _confirmEndGame(context, l10n)) {
            await controller.send(const GameCommand.endGame());
          }
        }
        if (value == 'leave') {
          await controller.leave();
          if (context.mounted) context.go('/');
        }
      },
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        if (controller.isHost)
          PopupMenuItem(value: 'end', child: Text(l10n.endGame))
        else
          PopupMenuItem(value: 'leave', child: Text(l10n.leave)),
      ],
    );
  }
}

class _EndedView extends ConsumerWidget {
  const _EndedView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              scheme.primaryContainer.withValues(alpha: 0.4),
              scheme.surface,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.flag_circle,
                  size: 56,
                  color: scheme.onPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                AppLocalizations.of(context).gameEnded,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(
                onPressed: () async {
                  await ref.read(sessionControllerProvider.notifier).leave();
                  if (context.mounted) context.go('/');
                },
                child: Text(AppLocalizations.of(context).leave),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
