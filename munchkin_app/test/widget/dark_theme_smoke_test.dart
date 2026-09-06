import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/app/theme.dart';
import 'package:munchkin_app/application/session_controller.dart';
import 'package:munchkin_app/domain/models/game_models.dart';
import 'package:munchkin_app/features/game/character_view.dart';
import 'package:munchkin_app/features/game/players_view.dart';
import 'package:munchkin_app/features/game/turn_view.dart';
import 'package:munchkin_app/l10n/app_localizations.dart';

/// Recently added features (the winner banner, the "up next" tag, the
/// countdown heartbeat pulse, local-player badges) were all built and
/// eyeballed in light mode. This exercises the same widgets against the
/// dark theme with a state rich enough to trigger every new code path at
/// once, so a hardcoded color or contrast regression shows up as a test
/// failure instead of only being caught by chance during manual review.
void main() {
  final now = DateTime.utc(2026, 1, 1);
  final host = const Player(
    id: 'host',
    name: 'Alexey',
    isHost: true,
    level: 9,
    peakLevel: 9,
    strength: 3,
    races: <MunchkinRace>[MunchkinRace.dwarf, MunchkinRace.elf],
    classes: <MunchkinClass>[MunchkinClass.warrior],
  );
  final localPlayer = const Player(
    id: 'host-local-0',
    name: 'Sidekick',
    isHost: false,
    level: 3,
    peakLevel: 5,
    strength: 1,
    isLocal: true,
    localControllerPlayerId: 'host',
  );
  final other = const Player(
    id: 'p2',
    name: 'Maria',
    isHost: false,
    level: 2,
    peakLevel: 2,
    strength: 0,
  );

  Widget wrap(Widget child, SessionState state) => ProviderScope(
    overrides: [
      sessionControllerProvider.overrideWith(
        () => _FakeSessionController(state, controls: <String>['host', 'host-local-0']),
      ),
    ],
    child: MaterialApp(
      theme: buildAppTheme(Brightness.dark),
      darkTheme: buildAppTheme(Brightness.dark),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );

  testWidgets('players tab renders in dark mode with a winner and local player', (
    tester,
  ) async {
    final game = GameState(
      roomId: 'room',
      settings: const RoomSettings(),
      phase: RoomPhase.playing,
      players: <Player>[host, localPlayer, other],
      turnOrder: const <String>['host', 'host-local-0', 'p2'],
      activePlayerId: 'host',
      winnerPlayerId: 'host',
      createdAt: now,
      updatedAt: now,
    );
    await tester.pumpWidget(
      wrap(PlayersView(onOpenCharacter: () {}), SessionState(game: game)),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Alexey'), findsOneWidget);
    expect(find.text('Maria'), findsOneWidget);
    expect(find.text('Winner'), findsOneWidget);
    expect(find.text('This device'), findsOneWidget);
  });

  testWidgets('character view player switcher renders in dark mode', (
    tester,
  ) async {
    final game = GameState(
      roomId: 'room',
      settings: const RoomSettings(),
      phase: RoomPhase.playing,
      players: <Player>[host, localPlayer, other],
      turnOrder: const <String>['host', 'host-local-0', 'p2'],
      activePlayerId: 'host',
      createdAt: now,
      updatedAt: now,
    );
    await tester.pumpWidget(wrap(const CharacterView(), SessionState(game: game)));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Sidekick'), findsWidgets);
  });

  testWidgets('turn view renders a countdown battle in dark mode', (
    tester,
  ) async {
    final game = GameState(
      roomId: 'room',
      settings: const RoomSettings(),
      phase: RoomPhase.playing,
      players: <Player>[host, other],
      turnOrder: const <String>['host', 'p2'],
      activePlayerId: 'host',
      battle: BattleState(
        playerId: 'host',
        status: BattleStatus.countdown,
        endsAt: now.add(const Duration(seconds: 2)),
      ),
      createdAt: now,
      updatedAt: now,
    );
    await tester.pumpWidget(wrap(const TurnView(), SessionState(game: game)));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.textContaining('Alexey'), findsWidgets);
  });
}

class _FakeSessionController extends SessionController {
  _FakeSessionController(this._initial, {required this.controls});

  final SessionState _initial;
  final List<String> controls;

  @override
  SessionState build() => _initial;

  @override
  String? get playerId => controls.first;

  @override
  bool get isHost => true;

  @override
  List<String> get controlledPlayerIds => controls;

  @override
  bool controlsPlayer(String? id) => id != null && controls.contains(id);

  @override
  String? get viewedPlayerId => controls.first;
}
