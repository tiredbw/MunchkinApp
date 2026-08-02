import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/application/session_controller.dart';
import 'package:munchkin_app/core/network/game_connection.dart';
import 'package:munchkin_app/core/network/network_protocol.dart';
import 'package:munchkin_app/domain/models/game_models.dart';
import 'package:munchkin_app/features/room/room_screen.dart';
import 'package:munchkin_app/l10n/app_localizations.dart';

void main() {
  testWidgets('host can show the current invite during a running game', (
    tester,
  ) async {
    await _pumpRoom(tester, game: _playingGame());

    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Show room invite'));
    await tester.pumpAndSettle();

    expect(find.text('Room invite'), findsOneWidget);
    expect(find.textContaining('123456'), findsOneWidget);
    expect(find.textContaining('127.0.0.1:4242'), findsOneWidget);
  });

  testWidgets('turn actions are disabled while a dice appeal is pending', (
    tester,
  ) async {
    final game = _playingGame().copyWith(
      lastDiceRoll: DiceRoll(
        id: 'roll-1',
        playerId: 'host',
        value: 6,
        originalValue: 2,
        source: DiceRollSource.virtual,
        cheatedBy: 'host',
        rolledAt: DateTime.utc(2026, 8, 2),
      ),
      diceAppeal: const DiceAppeal(rollId: 'roll-1', requestedBy: 'alice'),
    );
    await _pumpRoom(tester, game: game);

    await tester.tap(find.text('Current turn'));
    await tester.pumpAndSettle();

    final startBattle = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Start battle'),
    );
    final endTurn = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'End turn'),
    );
    expect(startBattle.onPressed, isNull);
    expect(endTurn.onPressed, isNull);
  });
}

Future<void> _pumpRoom(WidgetTester tester, {required GameState game}) async {
  final initialState = SessionState(
    game: game,
    status: ConnectionStatus.connected,
    invite: const RoomInvite(
      host: '127.0.0.1',
      port: 4242,
      roomId: 'room',
      token: 'token',
      pin: '123456',
    ),
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sessionControllerProvider.overrideWith(
          () => _FakeSessionController(initialState),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const RoomScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

GameState _playingGame() {
  final now = DateTime.utc(2026, 8, 2);
  return GameState(
    roomId: 'room',
    revision: 10,
    settings: const RoomSettings(),
    phase: RoomPhase.playing,
    players: const <Player>[
      Player(id: 'host', name: 'Host', isHost: true, level: 2, strength: 0),
      Player(id: 'alice', name: 'Alice', isHost: false, level: 2, strength: 5),
    ],
    turnOrder: const <String>['host', 'alice'],
    activePlayerId: 'host',
    createdAt: now,
    updatedAt: now,
  );
}

class _FakeSessionController extends SessionController {
  _FakeSessionController(this.initialState);

  final SessionState initialState;

  @override
  SessionState build() => initialState;

  @override
  String? get playerId => 'host';
}
