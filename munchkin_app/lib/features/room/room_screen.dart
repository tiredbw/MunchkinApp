import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
            tooltip: l10n.leave,
            onPressed: session.busy
                ? null
                : () async {
                    await controller.leave();
                    if (context.mounted) context.go('/');
                  },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          if (game.phase == RoomPhase.lobby && isHost) const _InviteCard(),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    l10n.players,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  if (game.phase == RoomPhase.ordering)
                    _OrderList(game: game, enabled: isHost && !session.busy)
                  else
                    ...game.players.map(
                      (player) => ListTile(
                        leading: Icon(
                          player.isConnected ||
                                  player.localControllerPlayerId != null ||
                                  player.isLocalToHost
                              ? Icons.person
                              : Icons.person_off,
                        ),
                        title: Text(player.name),
                        subtitle: Text(
                          player.isConnected
                              ? l10n.connected
                              : player.localControllerPlayerId != null ||
                                    player.isLocalToHost
                              ? l10n.controlledOnDevice(
                                  game
                                          .playerById(
                                            player.localControllerPlayerId,
                                          )
                                          ?.name ??
                                      game.players
                                          .firstWhere(
                                            (candidate) => candidate.isHost,
                                          )
                                          .name,
                                )
                              : l10n.offline,
                        ),
                        trailing: player.isHost
                            ? const Icon(Icons.admin_panel_settings_outlined)
                            : isHost ||
                                  player.localControllerPlayerId ==
                                      controller.primaryPlayerId
                            ? IconButton(
                                tooltip: l10n.removePlayer,
                                onPressed: session.busy
                                    ? null
                                    : () => controller.send(
                                        GameCommand.removePlayer(player.id),
                                      ),
                                icon: const Icon(Icons.person_remove_outlined),
                              )
                            : null,
                      ),
                    ),
                  if (game.phase == RoomPhase.lobby) ...<Widget>[
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: session.busy || game.players.length >= 12
                          ? null
                          : () => _addLocalPlayer(context, controller, game),
                      icon: const Icon(Icons.person_add_alt_1),
                      label: Text(l10n.addLocalPlayer),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
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
            const SizedBox(height: 12),
            const LinearProgressIndicator(),
          ],
        ],
      ),
    );
  }

  Future<void> _addLocalPlayer(
    BuildContext context,
    SessionController controller,
    GameState game,
  ) async {
    final l10n = AppLocalizations.of(context);
    final textController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.addLocalPlayer),
        content: TextField(
          controller: textController,
          autofocus: true,
          maxLength: 24,
          decoration: InputDecoration(labelText: l10n.yourName),
          onSubmitted: (value) => Navigator.pop(dialogContext, value),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, textController.text),
            child: Text(l10n.addLocalPlayer),
          ),
        ],
      ),
    );
    textController.dispose();
    if (name == null || name.trim().isEmpty || !context.mounted) return;
    if (game.players.any(
      (player) => player.name.toLowerCase() == name.trim().toLowerCase(),
    )) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.duplicatePlayerName)));
      return;
    }
    await controller.addLocalPlayer(name);
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

class _InviteCard extends ConsumerWidget {
  const _InviteCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final invite = ref.watch(sessionControllerProvider).invite!;
    final encoded = invite.toUri().toString();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              l10n.roomInvite,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: QrImageView(data: encoded, size: 190),
              ),
            ),
            const SizedBox(height: 12),
            SelectableText('${invite.host}:${invite.port}'),
            SelectableText('${l10n.roomId}: ${invite.roomId}'),
            SelectableText('${l10n.pin}: ${invite.pin}'),
            const SizedBox(height: 8),
            Text(l10n.hostMustStayOpen, textAlign: TextAlign.center),
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
    final session = ref.watch(sessionControllerProvider);
    final game = session.game!;
    final controller = ref.read(sessionControllerProvider.notifier);
    final views = <Widget>[
      const PlayersView(),
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
      actions: <Widget>[
        if (controller.controllablePlayerIds.length > 1)
          PopupMenuButton<String>(
            tooltip: l10n.controlProfile,
            icon: const Icon(Icons.switch_account),
            initialValue: session.selectedPlayerId,
            onSelected: controller.selectPlayer,
            itemBuilder: (context) => controller.controllablePlayerIds
                .map(
                  (id) => PopupMenuItem<String>(
                    value: id,
                    child: Text(game.playerById(id)?.name ?? id),
                  ),
                )
                .toList(growable: false),
          ),
        const _GameMenu(),
      ],
    );
    final content = Column(
      children: <Widget>[
        const _PendingControlRequests(),
        if (controller.controllablePlayerIds.length > 1)
          Material(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.person_pin_circle_outlined),
              title: Text(
                l10n.playingAs(
                  game.playerById(controller.playerId)?.name ?? '',
                ),
              ),
            ),
          ),
        Expanded(
          child: IndexedStack(index: index, children: views),
        ),
      ],
    );
    if (!wide) {
      return Scaffold(
        appBar: appBar,
        body: content,
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: onIndexChanged,
          destinations: destinations,
        ),
      );
    }
    return Scaffold(
      appBar: appBar,
      body: Row(
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
          Expanded(child: content),
        ],
      ),
    );
  }
}

class _PendingControlRequests extends ConsumerWidget {
  const _PendingControlRequests();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider);
    final controller = ref.read(sessionControllerProvider.notifier);
    final game = session.game!;
    final requests = game.controlAssignments
        .where(
          (assignment) =>
              assignment.controllerPlayerId == controller.primaryPlayerId &&
              assignment.status == ControlAssignmentStatus.pending,
        )
        .toList(growable: false);
    if (requests.isEmpty) return const SizedBox.shrink();
    final assignment = requests.first;
    final player = game.playerById(assignment.playerId);
    final l10n = AppLocalizations.of(context);
    return Material(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(l10n.controlRequested(player?.name ?? '')),
            const SizedBox(height: 4),
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 8,
              children: <Widget>[
                TextButton(
                  onPressed: session.busy
                      ? null
                      : () => controller.send(
                          GameCommand.respondControl(
                            playerId: assignment.playerId,
                            accepted: false,
                          ),
                        ),
                  child: Text(l10n.decline),
                ),
                FilledButton.tonal(
                  onPressed: session.busy
                      ? null
                      : () => controller.send(
                          GameCommand.respondControl(
                            playerId: assignment.playerId,
                            accepted: true,
                          ),
                        ),
                  child: Text(l10n.accept),
                ),
              ],
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
        if (value == 'invite') {
          await showDialog<void>(
            context: context,
            builder: (context) => const Dialog(
              child: SingleChildScrollView(child: _InviteCard()),
            ),
          );
        }
        if (value == 'end') await controller.send(const GameCommand.endGame());
        if (value == 'leave') {
          await controller.leave();
          if (context.mounted) context.go('/');
        }
      },
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        if (controller.isHost)
          PopupMenuItem(value: 'invite', child: Text(l10n.showInvite)),
        if (controller.isHost)
          PopupMenuItem(value: 'end', child: Text(l10n.endGame)),
        PopupMenuItem(value: 'leave', child: Text(l10n.leave)),
      ],
    );
  }
}

class _EndedView extends ConsumerWidget {
  const _EndedView();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.flag_circle, size: 72),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).gameEnded,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
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
  );
}
